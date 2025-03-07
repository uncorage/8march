import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static String pathBasename(String path) {
    return File(path).uri.pathSegments.last;
  }

  static Future<List<String>> listAssets(String root) async {
    try {
      AssetManifest manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      var assets = manifest.listAssets();
      List<String> filteredAssets = [];

      for (int i = 0; i < assets.length; i++) {
        if (assets[i].startsWith(root)) {
          filteredAssets.add(assets[i]);
        }
      }

      return filteredAssets;
    } catch (e) {
      print(e);
    }
    return [];
  }
}