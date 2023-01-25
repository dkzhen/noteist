class TodoModel {
  final int? id;
  final String? title;

  TodoModel({this.id, this.title});

  factory TodoModel.fromMap(Map<String, dynamic> json) => TodoModel(
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}
