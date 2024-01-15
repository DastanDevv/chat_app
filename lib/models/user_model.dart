class User {
  User({
    required this.uid,
    required this.email,
    required this.password,
    // this.isGroup = false,
  });
  final String email;
  final String password;
  final String uid;
  // final bool isGroup;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'uid': uid,
      // 'isGroup': isGroup,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      password: map['password'] as String,
      uid: map['uid'] as String,
      // isGroup: map['isGroup'] as bool,
    );
  }
}
