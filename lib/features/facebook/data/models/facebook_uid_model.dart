import '../../domain/entities/facebook_uid_entity.dart';

class FacebookUidModel extends FacebookUidEntity {
  /// Constructor nên khai báo const để đồng bộ với entity
  const FacebookUidModel({required super.uid});
  factory FacebookUidModel.fromJson(Map<String, dynamic> json) {
    // API trả về: {"success":true,"data":{"id":"1282720130560474"}}
    String extractedUid = '';
    
    if (json['data'] != null && json['data']['id'] != null) {
      extractedUid = json['data']['id'].toString();
    }
    
    return FacebookUidModel(uid: extractedUid);
  }
}