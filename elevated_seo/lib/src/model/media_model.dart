class GMBMedia {
  String mediaFormat,
      sourceUrl,
      description,
      name,
      googleUrl,
      thumbnailUrl,
      createTime,
      dataRef;
  Map locationAssociation, insights, dimensions, attribution;

  GMBMedia(
      {this.name,
      this.googleUrl,
      this.thumbnailUrl,
      this.createTime,
      this.dataRef,
      this.insights,
      this.dimensions,
      this.attribution,
      this.mediaFormat,
      this.sourceUrl,
      this.locationAssociation,
      this.description});

  factory GMBMedia.fromMap(Map<String, dynamic> map) {
    return GMBMedia(
      attribution: map['attribution'],
      createTime: map['createTime'],
      dataRef: map['dataRef'],
      description: map['description'],
      dimensions: map['dimensions'],
      googleUrl: map['googleUrl'],
      insights: map['insights'],
      locationAssociation: map['locationAssociation'],
      mediaFormat: map['mediaFormat'],
      name: map['name'],
      sourceUrl: map['sourceUrl'],
      thumbnailUrl: map['thumbnailUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "mediaFormat": mediaFormat,
      'description': description,
      "sourceUrl": sourceUrl,
      "locationAssociation": locationAssociation
    };
  }
}
