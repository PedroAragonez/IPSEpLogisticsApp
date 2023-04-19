class numOrder{
  String orderNum;
  numOrder(
      {
        this.orderNum,
      });

  factory numOrder.fromJson(Map<String, dynamic> json) {
    return numOrder(
      orderNum: json['orderNum'] as String,
    );
  }
  }