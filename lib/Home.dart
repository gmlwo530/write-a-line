import 'package:flutter/material.dart';
import 'package:write_a_line/Database.dart';
import 'package:write_a_line/model/LineModel.dart';

class Home extends StatelessWidget {
  Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new GestureDetector(
            onTap: (){
              FocusScope.of(context).detach();
            },
            child: new Body(),
        )
    );
  }
}

class Body extends StatefulWidget {
  @override
  createState() => new BodyState();
}

class BodyState extends State<Body> {
  String _newLine;
  final TextEditingController _textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              new TextField(
                autofocus: false,
                textAlign: TextAlign.center,
                onChanged: (val) {
                  setState(() {
                    _newLine = val;
                  });
                },
                decoration: new InputDecoration(
                  hintText: 'Write a Line',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16.0),
                ),
                controller: _textEditingController,
              ),
              new FlatButton(
                  onPressed: () async {
                    if(_newLine != null && _newLine != " "){
                      _textEditingController.clear();
                      FocusScope.of(context).detach();
                      Line line = new Line();
                      line.setContent(_newLine);
                      await DBProvider.db.newLine(line);
                    }
                  },
                  child: new Icon(Icons.create)
              ),
        ],
    );
  }
}
