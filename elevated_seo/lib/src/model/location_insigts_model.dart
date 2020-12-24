class GMBLocationInsights {
  final String locationName, timeZone;
  final List metricValues;

  GMBLocationInsights({this.locationName, this.timeZone, this.metricValues});

  Map<String, dynamic> toMap() {
    return {
      "locationName": locationName,
      "timeZone": timeZone,
      "metricValues": metricValues,
    };
  }

  factory GMBLocationInsights.fromMap(Map<String, dynamic> map) {
    return GMBLocationInsights(
      locationName: map['locationName'],
      timeZone: map['timeZone'],
      metricValues: map['metricValues'],
    );
  }
}

// locationMetrics
