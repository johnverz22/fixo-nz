import '../../domain/entities/user.dart';

class UserModel extends User {
  
  UserModel({
    required super.id, 
    required super.username, 
    required super.email, 
    required super.phoneNumber, 
    required super.role, 
    required super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
  return UserModel(

    id: json.containsKey('id') && json['id'] != null
        ? int.tryParse(json['id'].toString()) ?? 0
        : 0, // Ensure id is always an int

    username: json['username'] ?? 'Unknown',
    email: json['email'] ?? 'No Email',
    phoneNumber: json['phone'] ?? 'No Phone',
    role: json['role'] ?? 'No Role',
    token: json['token'] ?? '', // Token might be empty but shouldn't be null
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phoneNumber,
      'role': role,
      'token': token
    };
  }
}
