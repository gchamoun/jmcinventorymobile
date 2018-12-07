import 'package:flutter/material.dart';
import 'package:jmcinventory/Item.dart';

class AccessoriesCheckBoxContent extends StatefulWidget {
  AccessoriesCheckBoxContent({
    Key key,
    this.item,
  }): super(key: key);

  final Item item;

  @override
  _AccessoriesCheckBoxContentState createState() => new _AccessoriesCheckBoxContentState();
}

class _AccessoriesCheckBoxContentState extends State<AccessoriesCheckBoxContent> {
  @override
  void initState(){
    super.initState();
  }

  _getContent(){
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Text('Name: ' + widget.item.description, textAlign: TextAlign.left,),
        new Text('Serial: ' + widget.item.serial, textAlign: TextAlign.left,),
        new Text('Which accessories are included with this item?'),
        //Here is the builder for my list of scanned qrcodes
        new Expanded(
            child: new ListView.builder
              (
                itemCount: widget.item.accessoriesList.length,
                itemBuilder: (BuildContext ctxt, int acIndex) {
                  return CheckboxListTile(
                      title:  Text(widget.item.accessoriesList[acIndex].toString()),
                      value: widget.item.accessoriesIncluded[acIndex],
                      onChanged: (bool value) {
                        setState((){widget.item.accessoriesIncluded[acIndex] = value;});
                      }
                  );
                }
            )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}