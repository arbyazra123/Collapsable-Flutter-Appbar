import 'dart:math';

import 'package:custom_appbar/models/dummy.dart';
import 'package:custom_appbar/search_page.dart';
import 'package:flutter/material.dart';

class TabbedAppbar extends StatelessWidget {
  final List<String> tabs;
  final ShortQuote quote;
  final bool autoFocus;
  final ValueChanged<int>? onTabChanged;
  TabbedAppbar(
      {Key? key,
      required this.tabs,
      this.autoFocus = false,
      this.onTabChanged,
      required this.quote})
      : super(key: key);

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var outlineBorder = OutlineInputBorder(
      gapPadding: 0,
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Color(0xFF311996).withOpacity(0.1),
      ),
    );
    return SliverAppBar(
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      collapsedHeight: kToolbarHeight,
      backgroundColor: Colors.white,
      elevation: 1,
      iconTheme: IconThemeData(color: Colors.black),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TabBar(
          isScrollable: true,
          labelColor: Color(0xFF311996),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xFF311996),
          indicatorSize: TabBarIndicatorSize.tab,
          onTap: onTabChanged,
          tabs: tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        collapseMode: CollapseMode.pin,
        background: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  quote.quote,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(child: Divider()),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    quote.author,
                    style: TextStyle(color: Colors.grey[500]!, fontSize: 12),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _controller,
                    maxLines: 1,
                    textInputAction: TextInputAction.search,
                    autofocus: autoFocus,
                    onFieldSubmitted: (v) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(q: v),
                        ),
                      );
                    },
                    decoration: InputDecoration(
                      border: outlineBorder,
                      errorBorder: outlineBorder,
                      enabledBorder: outlineBorder,
                      focusedBorder: outlineBorder,
                      hintText: "Title, Genre, Desc...",
                      suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SearchPage(q: _controller.text),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.search,
                          color: Color(0xFF311996),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // _s()
            ],
          ),
        ),
        title: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Text(
              "Literally",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }

  Row _s() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.fromBorderSide(BorderSide(
              color: Colors.grey.withOpacity(0.2),
            )),
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.sort,
            color: Color(0xFF311996),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.fromBorderSide(BorderSide(
              color: Colors.grey.withOpacity(0.2),
            )),
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.search,
            color: Color(0xFF311996),
          ),
        ),
      ],
    );
  }
}
