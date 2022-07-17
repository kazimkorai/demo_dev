class Model {
  bool? success;
  List<String>? message;
  User? user;
  String? token;
  String? tokenExpiresAt;
  List<String>? roles;

  Model(
      {this.success,
        this.message,
        this.user,
        this.token,
        this.tokenExpiresAt,
        this.roles});

  Model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'].cast<String>();
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
    tokenExpiresAt = json['token_expires_at'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    data['token_expires_at'] = this.tokenExpiresAt;
    data['roles'] = this.roles;
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? emailVerified;
  String? contactNo;
  String? contactNoVerified;
  String? active;
  Null? countryId;
  String? createdAt;
  List<Roles>? roles;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.emailVerified,
        this.contactNo,
        this.contactNoVerified,
        this.active,
        this.countryId,
        this.createdAt,
        this.roles});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailVerified = json['email_verified'];
    contactNo = json['contact_no'];
    contactNoVerified = json['contact_no_verified'];
    active = json['active'];
    countryId = json['country_id'];
    createdAt = json['created_at'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['email_verified'] = this.emailVerified;
    data['contact_no'] = this.contactNo;
    data['contact_no_verified'] = this.contactNoVerified;
    data['active'] = this.active;
    data['country_id'] = this.countryId;
    data['created_at'] = this.createdAt;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  int? id;
  String? name;
  String? createdAt;
  Pivot? pivot;

  Roles({this.id, this.name, this.createdAt, this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  String? userId;
  String? roleId;

  Pivot({this.userId, this.roleId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    return data;
  }
}