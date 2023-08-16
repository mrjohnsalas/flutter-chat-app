class User {
  String? uid;
  String firstName;
  String lastName;
  String email;
  String? photoUrl;
  bool onLine;

  String get fullName => '$firstName $lastName';

  User({
    this.uid, 
    required this.firstName, 
    required this.lastName, 
    required this.email, 
    this.photoUrl,
    this.onLine = false
  });
}