import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var api = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail";
  var res, drinks;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    res = await http.get(api);
    drinks = jsonDecode(res.body)["drinks"];
    print(drinks.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 8,
        centerTitle: true,
        backgroundColor: Colors.lightGreenAccent,
        title: Text("Cocktail App"),
      ),
      body: Center(
        child: res != null
            ? ListView.builder(
                itemCount: drinks.length,
                // ignore: missing_return
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(drinks[index]["strDrinkThumb"]),
                      ),
                      subtitle: Text(
                        "   Drink id : ${drinks[index]["idDrink"]}",
                        style: TextStyle(color: Colors.white),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "${index + 1}. drinks : ${drinks[index]["strDrink"]}",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  );
                })
            : CircularProgressIndicator(),
      ),
    );
  }
}
