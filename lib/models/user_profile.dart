class UserProfile {
  String email;
  String displayName;
  double calories;
  String profileImageUrl;

  UserProfile({this.email, this.displayName, this.calories, this.profileImageUrl});

}

class CaloriesHistory {
  String day;
  int dayNumber = 1;
  int calories;
  CaloriesHistory({
    this.day,
    this.dayNumber,
    this.calories
  });
}