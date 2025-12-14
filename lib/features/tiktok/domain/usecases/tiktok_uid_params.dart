import 'package:equatable/equatable.dart';

class TiktokUidParams extends Equatable {
  final String profileUrl;

  const TiktokUidParams({required this.profileUrl});

  @override
  List<Object> get props => [profileUrl];
}
