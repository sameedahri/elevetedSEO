class GMBLocation {
  String name, languageCode, websiteUrl, storeCode, locationName, primaryPhone;
  Map address,
      regularHours,
      specialHours,
      openInfo,
      locationState,
      relationshipData,
      serviceArea,
      primaryCategory,
      locationKey,
      metadata,
      latlng,
      profile;
  List labels, attributes, priceLists, additionalPhones, additionalCategories;

  GMBLocation({
    this.name,
    this.languageCode,
    this.primaryCategory,
    this.websiteUrl,
    this.storeCode,
    this.locationName,
    this.primaryPhone,
    this.address,
    this.regularHours,
    this.specialHours,
    this.openInfo,
    this.locationState,
    this.relationshipData,
    this.serviceArea,
    this.locationKey,
    this.metadata,
    this.latlng,
    this.profile,
    this.labels,
    this.attributes,
    this.priceLists,
    this.additionalPhones,
    this.additionalCategories,
  });

  GMBLocation copyWith({
    String name,
    String languageCode,
    Map primaryCategory,
    String websiteUrl,
    String storeCode,
    String locationName,
    String primaryPhone,
    Map address,
    Map regularHours,
    Map specialHours,
    Map openInfo,
    Map locationState,
    Map relationshipData,
    Map serviceArea,
    Map locationKey,
    Map metadata,
    Map latlng,
    Map profile,
    List labels,
    List attributes,
    List priceLists,
    List additionalPhones,
    List additionalCategories,
  }) {
    return new GMBLocation(
      name: name ?? this.name,
      languageCode: languageCode ?? this.languageCode,
      primaryCategory: primaryCategory ?? this.primaryCategory,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      storeCode: storeCode ?? this.storeCode,
      locationName: locationName ?? this.locationName,
      primaryPhone: primaryPhone ?? this.primaryPhone,
      address: address ?? this.address,
      regularHours: regularHours ?? this.regularHours,
      specialHours: specialHours ?? this.specialHours,
      openInfo: openInfo ?? this.openInfo,
      locationState: locationState ?? this.locationState,
      relationshipData: relationshipData ?? this.relationshipData,
      serviceArea: serviceArea ?? this.serviceArea,
      locationKey: locationKey ?? this.locationKey,
      metadata: metadata ?? this.metadata,
      latlng: latlng ?? this.latlng,
      profile: profile ?? this.profile,
      labels: labels ?? this.labels,
      attributes: attributes ?? this.attributes,
      priceLists: priceLists ?? this.priceLists,
      additionalPhones: additionalPhones ?? this.additionalPhones,
      additionalCategories: additionalCategories ?? this.additionalCategories,
    );
  }

  @override
  String toString() {
    return 'GMBLocation{name: $name, languageCode: $languageCode, primaryCategory: $primaryCategory, websiteUrl: $websiteUrl, storeCode: $storeCode, locationName: $locationName, primaryPhone: $primaryPhone, address: $address, regularHours: $regularHours, specialHours: $specialHours, openInfo: $openInfo, locationState: $locationState, relationshipData: $relationshipData, serviceArea: $serviceArea, locationKey: $locationKey, metadata: $metadata, latlng: $latlng, profile: $profile, labels: $labels, attributes: $attributes, priceLists: $priceLists, additionalPhones: $additionalPhones, additionalCategories: $additionalCategories}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GMBLocation &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          languageCode == other.languageCode &&
          primaryCategory == other.primaryCategory &&
          websiteUrl == other.websiteUrl &&
          storeCode == other.storeCode &&
          locationName == other.locationName &&
          primaryPhone == other.primaryPhone &&
          address == other.address &&
          regularHours == other.regularHours &&
          specialHours == other.specialHours &&
          openInfo == other.openInfo &&
          locationState == other.locationState &&
          relationshipData == other.relationshipData &&
          serviceArea == other.serviceArea &&
          locationKey == other.locationKey &&
          metadata == other.metadata &&
          latlng == other.latlng &&
          profile == other.profile &&
          labels == other.labels &&
          attributes == other.attributes &&
          priceLists == other.priceLists &&
          additionalPhones == other.additionalPhones &&
          additionalCategories == other.additionalCategories);

  @override
  int get hashCode =>
      name.hashCode ^
      languageCode.hashCode ^
      primaryCategory.hashCode ^
      websiteUrl.hashCode ^
      storeCode.hashCode ^
      locationName.hashCode ^
      primaryPhone.hashCode ^
      address.hashCode ^
      regularHours.hashCode ^
      specialHours.hashCode ^
      openInfo.hashCode ^
      locationState.hashCode ^
      relationshipData.hashCode ^
      serviceArea.hashCode ^
      locationKey.hashCode ^
      metadata.hashCode ^
      latlng.hashCode ^
      profile.hashCode ^
      labels.hashCode ^
      attributes.hashCode ^
      priceLists.hashCode ^
      additionalPhones.hashCode ^
      additionalCategories.hashCode;

  factory GMBLocation.fromMap(Map<String, dynamic> map) {
    return new GMBLocation(
      name: map['name'] as String,
      languageCode: map['languageCode'] as String,
      primaryCategory: map['primaryCategory'] as Map,
      websiteUrl: map['websiteUrl'] as String,
      storeCode: map['storeCode'] as String,
      locationName: map['locationName'] as String,
      primaryPhone: map['primaryPhone'] as String,
      address: map['address'] as Map,
      regularHours: map['regularHours'] as Map,
      specialHours: map['specialHours'] as Map,
      openInfo: map['openInfo'] as Map,
      locationState: map['locationState'] as Map,
      relationshipData: map['relationshipData'] as Map,
      serviceArea: map['serviceArea'] as Map,
      locationKey: map['locationKey'] as Map,
      metadata: map['metadata'] as Map,
      latlng: map['latlng'] as Map,
      profile: map['profile'] as Map,
      labels: map['labels'] as List,
      attributes: map['attributes'] as List,
      priceLists: map['priceLists'] as List,
      additionalPhones: map['additionalPhones'] as List,
      additionalCategories: map['additionalCategories'] as List,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'languageCode': this.languageCode,
      'primaryCategory': this.primaryCategory,
      'websiteUrl': this.websiteUrl,
      'storeCode': this.storeCode,
      'locationName': this.locationName,
      'primaryPhone': this.primaryPhone,
      'address': this.address,
      'regularHours': this.regularHours,
      'specialHours': this.specialHours,
      'openInfo': this.openInfo,
      'locationState': this.locationState,
      'relationshipData': this.relationshipData,
      'serviceArea': this.serviceArea,
      'locationKey': this.locationKey,
      'metadata': this.metadata,
      'latlng': this.latlng,
      'profile': this.profile,
      'labels': this.labels,
      'attributes': this.attributes,
      'priceLists': this.priceLists,
      'additionalPhones': this.additionalPhones,
      'additionalCategories': this.additionalCategories,
    } as Map<String, dynamic>;
  }
}
