import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:love_moneyyy/screen/add_transaction/bloc/add_transaction_bloc.dart';
import 'package:love_moneyyy/screen/add_transaction/bloc/bloc.dart';
import 'package:love_moneyyy/util/constants.dart';

class PickImageDialog extends StatelessWidget {
  final AddTransactionBloc _addTransactionBloc;

  PickImageDialog({Key key, AddTransactionBloc addTransactionBloc})
      : _addTransactionBloc = addTransactionBloc,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.5),
      ),
      title: Image.asset(
        Constants.app_background,
        height: 150.0,
        fit: BoxFit.fitWidth,
        width: double.maxFinite,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: () => _getImage(false).then((_) {
              Navigator.pop(context);
            }),
            leading: Icon(Icons.camera_alt),
            title: Text("Chụp ảnh mới"),
          ),
          ListTile(
            onTap: () => _getImage(true).then((_) {
              Navigator.pop(context);
            }),
            leading: Icon(Icons.image),
            title: Text("Chọn ảnh từ thư viện"),
          ),
        ],
      ),
    );
  }

  Future _getImage(bool isGetFromGallery) async {
    var image;
    isGetFromGallery
        ? image = await ImagePicker.pickImage(source: ImageSource.gallery)
        : image = await ImagePicker.pickImage(source: ImageSource.camera);

    _addTransactionBloc.dispatch(PickingImage(image));
  }
}
