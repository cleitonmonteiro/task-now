import 'dart:ui';

class Project {
  Project({this.id, this.name, this.color, this.length});

  int id;
  String name;
  Color color;
  int length;

  factory Project.fromJson(Map<String, dynamic> data) {
    return Project(
      id: data['id'],
      name: data['name'],
      color: Color(data['color']),
      length: data['length'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.value,
    };
  }

  @override
  String toString() {
    return 'Project {$name}';
  }
}
