import 'dart:convert';

import 'package:custom_appbar/models/literature_result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'data_list.dart';

class SearchPage extends StatefulWidget {
  final String q;
  const SearchPage({Key? key, required this.q}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  LiteratureResult? result;
  bool loading = true;
  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    try {
      var response = await Client().get(Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=${widget.q.trim()}"));
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
    return Scaffold(
      backgroundColor:  Color(0xFFF8F0E4),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor:  Color(0xFFF8F0E4),
        elevation: 1,
        title: Text(
          widget.q,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : DataList(
              result: result,
            ),
    );
  }
}
