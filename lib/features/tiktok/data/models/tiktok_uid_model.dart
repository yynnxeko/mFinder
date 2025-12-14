import '../../domain/entities/tiktok_uid_entity.dart';

class TiktokUidModel extends TiktokUidEntity {
  const TiktokUidModel({required super.uid});
  factory TiktokUidModel.fromJson(Map<String, dynamic> json) {
    // Backend trả về response với cấu trúc: {success, uid, videoId, message, data}
    print('🔄 Parsing TikTok response: $json');
    
    String extractedUid = '';
    
    // Thử các trường có thể chứa UID theo thứ tự ưu tiên
    if (json['uid'] != null && json['uid'].toString().isNotEmpty) {
      extractedUid = json['uid'].toString();
      print('✅ Found UID in "uid" field: $extractedUid');
    } else if (json['videoId'] != null && json['videoId'].toString().isNotEmpty) {
      extractedUid = json['videoId'].toString();
      print('✅ Found UID in "videoId" field: $extractedUid');
    } else if (json['data'] != null && json['data']['extractedVideoId'] != null) {
      extractedUid = json['data']['extractedVideoId'].toString();
      print('✅ Found UID in "data.extractedVideoId" field: $extractedUid');
    } else if (json['data'] != null && json['data']['uid'] != null) {
      extractedUid = json['data']['uid'].toString();
      print('✅ Found UID in "data.uid" field: $extractedUid');
    } else {
      print('❌ No UID found in response');
    }
    
    return TiktokUidModel(uid: extractedUid);
  }
}