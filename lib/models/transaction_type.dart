import 'package:flutter/foundation.dart';

class TransactionType {
  int _id;
  String _description;

  TransactionType({@required int id, @required description})
      : this._id = id,
        this._description = description,
        super();

  set id(int id) => this._id = id;
  set description(String description) => this._description = description;

  get id => this._id;
  get description => this._description;

  TransactionType.fromJSON(Map<String, dynamic> json)
      : this._id = json['id'] ?? 0,
        this._description = json['description'] ?? "";

  @override
  toString() => 'TransactionType {id: $id, description: $description}';
}
