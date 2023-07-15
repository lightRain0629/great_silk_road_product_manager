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
      id: json['id'] ?? 'id',
      shortName: json['shortName'] ?? 'shortName',
      fullDistribNo: json['fullDistribNo'] ?? 'fullDistribNo',
      releaseDate: json['releaseDate'] ?? 'releaseDate');
}
