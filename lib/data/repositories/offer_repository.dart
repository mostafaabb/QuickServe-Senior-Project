import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/core/constants/app_constants.dart';
import 'package:untitled1/data/models/offer_model.dart';

class OfferRepository {
  Future<List<OfferModel>> fetchOffers() async {
    final response = await http.get(Uri.parse('${AppConstants.baseUrl}/offers'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> offers = jsonData['data'];
      return offers.map((e) => OfferModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load offers');
    }
  }
}
