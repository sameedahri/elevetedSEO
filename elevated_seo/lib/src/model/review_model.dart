class GMBReview {
  String name, reviewId, starRating, comment, createTime, updateTime;
  Map reviewer, reviewReply;

  GMBReview({
    this.name,
    this.reviewId,
    this.starRating,
    this.comment,
    this.createTime,
    this.updateTime,
    this.reviewer,
    this.reviewReply,
  });

  GMBReview copyWith({
    String name,
    String reviewId,
    String starRating,
    String comment,
    String createTime,
    String updateTime,
    Map reviewer,
    Map reviewReply,
  }) {
    return new GMBReview(
      name: name ?? this.name,
      reviewId: reviewId ?? this.reviewId,
      starRating: starRating ?? this.starRating,
      comment: comment ?? this.comment,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      reviewer: reviewer ?? this.reviewer,
      reviewReply: reviewReply ?? this.reviewReply,
    );
  }

  @override
  String toString() {
    return 'GMBReview{name: $name, reviewId: $reviewId, starRating: $starRating, comment: $comment, createTime: $createTime, updateTime: $updateTime, reviewer: $reviewer, reviewReply: $reviewReply}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GMBReview &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          reviewId == other.reviewId &&
          starRating == other.starRating &&
          comment == other.comment &&
          createTime == other.createTime &&
          updateTime == other.updateTime &&
          reviewer == other.reviewer &&
          reviewReply == other.reviewReply);

  @override
  int get hashCode =>
      name.hashCode ^
      reviewId.hashCode ^
      starRating.hashCode ^
      comment.hashCode ^
      createTime.hashCode ^
      updateTime.hashCode ^
      reviewer.hashCode ^
      reviewReply.hashCode;

  factory GMBReview.fromMap(Map<String, dynamic> map) {
    return new GMBReview(
      name: map['name'] as String,
      reviewId: map['reviewId'] as String,
      starRating: map['starRating'] as String,
      comment: map['comment'] as String,
      createTime: map['createTime'] as String,
      updateTime: map['updateTime'] as String,
      reviewer: map['reviewer'] as Map,
      reviewReply: map['reviewReply'] as Map,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'reviewId': this.reviewId,
      'starRating': this.starRating,
      'comment': this.comment,
      'createTime': this.createTime,
      'updateTime': this.updateTime,
      'reviewer': this.reviewer,
      'reviewReply': this.reviewReply,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
