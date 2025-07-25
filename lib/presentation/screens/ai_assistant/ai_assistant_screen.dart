import 'package:flutter/material.dart';
import 'package:untitled1/data/datasources/api_service.dart';
import 'package:untitled1/data/models/food_model.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({Key? key}) : super(key: key);

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final ApiService _apiService = ApiService();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, String>> messages = []; // {'role': 'user'/'ai', 'text': '...'}
  List<FoodModel> menu = [];
  bool isLoadingMenu = true;
  bool isLoadingResponse = false;

  @override
  void initState() {
    super.initState();
    loadMenu();
    _controller.addListener(() {
      setState(() {}); // update send button enable state on input change
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> loadMenu() async {
    try {
      final foods = await _apiService.fetchFoods();
      setState(() {
        menu = foods;
        isLoadingMenu = false;
      });
    } catch (e) {
      setState(() {
        isLoadingMenu = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load menu: $e')),
      );
    }
  }

  void addMessage(Map<String, String> message) {
    setState(() {
      messages.add(message);
    });
    // Scroll to bottom after frame renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void sendMessage() async {
    final userMessage = _controller.text.trim();
    if (userMessage.isEmpty || isLoadingMenu || isLoadingResponse) return;

    addMessage({'role': 'user', 'text': userMessage});
    _controller.clear();

    setState(() {
      isLoadingResponse = true;
    });

    try {
      final aiResponse = await _apiService.askAiWithMenu(userMessage, menu);
      addMessage({'role': 'ai', 'text': aiResponse});
    } catch (e) {
      addMessage({'role': 'ai', 'text': 'Error getting AI response.'});
    } finally {
      setState(() {
        isLoadingResponse = false;
      });
    }
  }

  Widget buildMessage(Map<String, String> message, [int? index]) {
    final isUser = message['role'] == 'user';
    final isError = message['text'] == 'Error getting AI response.';

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints:
        BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          color: isUser ? Colors.deepOrange : Colors.orange.shade50,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isUser ? 12 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(1, 1),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message['text'] ?? '',
              style: TextStyle(
                color: isUser ? Colors.white : Colors.deepOrange.shade800,
                fontSize: 16,
              ),
            ),
            if (isError && !isUser && index != null)
              TextButton.icon(
                onPressed: () {
                  if (index == 0) return;
                  final lastUserMessage = messages[index - 1]['text'] ?? '';
                  setState(() {
                    messages.removeAt(index); // remove error message
                    isLoadingResponse = true;
                  });
                  _apiService
                      .askAiWithMenu(lastUserMessage, menu)
                      .then((aiResponse) {
                    addMessage({'role': 'ai', 'text': aiResponse});
                    setState(() {
                      isLoadingResponse = false;
                    });
                  }).catchError((_) {
                    addMessage({'role': 'ai', 'text': 'Error getting AI response.'});
                    setState(() {
                      isLoadingResponse = false;
                    });
                  });
                },
                icon: const Icon(Icons.refresh, color: Colors.deepOrange),
                label: Text(
                  'Retry',
                  style: TextStyle(color: Colors.deepOrange),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.deepOrange,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickReply(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ActionChip(
        backgroundColor: Colors.orange.shade200,
        label: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: () {
          if (isLoadingMenu || isLoadingResponse) return;
          _controller.text = text;
          sendMessage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSendDisabled = isLoadingMenu ||
        isLoadingResponse ||
        _controller.text.trim().isEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('AI Assistant'),
      ),
      body: Column(
        children: [
          if (isLoadingMenu) const LinearProgressIndicator(color: Colors.deepOrange),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: messages.length,
              itemBuilder: (context, index) =>
                  buildMessage(messages[index], index),
            ),
          ),

          // Typing indicator
          if (isLoadingResponse)
            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 16),
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'AI is typing...',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.deepOrange.shade400,
                    ),
                  ),
                ],
              ),
            ),

          // Quick replies
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                _buildQuickReply('Show me vegan options'),
                _buildQuickReply('What are today\'s specials?'),
                _buildQuickReply('Recommend desserts'),
              ],
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => sendMessage(),
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                        hintText: 'Ask something...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepOrange),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      ),
                      enabled: !isLoadingMenu && !isLoadingResponse,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: isSendDisabled ? Colors.orange.shade200 : Colors.deepOrange,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send),
                      color: Colors.white,
                      onPressed: isSendDisabled ? null : sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
