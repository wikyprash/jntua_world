// To parse this JSON data, do
//
//final publishedResultsModel = publishedResultsModelFromJson(jsonString);

import 'dart:convert';

List<PublishedResultsModel> publishedResultsModelFromJson(String str) =>
    List<PublishedResultsModel>.from(
        json.decode(str).map((x) => PublishedResultsModel.fromJson(x)));

String publishedResultsModelToJson(List<PublishedResultsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PublishedResultsModel {
  PublishedResultsModel({
    this.publishdDate,
    this.title,
    this.url,
  });

  DateTime publishdDate;
  String title;
  String url;

  factory PublishedResultsModel.fromJson(Map<String, dynamic> json) =>
      PublishedResultsModel(
        publishdDate: DateTime.parse(json["publishd_date"]),
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "publishd_date":
            "${publishdDate.year.toString().padLeft(4, '0')}-${publishdDate.month.toString().padLeft(2, '0')}-${publishdDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "url": url,
      };
}
