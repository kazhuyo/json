import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter ListView with Button'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class ItemDetail {
  String strTitle;
  var isNotify = false;

  ItemDetail (this.strTitle, this.isNotify);
}

class _MyHomePageState extends State<MyHomePage> {

  List<ItemDetail> arrItemList = [
    new ItemDetail("Title 1", true),
    new ItemDetail("Title 2", false),
    new ItemDetail("Title 3", true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: 
        ListView.builder(
          itemCount: arrItemList.length,
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
              onTap: () {
                print('on tap clicked on ' + arrItemList[index].strTitle);
              },
              child: Container(
                height: 45.0,
                decoration: BoxDecoration(),
                child: new Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Container(
                            child: Text(
                              arrItemList[index].strTitle,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 10.0),
                              maxLines: 1,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              setState(() {
                                arrItemList[index].isNotify =! arrItemList[index].isNotify;
                              });
                              print('clicked on notify ' + arrItemList[index].strTitle);
                            },
                            child: new Container(
                              margin: const EdgeInsets.all(0.0),
                              child: new Icon(
                                arrItemList[index].isNotify ? Icons.alarm : Icons.alarm_off,
                                color: Colors.black,
                                size: 30.0,
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
            );
          },
        ),
    );
  }
}