import 'package:flutter/material.dart';
import 'package:json/model.dart';
import 'package:json/post_detail_list.dart';

class CategoryListDetail extends StatefulWidget {
  final Categorylist category;

  CategoryListDetail({Key key, @required this.category}) : super(key: key);

  _CategoryListDetailState createState() => _CategoryListDetailState();
}

class _CategoryListDetailState extends State<CategoryListDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          widget.category.categoryTitle
        ),
      ),
       body: Container(
         child: getList(),
       ),
    );
  }

    Widget getList() {
    ListView listPost = new ListView.builder(
        itemCount: widget.category.categoryPost.length,
        itemBuilder: (context, index) {
          if (widget.category.categoryPost.length == 0) {
            return Center(
                child: Text(
              "No Data",
            ));
          } else if (widget.category.categoryPost.length > 0) {
            return InkWell(
              onTap: () {
                // print(widget.category.doa[index].detailDoa[index].ayatdoa);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PostDetailContent(
                        detail: widget.category.categoryPost[index],
                        // doaDetail: widget.category.doa[index].detailDoa[index],
                        // doa: widget.category.doa[index].detailDoa[index],
                      ),
                ));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Spacer(
                          flex: 1,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.category.categoryPost[index].postTitle,
                              style: TextStyle(
                                  fontFamily: 'SignikaSemiBold',
                                  fontSize: 18,
                                  color: Color(0xFF585858)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                            ),
                            Text(
                              // "Terdapat ${widget.category.doa[index].detailDoa[index].toString()}",
                              widget.category.categoryPost[index].reference,
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
                        left: MediaQuery.of(context).size.width * 0.0),
                    child: new Divider(),
                  ),
                ],
              ),
            );
          }
          return Center(child: new CircularProgressIndicator());
        });
    return listPost;
  }

}// TODO Implement this library.