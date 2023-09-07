import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoThumbnailWidget extends StatefulWidget {
  final String videoUrl;

  const VideoThumbnailWidget({super.key, required this.videoUrl});

  @override
  _VideoThumbnailWidgetState createState() => _VideoThumbnailWidgetState();
}

class _VideoThumbnailWidgetState extends State<VideoThumbnailWidget> {
  Uint8List? _thumbnailBytes;

  @override
  void initState() {
    super.initState();
    _generateVideoThumbnail();
  }

  Future<void> _generateVideoThumbnail() async {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: widget.videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 150, // Adjust the width as needed
      quality: 25,   // Adjust the quality as needed
    );

    setState(() {
      _thumbnailBytes = thumbnail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _thumbnailBytes != null
        ? Image.memory(_thumbnailBytes!,width: 150,)
        : CircularProgressIndicator();
  }
}
