class Results {
  final String studentName;
  final String hallTicketNo;
  final List results;

  Results({this.studentName, this.hallTicketNo, this.results});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      studentName: json['user']['Student name'],
      hallTicketNo: json['user']['Hall Ticket No'],
      results: json['results'],
    );
  }
}
