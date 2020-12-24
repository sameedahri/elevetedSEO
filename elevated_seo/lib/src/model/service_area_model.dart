class GMBServiceArea {
  final String name;
  final List serviceItems;

  GMBServiceArea({this.name, this.serviceItems});

  factory GMBServiceArea.fromMap(Map<String, dynamic> map) {
    return GMBServiceArea(
      name: map['name'],
      serviceItems: map['serviceItems'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'serviceItems': serviceItems,
    };
  }
}
