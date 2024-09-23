import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';

import 'constants/app_constants.dart';

void shareLink({
  String text = '',
  Map<String, dynamic>? dynamicParams,
  required BuildContext context,
}) {
  final box = context.findRenderObject() as RenderBox?;
  Share.share(
    text,
    subject: AppConstants.appName,
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );
}

Future<bool> uploadToSignedUrl({
  required File file,
  required String signedUrl,
}) async {
  try {
    final Uri uri = Uri.parse(signedUrl.split('?').first);
    await put(
      uri,
      body: await file.readAsBytes(),
    ).timeout(const Duration(milliseconds: 60000));
    return true;
  } catch (e) {
    return false;
  }
}
