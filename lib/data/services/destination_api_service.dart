import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/destination_api_model.dart';

/// Thin HTTP client that demonstrates the `http` GET pattern.
///
/// Points at a public demo endpoint. In tests/offline the repository falls
/// back to seed data, so a failing network call never blocks the UI.
class DestinationApiService {
  DestinationApiService({http.Client? client, Uri? endpoint})
      : _client = client ?? http.Client(),
        _endpoint = endpoint ??
            Uri.parse('https://jsonplaceholder.typicode.com/posts');

  final http.Client _client;
  final Uri _endpoint;

  Future<List<DestinationApiModel>> fetchDestinations() async {
    final response = await _client.get(_endpoint);
    if (response.statusCode != 200) {
      throw Exception('Falha ao carregar destinos (${response.statusCode})');
    }
    final decoded = json.decode(response.body);
    if (decoded is! List) {
      return const <DestinationApiModel>[];
    }
    return decoded
        .whereType<Map<String, dynamic>>()
        .map(DestinationApiModel.fromJson)
        .toList();
  }
}
