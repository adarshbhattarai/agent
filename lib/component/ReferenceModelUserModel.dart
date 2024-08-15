class UserModel {

  /// Document ID of the user on database
  String _firebaseId = "";
  String get firebaseId => _firebaseId;
  set firebaseId(newValue) => _firebaseId = newValue;

  DateTime _creationDate = DateTime.now();
  DateTime get creationDate => _creationDate;

  DateTime _lastUpdate = DateTime.now();
  DateTime get lastUpdate => _lastUpdate;

  String _displayName = "";
  String get displayName => _displayName;
  set displayName(newValue) => _displayName = newValue;

  String _username = "";
  String get username => _username;
  set username(newValue) => _username  = newValue;

  String _photoUrl = "";
  String get photoUrl => _photoUrl;
  set photoUrl(newValue) => _photoUrl = newValue;

  String _phoneNumber = "";
  String get phoneNumber => _phoneNumber;
  set phoneNumber(newValue) => _phoneNumber = newValue;

  String _email = "";
  String get email => _email;
  set email(newValue) => _email = newValue;

  String _address = "";
  String get address => _address;
  set address(newValue) => _address = newValue;

  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;
  set isAdmin(newValue) => _isAdmin = newValue;

  /// Used on first login
  UserModel.fromFirstLogin() {
    _creationDate     = DateTime.now();
    _lastUpdate       = DateTime.now();
    _username         = "";
    _address          = "";
    _isAdmin          = false;
  }

  /// Used on any login that isn't the first
  UserModel.fromDocument(Map<String, String> userDoc) {
    _firebaseId           = userDoc['firebaseId']  ?? '';
    _displayName          = userDoc['displayName'] ?? '';
    _photoUrl             = userDoc['photoUrl'] ?? '';
    _phoneNumber          = userDoc['phoneNumber'] ?? '';
    _email                = userDoc['email'] ?? '';
    _address              = userDoc['address'] ?? '';
    _username             = userDoc['username'] ?? '';
    //_lastUpdate           = userDoc['lastUpdate'] != null ? userDoc['lastUpdate'].toDate() : DateTime.now();
    //_creationDate         = userDoc['creationDate'] != null ? userDoc['creationDate'].toDate() : DateTime.now();
  }

  void showOnConsole(String header) {

    print('''

      $header

      currentUser.firebaseId: $_firebaseId
      currentUser.username: $_username
      currentUser.displayName: $_displayName
      currentUser.phoneNumber: $_phoneNumber
      currentUser.email: $_email
      currentUser.address: $_address
      currentUser.isAdmin: $_isAdmin
      '''
    );
  }

  String toReadableString() {
    return
      "displayName: $_displayName; "
          "firebaseId: $_firebaseId; "
          "email: $_email; "
          "address: $_address; "
          "photoUrl: $_photoUrl; "
          "phoneNumber: $_phoneNumber; "
          "isAdmin: $_isAdmin; ";
  }
}