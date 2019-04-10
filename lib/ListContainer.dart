import 'package:flutter/material.dart';
import 'package:write_a_line/Database.dart';
import 'package:write_a_line/model/LineModel.dart';

class ListContainer extends StatelessWidget {
  ListContainer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Lines(),
    );
  }
}

class ListState extends State<Lines>{
  final _biggerFont = const TextStyle(fontSize: 18.0);
  ListState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      body: FutureBuilder<List<Line>>(
        future: DBProvider.db.getAllLines(),
        builder: (BuildContext context, AsyncSnapshot<List<Line>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Line item = snapshot.data[index];
                if (item != null){
                  return new Dismissible(
                      key: Key(item.id.toString()),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) => DBProvider.db.deleteLine(item.id),
                      child: _buildRow(item)
                  );
                }
                return new Divider();
              },
            );
          }else{
            return Center(child: Text('No Line'));
          }
        },
      ),
    );
  }

  Widget _buildRow(Line line) {
    return ListTile(
      title: Text(
        line.content != null ? line.content : "",
        style: _biggerFont,
      ),
      leading: Text(
        line.id.toString(),
        style: _biggerFont,
      ),
    );
  }
}

class Lines extends StatefulWidget {
  @override
  ListState createState() => new ListState();
}