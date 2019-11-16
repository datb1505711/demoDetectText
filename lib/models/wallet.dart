class Wallet {
  String _id;
  String _name;
  String _username;
  String _note;
  String _type;
  String _unit;
  String _total;

  set id(String id) => this._id = id;
  set name(String name) => this._name = name;
  set username(String username) => this._username = username;
  set note(String note) => this._note = note;
  set walletType(String type) => this._type = type;
  set walletUnitMoney(String unit) => this._unit = unit;
  set total(String total) => this._total = total;

  String get id => this._id;
  String get name => this._name;
  String get username => this._username;
  String get note => this._note;
  String get type => this._type;
  String get unit => this._unit;
  String get total => this._total;

  Wallet.fromJSON(Map<String, dynamic> json)
      : this._id = json['id'].toString() ?? "",
        this._name = json['name'].toString() ?? "",
        this._username = json['username'].toString() ?? "",
        this._note = json['note'].toString() ?? "",
        this._type = json['type'].toString() ?? "",
        this._unit = json['unit'].toString() ?? "",
        this._total = json['total'].toString() ?? "";

  @override
  toString() =>
      'Wallet {id: $id, name: $name, username: $username, note: $note,type: $type, unit: $unit,total: $total}';
}
