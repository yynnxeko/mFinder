import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class FacebookUidEntity extends Equatable {
  final String uid;

  /// Constructor nên khai báo const để hết cảnh báo
  const FacebookUidEntity({required this.uid});

  @override
  List<Object> get props => [uid];
}