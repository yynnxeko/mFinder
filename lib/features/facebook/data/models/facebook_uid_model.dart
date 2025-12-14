import '../../domain/entities/facebook_uid_entity.dart';

class FacebookUidModel extends FacebookUidEntity {
  /// Constructor nên khai báo const để đồng bộ với entity
  const FacebookUidModel({required super.uid});

  factory FacebookUidModel.fromJson(Map<String, dynamic> json) {
    // Backend trả về response với cấu trúc: {success, uid, message, data}
    return FacebookUidModel(
      uid: json['uid'] ?? json['data']?['extractedUid'] ?? '',
    );
  }
}