import 'package:file_download_from_internet/data/models/file_model.dart';
import 'package:file_download_from_internet/ui/home/widget/single.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/png/telegram_bg.png',
              fit: BoxFit.fill,
            ),
          ),
          ListView.builder(
            itemCount: filesData.length,
            itemBuilder: (context, index) {
              FileModel singleFile = filesData[index];
              return FileDownloader(
                fileModel: singleFile,
                id: index,
              );
            },
          )
        ],
      ),
    );
  }
}
