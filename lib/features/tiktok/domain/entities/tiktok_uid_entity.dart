import 'package:equatable/equatable.dart';

class TiktokUidEntity extends Equatable {
  final String uid;

  const TiktokUidEntity({required this.uid});

  @override
  List<Object> get props => [uid];
}