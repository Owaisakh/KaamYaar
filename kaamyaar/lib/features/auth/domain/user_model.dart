import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

enum UserRole {
  customer,
  worker,
  admin,
}

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String phone,
    String? name,
    UserRole? role,
    DateTime? createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
