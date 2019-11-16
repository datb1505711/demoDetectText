class Transaction {
  String _id;
  String _imageURL;
  String _transactionType;
  String _walletId;
  DateTime _createAt;
  String _name;
  String _total;
  String _trip;
  String _event;
  String _place;

  Transaction({
    String id,
    String imageURL,
    String transactionType,
    String walletId,
    DateTime createAt,
    String name,
    String total,
    String trip,
    String event,
    String place,
  })  : this._id = id,
        this._imageURL = imageURL,
        this._name = name,
        this._transactionType = transactionType,
        this._walletId = walletId,
        this._createAt = createAt,
        this._total = total,
        this._trip = trip,
        this._event = event,
        this._place = place;

  String get id => this._id;
  set id(String _id) => this._id = _id;
  String get imageURL => this._imageURL;
  set image(String _image) => this._imageURL = _image;
  String get transactionType => this._transactionType;
  set transactionType(String _transactionType) =>
      this._transactionType = _transactionType;
  String get name => this._name;
  set name(String name) => this._name = name;
  String get walletId => this._walletId;
  set walletId(String _walletId) => this._walletId = _walletId;
  DateTime get createAt => this._createAt;
  set createAt(DateTime _createAt) => this._createAt = _createAt;
  String get total => this._total;
  set total(String _total) => this._total = _total;
  String get trip => this._trip;
  set trip(String _trip) => this._trip = _trip;
  String get event => this._event;
  set event(String _event) => this._event = _event;
  String get place => this._place;
  set place(String _place) => this._place = _place;

  Transaction.fromJSON(Map<String, dynamic> json)
      : this._id = json["id"] ?? "",
        this._imageURL = json["imageURL"] ?? "",
        this._transactionType = json["transactionType"] ?? "",
        this._walletId = json["walletId"] ?? "",
        this._createAt =
            DateTime.fromMillisecondsSinceEpoch(json["createAt"]) ??
                DateTime.now(),
        this._name = json["name"] ?? "",
        this._total = json["total"] ?? "",
        this._trip = json["trip"] ?? "",
        this._event = json["event"] ?? "",
        this._place = json["place"] ?? "";
  Map<String, dynamic> toJSON() {
    Map<String, dynamic> json = {
      "id": id,
      "imageURL": imageURL,
      "transactionType": transactionType,
      "walletId": walletId,
      "createAt": createAt.millisecondsSinceEpoch,
      "total": total,
      "name": name,
      "trip": trip,
      "event": event,
      "place": place
    };
    return json;
  }

  @override
  toString() =>
      "Transaction {id: $id,imageURL: $imageURL, transactionType: $transactionType, walletId: $walletId, name: $name, createAt: $createAt, total: $total, event: $event, trip: $trip, place: $place";
}
