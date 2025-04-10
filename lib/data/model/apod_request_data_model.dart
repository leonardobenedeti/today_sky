// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

// date	YYYY-MM-DD	today	The date of the APOD image to retrieve
// start_date	YYYY-MM-DD	none	The start of a date range, when requesting date for a range of dates. Cannot be used with date.
// end_date	YYYY-MM-DD	today	The end of the date range, when used with start_date.
// count	int	none	If this is specified then count randomly chosen images will be returned. Cannot be used with date or start_date and end_date.
// thumbs	bool	False	Return the URL of video thumbnail. If an APOD is not a video, this parameter is ignored.
// api_key	string	DEMO_KEY	api.nasa.gov key for expanded usage

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
      'date': formattedDateTime(date),
      if (endDate != null) 'endDate': formattedDateTime(endDate!),
      if (count != null) 'count': count,
      if (thumbs != null) 'thumbs': thumbs,
    };
  }

  factory ApodRequestDataModel.defaultRequest() =>
      ApodRequestDataModel(date: DateTime.now());

  String formattedDateTime(DateTime date) =>
      DateFormat('yyyy-MM-dd').format(date);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ApodRequestDataModel(date: $date, endDate: $endDate, count: $count, thumbs: $thumbs)';
  }
}
