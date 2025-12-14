import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../network/api_client.dart';
import '../network/network_info.dart';

// Shared core providers
final networkInfoProvider = Provider<NetworkInfo>((ref) => NetworkInfoImpl(Connectivity()));
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient(client: http.Client())); // Use real API backend
