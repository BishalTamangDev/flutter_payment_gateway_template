import 'package:payment_gateways_template/core/business/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.name});

  // from json
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(id: json['id'] ?? '0', name: json['name'] ?? '');

  // to json
  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  // from entity
  factory UserModel.fromEntity(UserEntity entity) => UserModel(id: entity.id, name: entity.name);

  // to entity
  UserEntity toEntity() => UserEntity(id: id, name: name);

  // to string
  @override
  String toString() => "UserMode{id: $id, name: $name}";
}
