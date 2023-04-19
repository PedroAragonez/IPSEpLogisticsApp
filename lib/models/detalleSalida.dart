class detalleSalida{
  int detalleSalidaId;
  String product;
  String serialNum;
  String palletId;
  String location;
  int qtyRequested;
  bool uqSend;
  String orderNum;
  bool status;
  detalleSalida(
      {
        this.detalleSalidaId,
        this.product,
        this.serialNum,
        this.palletId,
        this.location,
        this.qtyRequested,
        this.uqSend,
        this.orderNum,
        this.status,
      });

  factory detalleSalida.fromJson(Map<String, dynamic> json) {
    return detalleSalida(
      detalleSalidaId: json['detalleSalidaId'] as int,
      product: json['product'] as String,
      serialNum: json['serialNum'] as String,
      palletId: json['palletId'] as String,
      location: json['locationZone'] as String,
      qtyRequested: json['qtyRequested'] as int,
      uqSend: json['uqSend'] as bool,
      orderNum: json['orderNum'] as String,
      status: json['status'] as bool,
    );
  }
  }