import 'package:bta3_physia_admin/features/grades/data/models/dummy_grades_data.dart';
import 'package:equatable/equatable.dart';

enum LivePlatform {
  zoom,
  googleMeet;

  String get label => switch (this) {
    LivePlatform.zoom => 'Zoom',
    LivePlatform.googleMeet => 'Google Meet',
  };

  String get externalLabel => 'يُفتح في التطبيق الخارجي';

  bool matchesUrl(String value) {
    final Uri? uri = Uri.tryParse(value.trim());

    if (uri == null ||
        (uri.scheme != 'http' && uri.scheme != 'https') ||
        uri.host.isEmpty) {
      return false;
    }

    final String host = uri.host.toLowerCase();

    return switch (this) {
      LivePlatform.zoom =>
        host == 'zoom.us' ||
            host.endsWith('.zoom.us') ||
            host == 'zoom.com' ||
            host.endsWith('.zoom.com'),
      LivePlatform.googleMeet => host == 'meet.google.com',
    };
  }
}

class LiveStreamModel extends Equatable {
  const LiveStreamModel({
    required this.title,
    required this.gradeId,
    required this.platform,
    required this.url,
  });

  final String title;
  final String gradeId;
  final LivePlatform platform;
  final String url;

  String get gradeName => DummyGradesData.nameOf(gradeId);

  LiveStreamModel copyWith({
    String? title,
    String? gradeId,
    LivePlatform? platform,
    String? url,
  }) {
    return LiveStreamModel(
      title: title ?? this.title,
      gradeId: gradeId ?? this.gradeId,
      platform: platform ?? this.platform,
      url: url ?? this.url,
    );
  }

  @override
  List<Object?> get props => <Object?>[title, gradeId, platform, url];
}
