class User {
  int id;
  int roleId;
  String email;
  String lastLogin;
  bool loggedIn;

  User({
    this.id,
    this.roleId,
    this.email,
    this.lastLogin,
    this.loggedIn,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    if(json['id'] == null){
      return User(
        id: 0,
//      roleId: int.tryParse(json['role_id']),
//      email: json['email'],
//      lastLogin: json['last_login'],
        loggedIn: false,
      );


    }
    else {
      return User(
        id: int.tryParse(json['id']),
//      roleId: int.tryParse(json['role_id']),
//      email: json['email'],
//      lastLogin: json['last_login'],
        loggedIn: false,
      );
    }
  }
}