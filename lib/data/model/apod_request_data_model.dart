// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// date	YYYY-MM-DD	today	The date of the APOD image to retrieve
// start_date	YYYY-MM-DD	none	The start of a date range, when requesting date for a range of dates. Cannot be used with date.
// end_date	YYYY-MM-DD	today	The end of the date range, when used with start_date.
// count	int	none	If this is specified then count randomly chosen images will be returned. Cannot be used with date or start_date and end_date.
// thumbs	bool	False	Return the URL of video thumbnail. If an APOD is not a video, this parameter is ignored.
// api_key	string	DEMO_KEY	api.nasa.gov key for expanded usage

class ApodRequestDataModel {
  final DateTime date;
  final DateTime endDate;
  final int count;
  final bool thumbs;
  final String apiKey;

  ApodRequestDataModel({
    required this.date,
    required this.endDate,
    required this.count,
    required this.thumbs,
    required this.apiKey,
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
      apiKey: apiKey ?? this.apiKey,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'count': count,
      'thumbs': thumbs,
      'apiKey': apiKey,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ApodRequestDataModel(date: $date, endDate: $endDate, count: $count, thumbs: $thumbs, apiKey: $apiKey)';
  }

  @override
  bool operator ==(covariant ApodRequestDataModel other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.endDate == endDate &&
        other.count == count &&
        other.thumbs == thumbs &&
        other.apiKey == apiKey;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        endDate.hashCode ^
        count.hashCode ^
        thumbs.hashCode ^
        apiKey.hashCode;
  }
}
