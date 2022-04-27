import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/literature_result.dart';

class DataList extends StatelessWidget {
  final LiteratureResult? result;
  const DataList({Key? key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (a, b) => SizedBox(
        height: 10,
      ),
      itemCount: result?.items?.length ?? 0,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 14, top: 14),
      scrollDirection: Axis.vertical,
      itemBuilder: (_, index) {
        var data = result?.items?[index];
        return InkWell(
          onTap: () {
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              isScrollControlled: true,
              builder: (_) {
                return Container(
                  height: MediaQuery.of(context).size.height * .85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        14,
                      ),
                      topRight: Radius.circular(
                        14,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Container(
                              width: 120,
                              height: 5,
                              margin: EdgeInsets.only(top: 12),
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  )),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    data?.volumeInfo?.imageLinks?.thumbnail ==
                                            null
                                        ? SizedBox()
                                        : Align(
                                            alignment: Alignment.center,
                                            child: CachedNetworkImage(
                                              imageUrl: data?.volumeInfo
                                                      ?.imageLinks?.thumbnail ??
                                                  "",
                                            ),
                                          ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    _buildRow("Title",
                                        data?.volumeInfo?.title ?? "-"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    _buildRow(
                                        "Authors",
                                        data?.volumeInfo?.authors?.join(", ") ??
                                            "-"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    _buildRow("Published Date",
                                        data?.volumeInfo?.publishedDate ?? "-"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Description",
                                      style: GoogleFonts.lato(
                                          color: Colors.grey[700],
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Html(
                                      data: data?.volumeInfo?.description ??
                                          data?.searchInfo?.textSnippet ??
                                          "-",
                                    ),
                                    // Text(
                                    //   removeAllHtmlTags(
                                    //       data?.volumeInfo?.description ??
                                    //           data?.searchInfo?.textSnippet ??
                                    //           "-"),
                                    //   style: GoogleFonts.lato(
                                    //       color: Colors.black,
                                    //       fontWeight: FontWeight.w400),
                                    // ),
                                    SizedBox(
                                      height: 100,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.all(14),
                          width: double.maxFinite,
                          height: 45,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                14,
                              ))),
                              backgroundColor: MaterialStateProperty.all(
                                Color(0xFF311996),
                              ),
                            ),
                            onPressed: () async {
                              if (!await launch(
                                  data?.volumeInfo?.previewLink ?? "")) {}
                            },
                            child: Text("Preview"),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            width: 280,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.black,
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.grey[800]!,
                    Colors.black,
                  ]),
              borderRadius: BorderRadius.circular(8),
              // image: DecorationImage(
              //   image: AssetImage(
              //     "assets/bg.png",
              //   ),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data?.volumeInfo?.title ?? "",
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  removeAllHtmlTags(data?.volumeInfo?.description ??
                      data?.searchInfo?.textSnippet ??
                      "-"),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    child: Text(
                      "show more",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 115,
          child: Text(
            title,
            style: GoogleFonts.lato(
                color: Colors.grey[700],
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          ":",
          style: GoogleFonts.lato(
              color: Colors.grey[700],
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.lato(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }

  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return HtmlUnescape().convert(htmlText.replaceAll(exp, ''));
  }
}
