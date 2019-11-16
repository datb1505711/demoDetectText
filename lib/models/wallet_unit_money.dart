class WalletUnitMoney {
  int _id;
  String _description;

  WalletUnitMoney(int id, String description)
      : this._id = id,
        this._description = description;

  int get id => this._id;
  String get description => this._description;

  set id(int id) => this._id = id;
  set description(String description) => this._description = description;

  WalletUnitMoney.fromJSON(Map<String, dynamic> json)
      : this._id = json['id'] ?? 0,
        this._description = json['description'] ?? "";

  @override
  toString() => 'WalletUnitMoney {id: $id, description: $description}';
}
