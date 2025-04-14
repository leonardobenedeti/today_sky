import 'dart:convert';

import 'package:today_sky/core/extensions/datetime_extension.dart';
import 'package:today_sky/data/enum/media_type_enum.dart';

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
      serviceVersion: map['service_version'] ?? '',
      mediaType: MediaType.typeFromJson(map['media_type']),
      date: DateTime.parse(map['date']),
      title: map['title'] ?? '',
      explanation: map['explanation'] ?? '',
      url: map['url'] ?? '',
      hdUrl: map['hdurl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'service_version': serviceVersion,
      'media_type': mediaType.name,
      'date': date.toFormattedDateTimeString,
      'title': title,
      'explanation': explanation,
      'url': url,
      'hdUrl': hdUrl,
    };
  }

  factory ApodResponseDataModel.fromJson(String source) =>
      ApodResponseDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ApodResponseDataModel(serviceVersion: $serviceVersion, mediaType: $mediaType, date: $date, title: $title, explanation: $explanation, url: $url, hdUrl: $hdUrl)';
  }
}
