class UserModel {
  String? _id;
  late String _firstName;
  late String _lastName;
  late String _phone;
  late String _email;
  late String _cnic;
  late String _password;
  late String _photoUrl;

  //constructor for add
  UserModel(this._firstName, this._lastName, this._phone, this._email,
      this._cnic, this._password, this._photoUrl);

  //Constructor for edit
  UserModel.withId(this._id, this._firstName, this._lastName, this._phone,
      this._email, this._cnic, this._password, this._photoUrl);

  //getters
  String? get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get phone => _phone;
  String get email => _email;
  String get cnic => _cnic;
  String get password => _password;
  String get photoUrl => _photoUrl;

  //Setters
  set setFirstName(String firstName) {
    _firstName = firstName;
  }

  set setLastName(String lastName) {
    _lastName = lastName;
  }

  set setPhone(String phone) {
    _phone = phone;
  }

  set setEmail(String email) {
    _email = email;
  }

  set setCnic(String cnic) {
    _cnic = cnic;
  }

  set setPassword(String password) {
    _password = password;
  }

  set setPhotoUrl(String photoUrl) {
    _photoUrl = photoUrl;
  }
}
