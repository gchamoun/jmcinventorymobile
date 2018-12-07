import 'package:flutter/material.dart';
import 'package:jmcinventory/Item.dart';

class ItemDetailsModalContents extends StatefulWidget {
  ItemDetailsModalContents({
    Key key,
    this.item,
  }) : super(key: key);

  final Item item;

  @override
  _ItemDetailsModalContentsState createState() =>
      new _ItemDetailsModalContentsState();
}

class _ItemDetailsModalContentsState extends State<ItemDetailsModalContents> {
  @override
  void initState() {
    super.initState();
  }

  _getContent() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text("Name:",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        Text(widget.item.description,
            style: TextStyle(fontWeight: FontWeight.bold)),
        Padding(padding: EdgeInsets.only(top: 10)),
        Text("Serial:",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        Text(widget.item.serial, style: TextStyle(fontWeight: FontWeight.bold)),
        Padding(padding: EdgeInsets.only(top: 10)),
        Text('Included Accessories:',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),

        ),
        //Here is the builder for my list of scanned qrcodes
        new Expanded(
            child: new ListView.builder(
                itemCount: widget.item.accessoriesList.length,
                itemBuilder: (BuildContext ctxt, int acIndex) {
                  return CheckboxListTile(
                      title:
                          Text(widget.item.accessoriesList[acIndex].toString()),
                      value: widget.item.accessoriesIncluded[acIndex],
                      onChanged: (bool value) {
                        setState(() {
                          widget.item.accessoriesIncluded[acIndex] = value;
                        });
                      });
                })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}
