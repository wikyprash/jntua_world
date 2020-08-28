// To parse this JSON data, do
//
//     final userDocumentModel = userDocumentModelFromJson(jsonString);

import 'dart:convert';

UserDocumentModel userDocumentModelFromJson(String str) => UserDocumentModel.fromJson(json.decode(str));

String userDocumentModelToJson(UserDocumentModel data) => json.encode(data.toJson());

class UserDocumentModel {
    UserDocumentModel({
        this.userAccountDetails,
        this.results,
    });

    UserAccountDetails userAccountDetails;
    Results results;

    factory UserDocumentModel.fromJson(Map<String, dynamic> json) => UserDocumentModel(
        userAccountDetails: UserAccountDetails.fromJson(json["userAccountDetails"]),
        results: Results.fromJson(json["results"]),
    );

    Map<String, dynamic> toJson() => {
        "userAccountDetails": userAccountDetails.toJson(),
        "results": results.toJson(),
    };
}

class Results {
    Results({
        this.resultsData,
        this.hallTicketNo,
        this.studentName,
    });

    List<ResultsDatum> resultsData;
    String hallTicketNo;
    String studentName;

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        resultsData: List<ResultsDatum>.from(json["resultsData"].map((x) => ResultsDatum.fromJson(x))),
        hallTicketNo: json["Hall Ticket No"],
        studentName: json["Student name"],
    );

    Map<String, dynamic> toJson() => {
        "resultsData": List<dynamic>.from(resultsData.map((x) => x.toJson())),
        "Hall Ticket No": hallTicketNo,
        "Student name": studentName,
    };
}

class ResultsDatum {
    ResultsDatum({
        this.title,
        this.data,
    });

    String title;
    List<Datum> data;

    factory ResultsDatum.fromJson(Map<String, dynamic> json) => ResultsDatum(
        title: json["title"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.resultStatus,
        this.externals,
        this.subjectName,
        this.subjectCode,
        this.totalMarks,
        this.grades,
        this.internals,
        this.credits,
    });

    ResultStatus resultStatus;
    String externals;
    String subjectName;
    String subjectCode;
    String totalMarks;
    String grades;
    String internals;
    String credits;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        resultStatus: resultStatusValues.map[json["Result Status"]],
        externals: json["Externals"],
        subjectName: json["Subject Name"],
        subjectCode: json["Subject Code"],
        totalMarks: json["Total Marks"],
        grades: json["Grades"],
        internals: json["Internals"],
        credits: json["Credits"],
    );

    Map<String, dynamic> toJson() => {
        "Result Status": resultStatusValues.reverse[resultStatus],
        "Externals": externals,
        "Subject Name": subjectName,
        "Subject Code": subjectCode,
        "Total Marks": totalMarks,
        "Grades": grades,
        "Internals": internals,
        "Credits": credits,
    };
}

enum ResultStatus { P, F, AB }

final resultStatusValues = EnumValues({
    "AB": ResultStatus.AB,
    "F": ResultStatus.F,
    "P": ResultStatus.P
});

class UserAccountDetails {
    UserAccountDetails({
        this.photoUrl,
        this.displayName,
        this.phoneNumber,
        this.email,
        this.isEmailVerified,
    });

    String photoUrl;
    String displayName;
    dynamic phoneNumber;
    String email;
    bool isEmailVerified;

    factory UserAccountDetails.fromJson(Map<String, dynamic> json) => UserAccountDetails(
        photoUrl: json["photoUrl"],
        displayName: json["displayName"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        isEmailVerified: json["isEmailVerified"],
    );

    Map<String, dynamic> toJson() => {
        "photoUrl": photoUrl,
        "displayName": displayName,
        "phoneNumber": phoneNumber,
        "email": email,
        "isEmailVerified": isEmailVerified,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
