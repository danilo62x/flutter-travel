import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/hotel_api_model.dart';

/// Thin HTTP client that demonstrates the `http` GET pattern for stays.
///
/// Points at a public demo endpoint. In tests/offline the repository falls
/// back to seed data, so a failing network call never blocks the UI.
class HotelApiService {
  HotelApiService({http.Client? client, Uri? endpoint})
      : _client = client ?? http.Client(),
        _endpoint =
            endpoint ?? Uri.parse('https://jsonplaceholder.typicode.com/posts');

  final http.Client _client;
  final Uri _endpoint;

  Future<List<HotelApiModel>> fetchHotels() async {
    final response = await _client.get(_endpoint);
    if (response.statusCode != 200) {
      throw Exception('Falha ao carregar hotéis (${response.statusCode})');
    }
    final decoded = json.decode(response.body);
    if (decoded is! List) {
      return const <HotelApiModel>[];
    }
    return decoded
        .whereType<Map<String, dynamic>>()
        .map(HotelApiModel.fromJson)
        .toList();
  }
}
