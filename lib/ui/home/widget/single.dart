import 'package:file_download_from_internet/data/cubit/file_download_cubit.dart';
import 'package:file_download_from_internet/data/models/file_model.dart';
import 'package:file_download_from_internet/ui/home/widget/animated_circular.dart';
import 'package:file_download_from_internet/ui/home/widget/thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';

// ignore: must_be_immutable
class FileDownloader extends StatelessWidget {
  FileDownloader({Key? key, required this.fileModel, required this.id})
      : super(key: key);
  final int id;
  final FileModel fileModel;
  FileDownloadCubit fileDownloadCubit = FileDownloadCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: fileDownloadCubit,
      child: BlocBuilder<FileDownloadCubit, FileDownloadState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(15),
            height: 100,
            color: const Color(0xff313131),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    VideoThumbnailWidget(videoUrl: fileModel.fileUrl),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.013,
                      left: MediaQuery.of(context).size.width * 0.13,
                      child: Center(
                        child: state.newFileLocation.isEmpty
                            ? state.isDownloading
                                ? Stack(
                                    children: [
                                      AnimatedRotationContainer(
                                        state: state,
                                      ),
                                      Positioned(
                                        left: 7,
                                        top: 6,
                                        child: InkWell(
                                          onTap: () async {
                                            // await context
                                            //     .read<FileDownloadCubit>()
                                            //     .cancelDownload();
                                            // String filePath =
                                            //     state.progressFileLocation!;
                                            // File fileToDelete =
                                            //     File(filePath);
                                            // if (fileToDelete.existsSync()) {
                                            //   try {
                                            //     fileToDelete.deleteSync();
                                            //     print(
                                            //         "File deleted successfully.");
                                            //   } catch (e) {
                                            //     print(
                                            //         "Error deleting the file: $e");
                                            //   }
                                            // } else {
                                            //   print("File does not exist.");
                                            // }
                                          },
                                          child: const Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      context
                                          .read<FileDownloadCubit>()
                                          .downloadFile(fileInfo: fileModel);
                                    },
                                    icon: const Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                  )
                            : const SizedBox(),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      fileModel.fileName,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    IconButton(
                      color: Colors.white,
                      onPressed: () {
                        context
                            .read<FileDownloadCubit>()
                            .downloadFile(fileInfo: fileModel);
                      },
                      icon: const Icon(
                        Icons.download,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  color: Colors.white,
                  onPressed: () {
                    if (state.newFileLocation.isNotEmpty) {
                      print(state.newFileLocation);
                      OpenFilex.open(state.newFileLocation);
                    }
                  },
                  icon: const Icon(Icons.file_open),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
