import 'dart:convert';

import 'package:today_sky/core/extensions/datetime_extension.dart';

class ApodRequestDataModel {
  final DateTime date;
  final DateTime? endDate;
  final int? count;
  final bool? thumbs;

  ApodRequestDataModel({
    required this.date,
    this.endDate,
    this.count,
    this.thumbs,
  });

  ApodRequestDataModel copyWith({
    DateTime? date,
    DateTime? endDate,
    int? count,
    bool? thumbs,
    String? apiKey,
  }) {
    return ApodRequestDataModel(
      date: date ?? this.date,
      endDate: endDate ?? this.endDate,
      count: count ?? this.count,
      thumbs: thumbs ?? this.thumbs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.toFormattedDateTimeString,
      if (endDate != null) 'endDate': endDate!.toFormattedDateTimeString,
      if (count != null) 'count': count,
      if (thumbs != null) 'thumbs': thumbs,
    };
  }

  factory ApodRequestDataModel.defaultRequest() =>
      ApodRequestDataModel(date: DateTime.now());

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ApodRequestDataModel(date: $date, endDate: $endDate, count: $count, thumbs: $thumbs)';
  }
}
