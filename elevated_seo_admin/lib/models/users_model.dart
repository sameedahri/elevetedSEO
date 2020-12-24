class GMBUser {
  final String email, accountName, type, profilePhotoUrl, uid, accountNumber;
  final Map state, locations;

  GMBUser(
      {this.accountName,
      this.type,
      this.uid,
      this.profilePhotoUrl,
      this.state,
      this.locations,
      this.email,
      this.accountNumber});

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "accountNumber": accountNumber,
      "accountName": accountName,
      "type": type,
      "profilePhotoUrl": profilePhotoUrl,
      'locations': locations,
      "state": state,
      'uid': uid,
    };
  }

  factory GMBUser.fromMap(Map<String, dynamic> data) {
    return GMBUser(
      accountNumber: data['accountNumber'],
      email: data['email'],
      accountName: data['accountName'],
      locations: data['locations'],
      profilePhotoUrl: data['profilePhotoUrl'],
      state: data['state'],
      uid: data['uid'],
      type: data['type'],
    );
  }
}
