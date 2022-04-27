// To parse this JSON data, do
//
//     final literatureResult = literatureResultFromJson(jsonString);

import 'dart:convert';

LiteratureResult literatureResultFromJson(String str) =>
    LiteratureResult.fromJson(json.decode(str));

class LiteratureResult {
  LiteratureResult({
    this.kind,
    this.totalItems,
    this.items,
  });

  String? kind;
  int? totalItems;
  List<Item>? items;

  factory LiteratureResult.fromJson(Map<String, dynamic> json) =>
      LiteratureResult(
        kind: json["kind"],
        totalItems: json["totalItems"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );
}

class Item {
  Item({
    this.id,
    this.volumeInfo,
    this.searchInfo,
  });

  String? id;
  VolumeInfo? volumeInfo;
  SearchInfo? searchInfo;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        volumeInfo: json["volumeInfo"] == null
            ? null
            : VolumeInfo.fromJson(json["volumeInfo"]),
        searchInfo: json["searchInfo"] == null
            ? null
            : SearchInfo.fromJson(json["searchInfo"]),
      );
}

class SearchInfo {
  SearchInfo({
    this.textSnippet,
  });

  String? textSnippet;

  factory SearchInfo.fromJson(Map<String, dynamic> json) => SearchInfo(
        textSnippet: json["textSnippet"],
      );
}

class VolumeInfo {
  VolumeInfo({
    this.title,
    this.subtitle,
    this.authors,
    this.publishedDate,
    this.description,
    this.pageCount,
    this.printType,
    this.maturityRating,
    this.language,
    this.previewLink,
    this.imageLinks,
    this.infoLink,
    this.canonicalVolumeLink,
  });

  String? title;
  String? subtitle;
  List<String>? authors;
  ImageLink? imageLinks;
  String? publishedDate;
  String? description;
  int? pageCount;
  String? printType;
  String? maturityRating;
  String? language;
  String? previewLink;
  String? infoLink;
  String? canonicalVolumeLink;

  factory VolumeInfo.fromJson(Map<String, dynamic> json) => VolumeInfo(
        title: json["title"],
        subtitle: json["subtitle"],
        authors: json["authors"] == null
            ? null
            : List<String>.from(json["authors"].map((x) => x)),
        imageLinks: json["imageLinks"] == null
            ? null
            : ImageLink.fromJson(
                json['imageLinks'],
              ),
        publishedDate: json["publishedDate"],
        description: json["description"],
        pageCount: json["pageCount"],
        printType: json["printType"],
        maturityRating: json["maturityRating"],
        language: json["language"],
        previewLink: json["previewLink"],
        infoLink: json["infoLink"],
        canonicalVolumeLink: json["canonicalVolumeLink"],
      );
}

class ImageLink {
  ImageLink({
    this.smallThumbnail,
    this.thumbnail,
  });

  String? smallThumbnail;
  String? thumbnail;

  factory ImageLink.fromJson(Map<String, dynamic> json) => ImageLink(
        smallThumbnail: json["smallThumbnail"],
        thumbnail: json["thumbnail"],
      );
}
