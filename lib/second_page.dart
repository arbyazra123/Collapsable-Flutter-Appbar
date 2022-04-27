import 'dart:convert';
import 'dart:math';

import 'package:custom_appbar/components/tabbed_appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'data_list.dart';
import 'models/dummy.dart';
import 'models/literature_result.dart';

class SecondPage extends StatefulWidget {
  final bool autoFocus;
  const SecondPage({Key? key, this.autoFocus = false}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  LiteratureResult? result;
  bool loading = true;
  var random = Dummy.list[Random().nextInt(Dummy.list.length)];
  var list = [
    "Fiction",
    "Non-Fiction",
    "Novel",
    "Mystery",
    "Romance",
    "Sci-fi",
    "Historical Fiction",
    "Thriller",
    "Narrative",
    "Fantasy",
    "Self-Improvement",
    "History",
    "Autobiography",
    "Drama"
  ];
  @override
  void initState() {
    _getData(list.first);
    super.initState();
  }

  void _getData(String q) async {
    setState(() {
      loading = true;
    });
    try {
      var response = await Client().get(Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=subject:${q.toLowerCase().split("-").join("")}"));
      if (response.statusCode == 200) {
        setState(() {
          if (jsonDecode(response.body)['totalItems'] > 0) {
            result = literatureResultFromJson(response.body);
          }
          loading = false;
        });
      }
    } on Exception catch (e) {
      debugPrint("An error occured ${e.toString()}");
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: list.length,
      child: Scaffold(
        backgroundColor: Color(0xFFF8F0E4),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              TabbedAppbar(
                quote: random,
                tabs: list,
                autoFocus: widget.autoFocus,
                onTabChanged: (v) => _getData(list[v]),
              ),
            ];
          },
          body: loading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: DataList(
                    result: result,
                  ),
                ),
        ),
      ),
    );
  }
}
