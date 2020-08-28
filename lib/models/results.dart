class Results {
  final String studentName;
  final String hallTicketNo;
  final List resultsData;

  Results({this.studentName, this.hallTicketNo, this.resultsData});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      studentName: json['results']['Student name'] ?? "",
      hallTicketNo: json['results']['Hall Ticket No'] ?? "",
      resultsData: json['results']['resultsData'] ?? "",
    );
  }
}
