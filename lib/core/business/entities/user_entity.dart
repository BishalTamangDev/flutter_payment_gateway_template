class UserEntity {
  String? id;
  String? name;

  UserEntity({required this.id, required this.name});

  @override
  String toString() => "UserEntity(id: $id, name: $name)";
}
