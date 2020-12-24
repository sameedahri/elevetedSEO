class GMBPosts {
  String name,
      languageCode,
      summary,
      createTime,
      updateTime,
      state,
      searchUrl,
      topicType,
      alertType;

  Map callToAction, event, offer;
  List media;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  GMBPosts({
    this.name,
    this.languageCode,
    this.summary,
    this.createTime,
    this.updateTime,
    this.state,
    this.searchUrl,
    this.topicType,
    this.alertType,
    this.callToAction,
    this.event,
    this.media,
    this.offer,
  });

  GMBPosts copyWith({
    String name,
    String languageCode,
    String summary,
    String createTime,
    String updateTime,
    String state,
    String searchUrl,
    String topicType,
    String alertType,
    Map callToAction,
    Map event,
    Map media,
    Map offer,
  }) {
    return new GMBPosts(
      name: name ?? this.name,
      languageCode: languageCode ?? this.languageCode,
      summary: summary ?? this.summary,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      state: state ?? this.state,
      searchUrl: searchUrl ?? this.searchUrl,
      topicType: topicType ?? this.topicType,
      alertType: alertType ?? this.alertType,
      callToAction: callToAction ?? this.callToAction,
      event: event ?? this.event,
      media: media ?? this.media,
      offer: offer ?? this.offer,
    );
  }

  @override
  String toString() {
    return 'GMBPosts{name: $name, languageCode: $languageCode, summary: $summary, createTime: $createTime, updateTime: $updateTime, state: $state, searchUrl: $searchUrl, topicType: $topicType, alertType: $alertType, callToAction: $callToAction, event: $event, media: $media, offer: $offer}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GMBPosts &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          languageCode == other.languageCode &&
          summary == other.summary &&
          createTime == other.createTime &&
          updateTime == other.updateTime &&
          state == other.state &&
          searchUrl == other.searchUrl &&
          topicType == other.topicType &&
          alertType == other.alertType &&
          callToAction == other.callToAction &&
          event == other.event &&
          media == other.media &&
          offer == other.offer);

  @override
  int get hashCode =>
      name.hashCode ^
      languageCode.hashCode ^
      summary.hashCode ^
      createTime.hashCode ^
      updateTime.hashCode ^
      state.hashCode ^
      searchUrl.hashCode ^
      topicType.hashCode ^
      alertType.hashCode ^
      callToAction.hashCode ^
      event.hashCode ^
      media.hashCode ^
      offer.hashCode;

  factory GMBPosts.fromMap(Map<String, dynamic> map) {
    return new GMBPosts(
      name: map['name'] as String,
      languageCode: map['languageCode'] as String,
      summary: map['summary'] as String,
      createTime: map['createTime'] as String,
      updateTime: map['updateTime'] as String,
      state: map['state'] as String,
      searchUrl: map['searchUrl'] as String,
      topicType: map['topicType'] as String,
      alertType: map['alertType'] as String,
      callToAction: map['callToAction'] as Map,
      event: map['event'] as Map,
      media: map['media'] as List,
      offer: map['offer'] as Map,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'languageCode': this.languageCode,
      'summary': this.summary,
      'createTime': this.createTime,
      'updateTime': this.updateTime,
      'state': this.state,
      'searchUrl': this.searchUrl,
      'topicType': this.topicType,
      'alertType': this.alertType,
      'callToAction': this.callToAction,
      'event': this.event,
      'media': this.media,
      'offer': this.offer,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
