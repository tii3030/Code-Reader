class User {

  final int id;
  final String code;

  User(
    this.id,
    this.code
  );

  @override
  String toString() {
    return 'id: $id, code: $code';
  }

}