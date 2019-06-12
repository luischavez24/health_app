class Exercise {
  String id;
  String name;
  String level;
  String imageUrl;
  int points;
  String units;
  String description;
  Exercise({
    this.id,
    this.name,
    this.level,
    this.imageUrl,
    this.points,
    this.units,
    this.description,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
        id: json['_id'],
        name: json['name'],
        level: json['level'],
        imageUrl: json['imageUrl'],
        units: json['units'],
        points: json['points'],
        description: json['description']
    );
  }

  String get profit => 'Puedes ganar ${this.points} punto por ${this.units}';
  String get shortProfit => '${this.points} puntos x ${this.units}';
}
