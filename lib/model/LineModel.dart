import 'dart:convert';

Line lineFromJson(String str) {
  final jsonData = json.decode(str);
  return Line.fromJson(jsonData);
}

String lineToJson(Line data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}


class Line {
  int id;
  String content;
  int createdAt;

  Line({
    this.id,
    this.content,
    this.createdAt,
  });

  factory Line.fromJson(Map<String, dynamic> json) => new Line(
    id: json["id"],
    content: json["content"],
    createdAt: json["created_at"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "created_at": createdAt,
  };


  void setContent(String content){
    this.content = content;
  }
}