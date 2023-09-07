part of 'file_download_cubit.dart';

class FileDownloadState {
  const FileDownloadState( {
    this.isDownloading = false,
     this.progressFileLocation,
    required this.progress,
    required this.newFileLocation,
  });

  final double progress;

  final bool isDownloading;
  final String? progressFileLocation;
  final String newFileLocation;

  FileDownloadState copyWith({
    double? progress,
    bool? isDownloading,
    String? progressFileLocation,
    String? newFileLocation,
  }) =>
      FileDownloadState(
        isDownloading: isDownloading?? this.isDownloading,
        progress: progress ?? this.progress,
        newFileLocation: newFileLocation ?? this.newFileLocation,
        progressFileLocation: progressFileLocation ?? this.progressFileLocation,
      );
}
