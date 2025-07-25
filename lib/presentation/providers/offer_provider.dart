import 'package:flutter/material.dart';
import 'package:untitled1/data/models/offer_model.dart';
import 'package:untitled1/data/repositories/offer_repository.dart';

class OfferProvider with ChangeNotifier {
  final OfferRepository _repository = OfferRepository();

  List<OfferModel> _offers = [];
  List<OfferModel> get offers => _offers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadOffers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedOffers = await _repository.fetchOffers();
      _offers = fetchedOffers;
    } catch (e, stacktrace) {
      debugPrint('Failed to load offers: $e');
      debugPrint('$stacktrace');
      _offers = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
