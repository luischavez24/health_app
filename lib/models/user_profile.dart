class UserProfile {
  String email;
  String firstName;
  String lastName;
  int points;
  String profileImageUrl;

  UserProfile({this.email, this.firstName, this.lastName, this.points, this.profileImageUrl});

  String get fullName => '$firstName $lastName';
}