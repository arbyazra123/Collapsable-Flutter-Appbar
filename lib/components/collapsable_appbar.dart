import 'package:custom_appbar/second_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CollapsableAppbar extends StatelessWidget {
  const CollapsableAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 180.0,
      floating: false,
      pinned: true,
      automaticallyImplyLeading: false,
      collapsedHeight: kToolbarHeight,
      backgroundColor: Color(0xFF311996),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Literally",
            style: GoogleFonts.playfairDisplay(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(autoFocus: true),
                  ));
            },
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 35,
            ),
          )
        ],
      ),
      elevation: 1,
      leadingWidth: 0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: _buildHeaderList(),
      ),
    );
  }

  Widget _buildHeaderList() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.maxFinite,
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xFF311996),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/bg.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 10,
              width: double.maxFinite,
              color: Color(0xFFF8F0E4),
            ),
          ),
          // _buildTopList(),
        ],
      ),
    );
  }
}
