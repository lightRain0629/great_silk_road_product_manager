class GetInvoices {
    int id;
    String name;
    String groupName;
    String typeName;
    String brandName;
    String unitName;
    int quantity;
    String barcode;
    String expiredDate;

    GetInvoices({
        required this.id,
        required this.name,
        required this.groupName,
        required this.typeName,
        required this.brandName,
        required this.unitName,
        required this.quantity,
        required this.barcode,
        required this.expiredDate,
    });
    
  static GetInvoices fromJson(json) => GetInvoices(
      id: json['id'] ?? 1,
      name: json['name'] ?? 'name',
      groupName: json['groupName'] ?? 'groupName',
      typeName: json['typeName'] ?? 'typeName',
      brandName: json['brandName'] ?? 'brandName',
      unitName: json['unitName'] ?? 'unitName',
      quantity: json['quantity'] ?? 0,
      barcode: json['barcode'] ?? 'barcode',
      expiredDate: json['expiredDate'] ?? 'expiredDate'
      );


    }