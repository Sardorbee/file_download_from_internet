import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_download_from_internet/data/models/file_model.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'file_download_state.dart';

class FileDownloadCubit extends Cubit<FileDownloadState> {
  FileDownloadCubit()
      : super(
          const FileDownloadState(
            progress: 0.0,
            newFileLocation: "",
          ),
        );
  CancelToken? _cancelToken;

  downloadFile({
    required FileModel fileInfo,
  }) async {
    //Permission get
    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) return;
    Dio dio = Dio();

    // Userga ko'rinadigan path
    var directory = await getDownloadPath();
    String newFileLocation =
        "${directory?.path}/${fileInfo.fileName}${fileInfo.fileUrl.substring(fileInfo.fileUrl.length - 6, fileInfo.fileUrl.length)}";
    var allFiles = directory?.list();

    print("NEW FILE:$newFileLocation");

    List<String> filePaths = [];
    await allFiles?.forEach((element) {
      print("FILES IN DOWNLOAD FOLDER:${element.path}");
      filePaths.add(element.path.toString());
    });

    if (filePaths.contains(newFileLocation)) {
      OpenFilex.open(newFileLocation);
    } else {
      try {
        emit(state.copyWith(isDownloading: true));

        await dio.download(
          fileInfo.fileUrl,
          newFileLocation,
          onReceiveProgress: (count, total) async {
            print(count);


            if (await File(newFileLocation).exists()) {
              myProgressEmitter(count / total, newFileLocation);
            } else {
              print("File no longer exists.");

            }

            if (count / total == 1.0) {
              emit(state.copyWith(newFileLocation: newFileLocation));
            }
          },
        );
        emit(state.copyWith(isDownloading: false));
      }

      catch (error) {
        debugPrint("DOWNLOAD ERROR:$error");
      }
    }
  }

  myProgressEmitter(double pr, String progressLocation) async {
    debugPrint("DOWNLOADED COUNT: $pr");
    emit(state.copyWith(progress: pr, progressFileLocation: progressLocation));

    int progressPercentage = (state.progress * 100).toInt();
    await showProgressNotification(progressPercentage);
  }

  Future<void> showProgressNotification(int progressPercentage) async {
    // Create a notification to indicate the download progress
    bool notificationId = await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: 'download_channel',
        title: 'Download Progress',
        body: '$progressPercentage% downloaded',
        progress: progressPercentage,
        notificationLayout: NotificationLayout.ProgressBar,
      ),
    );

    if (progressPercentage == 100) {
      await Future.delayed(const Duration(seconds: 3));
      await AwesomeNotifications().cancel(0);
    }
  }

  cancelDownload() {
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken!.cancel("Download canceled");
      emit(state.copyWith(isDownloading: false));
    }
  }

  Future<bool> _requestWritePermission() async {
    final statuses = await [
      Permission.photos,
      Permission.storage,
      Permission.videos,
    ].request();
    return statuses[Permission.videos]!.isGranted;
  }

  Future<Directory?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      debugPrint("Cannot get download folder path");
    }
    return directory;
  }
}
