import 'package:equatable/equatable.dart';

class GradeModel extends Equatable {
  const GradeModel({
    required this.id,
    required this.name,
    this.isActive = true,
  });

  final String id;
  final String name;
  final bool isActive;

  String get statusLabel => isActive ? 'مفعل' : 'موقوف';

  GradeModel copyWith({String? name, bool? isActive}) {
    return GradeModel(
      id: id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => <Object?>[id, name, isActive];
}
