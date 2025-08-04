import 'package:equatable/equatable.dart';

class ScanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScanInitial extends ScanState {}

class ScanInProgress extends ScanState {}

class ScanSuccess extends ScanState {
  final String imagePath;
  final bool isLoading;

  ScanSuccess({required this.imagePath, required this.isLoading});

  @override
  List<Object?> get props => [imagePath, isLoading];
}

class ScanError extends ScanState {
  final String message;

  ScanError(this.message);

  @override
  List<Object?> get props => [message];
}
