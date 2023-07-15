class GetInvoicesId {
    int id;
    String customerName;
    String invoiceDate;
    String code;

    GetInvoicesId({
        required this.id,
        required this.customerName,
        required this.invoiceDate,
        required this.code,
    }); 

  static GetInvoicesId fromJson(json) => GetInvoicesId(
      id: json['id'] ?? 6666,
      customerName: json['customerName'] ?? 'customerName',
      invoiceDate: json['invoiceDate'] ?? 'invoiceDate',
      code: json['code'] ?? 'code');
    
    }