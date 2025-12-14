import 'dart:convert';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/constants.dart';
import '../models/facebook_uid_model.dart';

abstract class FacebookRemoteDataSource {
  Future<FacebookUidModel> getFacebookUid(String profileUrl);
}

class FacebookRemoteDataSourceImpl implements FacebookRemoteDataSource {
  final ApiClient apiClient;

  FacebookRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<FacebookUidModel> getFacebookUid(String profileUrl) async {
    final response = await apiClient.post(ApiEndpoints.facebookUid, {'url': profileUrl});
    
    final responseData = json.decode(response.body);
    
    if (response.statusCode == 200) {
      // Kiểm tra success field từ backend
      if (responseData['success'] == true) {
        return FacebookUidModel.fromJson(responseData);
      } else {
        throw ServerException(responseData['message'] ?? 'Unknown error');
      }
    } else if (response.statusCode == 400 || response.statusCode == 500) {
      final errorMessage = responseData['message'] ?? responseData['error'] ?? 'Server error';
      throw ServerException('Error ${response.statusCode}: $errorMessage');
    } else {
      throw ServerException('Failed: ${response.reasonPhrase}');
    }
  }
}