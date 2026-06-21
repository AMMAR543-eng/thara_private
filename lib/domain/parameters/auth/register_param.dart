class SignUpParam {
  final String? email;
  final String? password;
  final String? passwordConfirm;
  final String? type;

  SignUpParam({
    this.email,
    this.password,
    this.passwordConfirm,
    this.type,
  });

  factory SignUpParam.fromJson(Map<String, dynamic> json) {
    return SignUpParam(
      email: json['email'] as String?,
      password: json['password'] as String?,
      passwordConfirm: json['password_confirmation'] as String?,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (passwordConfirm != null) 'password_confirmation': passwordConfirm,
      if (type != null) 'type': type,
      'apply_as': 'investor', // Always sent
    };
    return data;
  }

  SignUpParam copyWith({
    String? email,
    String? password,
    String? passwordConfirm,
    String? type,
  }) {
    return SignUpParam(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      type: type ?? this.type,
    );
  }
}
