class numEntry{
  String IdLot;
  numEntry(
      {
        this.IdLot,
      });

  factory numEntry.fromJson(Map<String, dynamic> json) {
    return numEntry(
      IdLot: json['idLot'] as String,
    );
  }
  }