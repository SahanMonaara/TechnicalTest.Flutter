import 'package:equatable/equatable.dart';

abstract class OfflineEvent extends Equatable {
  const OfflineEvent();

  @override
  List<Object?> get props => [];
}

class OfflinePostsRequested extends OfflineEvent {}

class OfflineCountRequested extends OfflineEvent {}
