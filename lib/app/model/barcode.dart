class Barcode {

  final int id;
  final String code;
  final String barcode;

  Barcode(
    this.id,
    this.code,
    this.barcode
  );

  @override
  String toString() {
    return 'id: $id, code: $code, barcode: $barcode';
  }

  Map toJson() => {
    'code': code,
    'barcode': barcode,
  };

}