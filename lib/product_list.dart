class Product {
  final String id,
      productName,
      productCode,
      image,
      unitPrice,
      totalPrice,
      crateAt,
      quantity;

  Product(this.id, this.productName, this.productCode, this.image,
      this.unitPrice, this.totalPrice, this.crateAt, this.quantity);

  factory Product.toJson(Map<String, dynamic> e) {
    return Product(
      e['_id'],
      e['ProductName'],
      e['ProductCode'],
      e['Img'],
      e['UnitPrice'],
      e['TotalPrice'],
      e['CreatedDate'],
      e['Qty'],
    );
  }
}
