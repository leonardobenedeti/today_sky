// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:today_sky/data/enum/media_type_enum.dart';

class ApodResponseDataModel {
  final String? id;
  final String serviceVersion;
  final MediaType mediaType;
  final DateTime date;
  final String title;
  final String explanation;
  final String url;
  final String hdUrl;

  ApodResponseDataModel({
    this.id,
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
      id: id ?? id,
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
      id: map['id'] ?? '',
      serviceVersion: map['service_version'] ?? '',
      mediaType: MediaType.typeFromJson(map['media_type']),
      date: DateTime.parse(map['date']),
      title: map['title'] ?? '',
      explanation: map['explanation'] ?? '',
      url: map['url'] ?? '',
      hdUrl: map['hdurl'] ?? '',
    );
  }

  // TODO(leo): Create an datetime utils and move this and from request model
  String formattedDateTime(DateTime date) =>
      DateFormat('yyyy-MM-dd').format(date);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id ?? DateTime.now().hashCode,
      'service_version': serviceVersion,
      'media_type': mediaType.name,
      'date': formattedDateTime(date),
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
    return 'ApodResponseDataModel(id: $id, serviceVersion: $serviceVersion, mediaType: $mediaType, date: $date, title: $title, explanation: $explanation, url: $url, hdUrl: $hdUrl)';
  }
}
