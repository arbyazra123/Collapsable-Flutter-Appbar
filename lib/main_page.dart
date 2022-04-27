import 'dart:convert';
import 'dart:io';

import 'package:custom_appbar/components/collapsable_appbar.dart';
import 'package:custom_appbar/second_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'data_list.dart';
import 'models/literature_result.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
          "https://www.googleapis.com/books/v1/volumes?q=${DateFormat("dd MMMM").format(DateTime.now().toLocal())}"));
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
      backgroundColor: Color(0xFFF8F0E4),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [CollapsableAppbar()];
        },
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Today Picks",
                            style: GoogleFonts.playfairDisplay(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SecondPage(),
                                ));
                          },
                          child: Text(
                            "Show All",
                            style: GoogleFonts.playfairDisplay(
                                fontSize: 14,
                                color: Colors.blue,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Expanded(
                    child: DataList(
                      result: result,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
