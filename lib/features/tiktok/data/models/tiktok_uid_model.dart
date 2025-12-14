import '../../domain/entities/tiktok_uid_entity.dart';

class TiktokUidModel extends TiktokUidEntity {
  const TiktokUidModel({required super.uid});

  factory TiktokUidModel.fromJson(Map<String, dynamic> json) {
    String extractedUid = '';

    if (json['data'] != null && json['data']['id'] != null) {
      extractedUid = json['data']['id'].toString();
    }

    return TiktokUidModel(uid: extractedUid);
  }
}
