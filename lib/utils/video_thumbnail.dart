import 'package:flutter/services.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Future<Uint8List> generateVideoThumbnail(String videoUrl) async {
  final thumbnail = await VideoThumbnail.thumbnailData(
    video: videoUrl,
    imageFormat: ImageFormat.JPEG,
    maxWidth: 150,
    quality: 15,
  );

  return thumbnail!;
}
