class TypeAll {
  String name;
  String url;
  bool selected = false;

  TypeAll({
    this.name,
    this.url,
  });

  factory TypeAll.fromJson(Map<String, dynamic> json) => new TypeAll(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
