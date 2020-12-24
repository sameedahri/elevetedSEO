import 'dart:convert';

import 'package:elevated_seo/src/model/media_model.dart';
import 'package:elevated_seo/src/model/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiService {
  Map<String, String> authHeaders;

  ApiService({@required this.authHeaders});

  //* Get Initial Data
  Future<Map<String, dynamic>> connectAccount() async {
    http.Response response = await http.get(
      "https://mybusiness.googleapis.com/v4/accounts",
      headers: authHeaders,
    );
    return _getData(response);
  }

  //* Get Location Servives
  Future<Map<String, dynamic>> getLocations(String accountNumber) async {
    http.Response response = await http.get(
      "https://mybusiness.googleapis.com/v4/accounts/$accountNumber/locations",
      headers: authHeaders,
    );
    return _getData(response);
  }

  //* Get Location Insights
  Future<Map<String, dynamic>> getLocationInsigts(String accountNumber,
      List<String> locationName, String startTime, String endTime) async {
    http.Response response = await http.post(
      "https://mybusiness.googleapis.com/v4/accounts/$accountNumber/locations:reportInsights",
      headers: authHeaders,
      body: json.encode(
        {
          "locationNames": locationName,
          "basicRequest": {
            "metricRequests": [
              {"metric": "ALL"},
            ],
            "timeRange": {
              "startTime": startTime,
              "endTime": endTime,
            }
          }
        },
      ),
    );
    return _getData(response);
  }

  //* Post new media
  Future<Map<String, dynamic>> postMedia(
      String accountNumber, String locationID, GMBMedia media) async {
    http.Response response = await http.post(
      "https://mybusiness.googleapis.com/v4/accounts/$accountNumber/locations/$locationID/media",
      headers: authHeaders,
      body: json.encode(media.toMap()),
    );
    return _getData(response);
  }

  //* Get Media Items
  Future<Map<String, dynamic>> getMedia(
      String accountNumber, String locationID) async {
    http.Response response = await http.get(
      "https://mybusiness.googleapis.com/v4/accounts/$accountNumber/locations/$locationID/media",
      headers: authHeaders,
    );
    return _getData(response);
  }

  //* Delete Media Items
  deleteMedia(String mediaItem) async {
    http.Response response = await http.delete(
      "https://mybusiness.googleapis.com/v4/$mediaItem",
      headers: authHeaders,
    );

    return _getData(response);
  }

  //* Get all reviews
  Future<Map<String, dynamic>> getReviews(
      String accountNumber, String locationID) async {
    http.Response response = await http.get(
      "https://mybusiness.googleapis.com/v4/accounts/$accountNumber/locations/$locationID/reviews",
      headers: authHeaders,
    );
    return _getData(response);
  }

  //* Update Reply
  Future<Map<String, dynamic>> updateReply(String name, String reply) async {
    http.Response response = await http.put(
      "https://mybusiness.googleapis.com/v4/$name/reply",
      headers: authHeaders,
      body: json.encode({'comment': reply}),
    );
    return _getData(response);
  }

  //* Get all posts
  Future<Map<String, dynamic>> getPosts(
      String accountNumber, String locationID) async {
    http.Response response = await http.get(
      "https://mybusiness.googleapis.com/v4/accounts/$accountNumber/locations/$locationID/localPosts",
      headers: authHeaders,
    );
    return _getData(response);
  }

  //* Post new post
  Future<Map<String, dynamic>> postPost(
      String accountNumber, String locationID, GMBPosts gmbPosts) async {
    http.Response response = await http.post(
      "https://mybusiness.googleapis.com/v4/accounts/$accountNumber/locations/$locationID/localPosts",
      headers: authHeaders,
      body: json.encode(gmbPosts.toMap()),
    );
    return _getData(response);
  }

  //* Get Service List
  Future<Map<String, dynamic>> getServiceList(
      String accountNumber, String locationID) async {
    http.Response response = await http.get(
      "https://mybusiness.googleapis.com/v4/accounts/$accountNumber/locations/$locationID/serviceList",
      headers: authHeaders,
    );
    return _getData(response);
  }

  Future<Map<String, dynamic>> setServiceList(String accountNumber,
      String locationID, Map<String, dynamic> data) async {
    http.Response response = await http.patch(
      "https://mybusiness.googleapis.com/v4/accounts/$accountNumber/locations/$locationID/serviceList?updateMask=serviceItems",
      headers: authHeaders,
      body: json.encode(data),
    );
    return _getData(response);
  }

  Map<String, dynamic> _getData(http.Response response) {
    Logger().d(response.body);
    return json.decode(response.body);
  }
}
