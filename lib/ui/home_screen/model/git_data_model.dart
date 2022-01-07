class GitDataModel {
  GitDataModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.stargazersCount,
    required this.watchersCount,
    required this.language,
  });
  int id;
  String name;
  String fullName;
  String description;
  int stargazersCount;
  int watchersCount;
  String language;

  factory GitDataModel.fromJson(Map<dynamic, dynamic> json) => GitDataModel(
        id: json["id"] ?? -1,
        name: json["name"] ?? "",
        fullName: json["full_name"] ?? "",
        description: json["description"] ?? "",
        stargazersCount: json["stargazers_count"] ?? -1,
        watchersCount: json["watchers_count"] ?? -1,
        language: json["language"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "full_name": fullName,
        "description": description,
        "stargazers_count": stargazersCount,
        "watchers_count": watchersCount,
        "language": language,
      };
}
