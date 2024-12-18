
class UserModel {
  final int? id;
  final String? email;
  final String? firstname;
  final String? lastname;
  final String? birthdate;
  final String? biography;
  final String? position;
  final String? createdAt;
  final String? updatedAt;

  const UserModel({
    this.id,
    this.email,
    this.firstname,
    this.lastname,
    this.birthdate,
    this.biography,
    this.position,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] != null ? int.parse(json['id'].toString()) : null,
        email: json['email']?.toString(),
        firstname: json['firstname']?.toString(),
        lastname: json['lastname']?.toString(),
        birthdate: json['birthdate']?.toString(),
        biography: json['biography']?.toString(),
        position: json['position']?.toString(),
        createdAt: json['created_at']?.toString(),
        updatedAt: json['updated_at']?.toString(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["firstname"] = firstname;
    data["lastname"] = lastname;
    data["birthdate"] = birthdate;
    data["biography"] = biography;
    data["position"] = position;
    return data;
  }

}
