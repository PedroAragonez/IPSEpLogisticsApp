class detalleEvento{
  int DetalleEntradaID;
  String Cliente;
  String PalletId;
  double Qty;
  String PartNum;
  String Fecha;
  String OrderEP;
  String Location;
  String CreateDate;
  bool Active;
  bool ReadLabel;
  String fechaReadLabel;
  String fechaLocation;
  String IdLot;
  detalleEvento(
      {
        this.DetalleEntradaID,
        this.Cliente,
        this.PalletId,
        this.Qty,
        this.PartNum,
        this.Fecha,
        this.OrderEP,
        this.Location,
        this.CreateDate,
        this.Active,
        this.ReadLabel,
        this.fechaReadLabel,
        this.fechaLocation,
        this.IdLot
      });

  factory detalleEvento.fromJson(Map<String, dynamic> json) {
    return detalleEvento(
      DetalleEntradaID: json['detalleEntradaID'] as int,
      Cliente: json['cliente'] as String,
      PalletId: json['palletId'] as String,
      Qty: json['qty'] as double,
      PartNum: json['partNum'] as String,
      Fecha: json['fecha'] as String,
      OrderEP: json['orderEP'] as String,
      Location: json['location'] as String,
      CreateDate: json['createDate'] as String,
      Active: json['active'] as bool,
      ReadLabel: json['readLabel'] as bool,
      fechaReadLabel: json['fechaReadLabel'] as String,
      fechaLocation: json['fechaLocation'] as String,
      IdLot: json['IdLot'] as String,
    );
  }
  }