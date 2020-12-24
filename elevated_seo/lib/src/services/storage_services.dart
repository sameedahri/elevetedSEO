import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<Uint8List> compressFile(File file) async {
  return await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    quality: 60,
  );
}
