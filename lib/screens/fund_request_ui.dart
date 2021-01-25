import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:money_request_ui/screens/fund_request_preview_ui.dart';

class GetUsers {
  int amount;
  String type;
  String name;
  String image;
  GetUsers({this.name, this.amount, this.type, this.image});

  factory GetUsers.fromJson(Map<String, dynamic> json) {
    return GetUsers(
        amount: json["amount"],
        type: json["type"],
        name: json["name"],
        image: json["image"]);
  }
}

class MoneyRequestUI extends StatefulWidget {
  MoneyRequestUI({Key key}) : super(key: key);

  @override
  _MoneyRequestUIState createState() => _MoneyRequestUIState();
}

class _MoneyRequestUIState extends State<MoneyRequestUI> {
  final String apiURL =
      'http://www.json-generator.com/api/json/get/bUrPoWsnaW?indent=2';

  Future<List<GetUsers>> fetchJSONData() async {
    var jsonResponse = await http.get(apiURL);
    if (jsonResponse.statusCode == 200) {
      final jsonItems =
          json.decode(jsonResponse.body).cast<Map<String, dynamic>>();

      List<GetUsers> usersList = jsonItems.map<GetUsers>((json) {
        return GetUsers.fromJson(json);
      }).toList();
      return usersList;
    } else {
      throw Exception('Failed to load data from internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        backgroundColor: Color(0xffB30060),
        leading: Container(
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                CupertinoIcons.back,
                color: Color(0xffffffff),
              ),
              Text(
                'Back',
                style: TextStyle(
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
        ),
        middle: Text(
          "Payee's money requests", // Retrieve the fund requester's name
          style: TextStyle(
            color: Color(0xffffffff),
            fontSize: 15,
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
          child: Text(
            'Delete',
            style: TextStyle(
              color: Color(0xffffffff),
              fontSize: 18,
            ),
          ),
        ),
      ),
      child: Scaffold(
        body: FutureBuilder<List<GetUsers>>(
          future: fetchJSONData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            return ListView(
              children: snapshot.data
                  .map(
                    (users) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(users.image),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            users.name,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xffAB005A),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  12,
                                  2,
                                  12,
                                  2,
                                ),
                                child: Text(
                                  users.type,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffFFDFDF),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    15,
                                    2,
                                    15,
                                    2,
                                  ),
                                  child: Text(
                                    "QAR " + users.amount.toString() + ".00",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.redAccent),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        onLongPress: () {},
                        trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Color(0xffAB005A),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FundRequestUi(
                                            amount: users.amount,
                                            name: users.name,
                                            imagePath: users.image,
                                          )));
                            }),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
