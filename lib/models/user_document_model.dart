import 'dart:convert';

UserDocumentModel userDocumentModelFromJson(String str) =>
    UserDocumentModel.fromJson(json.decode(str));

String userDocumentModelToJson(UserDocumentModel data) =>
    json.encode(data.toJson());

class UserDocumentModel {
  UserAccountDetails userAccountDetails;
  Results results;

  UserDocumentModel({this.userAccountDetails, this.results});

  UserDocumentModel.fromJson(Map<String, dynamic> json) {
    userAccountDetails = json['userAccountDetails'] != null
        ? new UserAccountDetails.fromJson(json['userAccountDetails'])
        : null;
    results =
        json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userAccountDetails != null) {
      data['userAccountDetails'] = this.userAccountDetails.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results.toJson();
    }
    return data;
  }
}

class UserAccountDetails {
  String photoUrl;
  String displayName;
  Null phoneNumber;
  String email;
  bool isEmailVerified;

  UserAccountDetails(
      {this.photoUrl,
      this.displayName,
      this.phoneNumber,
      this.email,
      this.isEmailVerified});

  UserAccountDetails.fromJson(Map<String, dynamic> json) {
    photoUrl = json['photoUrl'];
    displayName = json['displayName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photoUrl'] = this.photoUrl;
    data['displayName'] = this.displayName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['isEmailVerified'] = this.isEmailVerified;
    return data;
  }
}

class Results {
  List<ResultsData> resultsData;
  String hallTicketNo;
  String studentName;

  Results({this.resultsData, this.hallTicketNo, this.studentName});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['resultsData'] != null) {
      resultsData = new List<ResultsData>();
      json['resultsData'].forEach((v) {
        resultsData.add(new ResultsData.fromJson(v));
      });
    }
    hallTicketNo = json['Hall Ticket No'];
    studentName = json['Student name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resultsData != null) {
      data['resultsData'] = this.resultsData.map((v) => v.toJson()).toList();
    }
    data['Hall Ticket No'] = this.hallTicketNo;
    data['Student name'] = this.studentName;
    return data;
  }
}

class ResultsData {
  String title;
  List<Data> data;

  ResultsData({this.title, this.data});

  ResultsData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String resultStatus;
  String externals;
  String subjectName;
  String subjectCode;
  String totalMarks;
  String grades;
  String internals;
  String credits;

  Data(
      {this.resultStatus,
      this.externals,
      this.subjectName,
      this.subjectCode,
      this.totalMarks,
      this.grades,
      this.internals,
      this.credits});

  Data.fromJson(Map<String, dynamic> json) {
    resultStatus = json['Result Status'];
    externals = json['Externals'];
    subjectName = json['Subject Name'];
    subjectCode = json['Subject Code'];
    totalMarks = json['Total Marks'];
    grades = json['Grades'];
    internals = json['Internals'];
    credits = json['Credits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Result Status'] = this.resultStatus;
    data['Externals'] = this.externals;
    data['Subject Name'] = this.subjectName;
    data['Subject Code'] = this.subjectCode;
    data['Total Marks'] = this.totalMarks;
    data['Grades'] = this.grades;
    data['Internals'] = this.internals;
    data['Credits'] = this.credits;
    return data;
  }
}
