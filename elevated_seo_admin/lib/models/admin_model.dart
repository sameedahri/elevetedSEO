class AdminModel {
  final String fullName, emailAddress;

  const AdminModel({this.emailAddress, this.fullName});

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      emailAddress: json['emailAddress'],
      fullName: json['fullName'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'emailAddress': emailAddress,
      'fullName': fullName,
    };
  }
}
