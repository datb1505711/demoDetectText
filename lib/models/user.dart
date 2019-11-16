class User {
  String _username,
      _password,
      _name,
      _email,
      _phoneNumber,
      _gender,
      _accessToken;

  /// Constructor User
  User(
      {String username,
      String password,
      String name,
      String email,
      String phoneNumber,
      String gender,
      String accessToken})
      : this._username = username,
        this._password = password,
        this._name = name,
        this._phoneNumber = phoneNumber,
        this._gender = gender,
        this._email = email,
        this._accessToken = accessToken;

  /// Load user data from JSON
  User.fromJSON(Map<String, dynamic> json)
      : _username = json['username'] ?? "",
        _password = json['password'] ?? "",
        _name = json['name'] ?? "",
        _email = json['email'] ?? "",
        _phoneNumber = json['phone_number'] ?? "",
        _gender = json['gender'] ?? "",
        _accessToken = json['access_token'] ?? "";

  /// Getters
  String get username => this._username;
  String get password => this._password;
  String get name => this._name;
  String get email => this._email;
  String get phoneNumber => this._phoneNumber;
  String get gender => this._gender;
  String get accessToken => this._accessToken;

  /// Setters
  set username(String username) => this._username = username;
  set password(String password) => this._username = username;
  set name(String name) => this._name = name;
  set gender(String gender) => this._gender = gender;
  set email(String email) => this.email = email;
  set phoneNumber(String phoneNumber) => this._phoneNumber = phoneNumber;
  set accessToken(String accessToken) => this._username = username;

  @override
  toString() =>
      "User: {username: $username, password: $password, name: $name, gender: $gender, phoneNumber: $phoneNumber, email: $email, accessToken: $accessToken}";
}
