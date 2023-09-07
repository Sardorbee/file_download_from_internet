import 'package:equatable/equatable.dart';

class FileModel extends Equatable {
  final String fileName;
  final String fileUrl;
  final double progress;

  const FileModel({
    required this.fileName,
    required this.fileUrl,
    required this.progress,
  });

  FileModel copyWith({
    String? fileName,
    String? fileUrl,
    double? progress,
  }) =>
      FileModel(
        fileName: fileName ?? this.fileName,
        fileUrl: fileUrl ?? this.fileUrl,
        progress: progress ?? this.progress,
      );

  @override
  List<Object?> get props => [
        fileName,
        fileUrl,
        progress,
      ];
}

List<FileModel> filesData = [
  const FileModel(
    progress: 0.0,
    fileName: "Monkey",
    fileUrl:
    "https://vod-progressive.akamaized.net/exp=1694003102~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F3690%2F18%2F468450798%2F2081823294.mp4~hmac=d6e3e8ac09508c41ab64cd76ac1479ba0e6fcb915ce00f01bbd1c8187253d679/vimeo-prod-skyfire-std-us/01/3690/18/468450798/2081823294.mp4",
  ),
  const FileModel(
    fileName: "Space Video",
    fileUrl:
        "https://vod-progressive.akamaized.net/exp=1694012151~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F2836%2F12%2F314181352%2F1212112677.mp4~hmac=13a21e94bdc7fc0c1f5119033b97e16837525a24197cc2ddbcf5cd75c120b96e/vimeo-prod-skyfire-std-us/01/2836/12/314181352/1212112677.mp4?download=1&filename=pexels_videos_1851190+%282160p%29.mp4",
    progress: 0.0,
  ),
  const FileModel(
    progress: 0.0,
    fileName: "Butterfly",
    fileUrl:
        "https://vod-progressive.akamaized.net/exp=1694066912~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F702%2F7%2F178514767%2F581513698.mp4~hmac=ed8dd144b8b87a58b422bb8da0c79f63387dc3d3c247337f7c887cc3cdcead51/vimeo-prod-skyfire-std-us/01/702/7/178514767/581513698.mp4?download=1&filename=butterfly_flying_away_from_a_flower+%281080p%29.mp4",
  ),

];
