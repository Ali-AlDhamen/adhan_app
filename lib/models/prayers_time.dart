import 'package:freezed_annotation/freezed_annotation.dart';

part 'prayers_time.freezed.dart';
part 'prayers_time.g.dart';

@freezed
class PrayersTime with _$PrayersTime {
  factory PrayersTime({
    @JsonKey(name: 'date') required Map<String, dynamic> date,
    @JsonKey(name: 'timings') required Map<String, dynamic> timings,
  }) = _PrayersTime;

  factory PrayersTime.fromJson(Map<String, dynamic> json) =>
      _$PrayersTimeFromJson(json);
}
