import 'package:flutter/material.dart';

class ListTileItem extends StatefulWidget {
  final ValueChanged<int> onCountvalue;

  ListTileItem({Key key, this.onCountvalue}) : super(key: key);
  @override
  _ListTileItemState createState() => new _ListTileItemState();
}

class _ListTileItemState extends State<ListTileItem> {
  int _itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      color: Colors.redAccent,
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // _itemCount != 0
          IconButton(
            color: Colors.white,
            icon: new Icon(Icons.remove),
            onPressed: () {
              setState(() {
                if (_itemCount == 0)
                  _itemCount = 0;
                else if (_itemCount > 0) _itemCount--;
              });
              widget.onCountvalue(this._itemCount);
            },
          ),
          Text(
            _itemCount.toString(),
            style: TextStyle(color: Colors.white),
          ),
          IconButton(
              color: Colors.white,
              icon: new Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _itemCount++;
                });
                widget.onCountvalue(_itemCount);
              })
        ],
      ),
    );
  }
}
