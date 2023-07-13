class OrderApprovementModel {
  int id;
  String shortName;
  String fullDistribNo;
  String releaseDate;

  OrderApprovementModel({
    required this.id,
    required this.shortName,
    required this.fullDistribNo,
    required this.releaseDate,
  });

  static OrderApprovementModel fromJson(json) => OrderApprovementModel(
      id: json['id'],
      shortName: json['shortName'],
      fullDistribNo: json['fullDistribNo'],
      releaseDate: json['releaseDate']);
}
