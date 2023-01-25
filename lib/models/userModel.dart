class UserModel {
  final int? id;
  final String? name;
  final String? email;

  UserModel({this.id, this.name, this.email});

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
      );

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email};
  }
}
