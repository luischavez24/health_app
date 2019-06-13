class Benefit {
  String id;
  String name;
  int points;
  String description;
  String imageUrl;

  Benefit({this.id, this.name, this.points, this.description, this.imageUrl});

  factory Benefit.fromJson(Map<String, dynamic> json) {
    return Benefit(
        id: json['_id'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        points: json['points'],
        description: json['description']
    );
  }
}