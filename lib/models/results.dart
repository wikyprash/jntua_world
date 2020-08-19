class Results {
  final String displayName;
  final String email;
  final String photoUrl;
  final String studentName;
  final String hallTicketNo;
  final List resultsData;

  Results({this.displayName, this.email, this.photoUrl, this.studentName, this.hallTicketNo, this.resultsData});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      displayName: json['userAccountDetails']['displayName'],
      email: json['userAccountDetails']['email'],
      photoUrl: json['userAccountDetails']['photoUrl'],
      studentName: json['results']['Student name'],
      hallTicketNo: json['results']['Hall Ticket No'],
      resultsData: json['results']['resultsData'],
    );
  }
}
