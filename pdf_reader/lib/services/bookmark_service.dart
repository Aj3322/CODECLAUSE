import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bookmark.dart';

class BookmarkService extends GetxService {
  RxList<Bookmark> bookmarks = <Bookmark>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = prefs.getStringList('bookmarks');
    if (bookmarksJson != null) {
      bookmarks.assignAll(
        bookmarksJson.map((json) => Bookmark.fromJson(jsonDecode(json))).toList(),
      );
    }
  }


  Future<void> saveBookmark(Bookmark bookmark) async {
    bookmarks.add(bookmark);
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = bookmarks.map((bookmark) => jsonEncode(bookmark.toJson())).toList();
    prefs.setStringList('bookmarks', bookmarksJson);
  }

  Future<void> removeBookmark(Bookmark bookmark) async {
    bookmarks.remove(bookmark);
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = bookmarks.map((bookmark) => jsonEncode(bookmark.toJson())).toList();
    prefs.setStringList('bookmarks', bookmarksJson);
  }

}
