class WalletType {
  int _id;
  String _description;

  WalletType(int id, String description)
      : this._id = id,
        this._description = description;

  int get id => this._id;
  String get description => this._description;

  set id(int id) => this._id = id;
  set description(String description) => this._description = description;

  WalletType.fromJSON(Map<String, dynamic> json)
      : this._id = json['id'] ?? 0,
        this._description = json['description'] ?? "";

  @override
  String toString() => 'WalletType {id: $id, description:$description}';
}
