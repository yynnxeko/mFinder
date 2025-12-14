import 'package:equatable/equatable.dart';

class FacebookUidParams extends Equatable {
  final String profileUrl;

  const FacebookUidParams({required this.profileUrl});

  @override
  List<Object> get props => [profileUrl];
}
