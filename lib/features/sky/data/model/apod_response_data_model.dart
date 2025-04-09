import 'dart:convert';

import 'package:today_sky/features/sky/data/enum/media_type_enum.dart';

class ApodResponseDataModel {
  final String serviceVersion;
  final MediaType mediaType;
  final DateTime date;
  final String title;
  final String explanation;
  final String url;
  final String hdUrl;

  ApodResponseDataModel({
    required this.serviceVersion,
    required this.mediaType,
    required this.date,
    required this.title,
    required this.explanation,
    required this.url,
    required this.hdUrl,
  });

  ApodResponseDataModel copyWith({
    String? serviceVersion,
    MediaType? mediaType,
    DateTime? date,
    String? title,
    String? explanation,
    String? url,
    String? hdUrl,
  }) {
    return ApodResponseDataModel(
      serviceVersion: serviceVersion ?? this.serviceVersion,
      mediaType: mediaType ?? this.mediaType,
      date: date ?? this.date,
      title: title ?? this.title,
      explanation: explanation ?? this.explanation,
      url: url ?? this.url,
      hdUrl: hdUrl ?? this.hdUrl,
    );
  }

  factory ApodResponseDataModel.fromMap(Map<String, dynamic> map) {
    return ApodResponseDataModel(
      serviceVersion: map['service_version'] as String,
      mediaType: MediaType.typeFromJson(map['media_type']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      title: map['title'] as String,
      explanation: map['explanation'] as String,
      url: map['url'] as String,
      hdUrl: map['hdurl'] as String,
    );
  }

  factory ApodResponseDataModel.fromJson(String source) =>
      ApodResponseDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ApodResponseDataModel(serviceVersion: $serviceVersion, mediaType: $mediaType, date: $date, title: $title, explanation: $explanation, url: $url, hdUrl: $hdUrl)';
  }

  @override
  bool operator ==(covariant ApodResponseDataModel other) {
    if (identical(this, other)) return true;

    return other.serviceVersion == serviceVersion &&
        other.mediaType == mediaType &&
        other.date == date &&
        other.title == title &&
        other.explanation == explanation &&
        other.url == url &&
        other.hdUrl == hdUrl;
  }

  @override
  int get hashCode {
    return serviceVersion.hashCode ^
        mediaType.hashCode ^
        date.hashCode ^
        title.hashCode ^
        explanation.hashCode ^
        url.hashCode ^
        hdUrl.hashCode;
  }
}
