import '../../domain/entities/user_entitites.dart';

class UserModel extends User {
  
  UserModel(
      {required String email,
      required String name,
      required String phone,
      required String uid})
      : super(email: email, name: name, phone: phone, uid: uid);

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        email: map['email'],
        name: map['name'],
        phone: map['phone'],
        uid: map['uid']);
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'name': name, 'email': email, 'phone': phone};
  }
}
