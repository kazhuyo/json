import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:json/list_category_detail.dart';
import 'package:json/model.dart';


Future<String> _loadCategoryfromAssets() async {
  return await rootBundle.loadString('assets/data/list.json');
}

Future<Category> loadCategory() async {
  await wait(2);
  String jsonString = await _loadCategoryfromAssets();
  final jsonResponse = json.decode(jsonString);
  //String anugan = doa.listdoa.length;
  return Category.fromJson(jsonResponse);
  //print('Sample API Response : ${doa.listdoa.length}');
}

Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}


class ListCategory extends StatefulWidget {
  ListCategory({Key key}) : super(key: key);

  _ListCategoryState createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Category List"
        ),
      ),
      body: loadData(),
    );
  }

  Widget loadData() {
    return new FutureBuilder<Category>(
      future: loadCategory(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new Container(
              padding: EdgeInsets.only(right: 15),
              child: new ListView.builder(
                itemCount: snapshot.data.categorylist.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CategoryListDetail(
                              category: snapshot.data.categorylist[index],
                            ),
                          ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 17, bottom: 5),
                          child: Row(
                            children: <Widget>[
                              Spacer(
                                flex: 1,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    snapshot.data.categorylist[index].categoryTitle,
                                    style: TextStyle(
                                        fontFamily: 'SignikaSemiBold',
                                        fontSize: 18,
                                        color: Color(0xFF585858)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                  ),
                                  Text(
                                    "${snapshot.data.categorylist[index].categoryPost.length.toString()} Posts",
                                    style: TextStyle(
                                        fontFamily: 'SFProDisplay',
                                        fontSize: 12,
                                        color: Color(0xFF686C71)),
                                  ),
                                ],
                              ),
                              Spacer(
                                flex: 13,
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 25,
                                color: Color(0xFFC4C4C4),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.20),
                          child: new Divider(),
                        ),
                      ],
                    ),
                  );
                },
              ));
        } else if (snapshot.hasError) {
          return new Text("${snapshot.error}");
        }
        return Center(child: new CircularProgressIndicator());
      },
    );
  }

}