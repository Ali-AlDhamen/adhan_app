// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Dhkir {
  String dhkirName;
  int dhkirCount;

  Dhkir({
    required this.dhkirName,
    required this.dhkirCount,
  });

  Dhkir copyWith({
    String? dhkirName,
    int? dhkirCount,
  }) {
    return Dhkir(
      dhkirName: dhkirName ?? this.dhkirName,
      dhkirCount: dhkirCount ?? this.dhkirCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dhkirName': dhkirName,
      'dhkirCount': dhkirCount,
    };
  }

  factory Dhkir.fromMap(Map<String, dynamic> map) {
    return Dhkir(
      dhkirName: map['dhkirName'] as String,
      dhkirCount: map['dhkirCount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dhkir.fromJson(String source) =>
      Dhkir.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Dhkir(dhkirName: $dhkirName, dhkirCount: $dhkirCount)';

  @override
  bool operator ==(covariant Dhkir other) {
    if (identical(this, other)) return true;

    return other.dhkirName == dhkirName && other.dhkirCount == dhkirCount;
  }

  @override
  int get hashCode => dhkirName.hashCode ^ dhkirCount.hashCode;
}


// generate hive adaptor
// flutter packages pub run build_runner build --delete-conflicting-outputs

// generate hive adaptor and watch for changes
// flutter packages pub run build_runner watch --delete-conflicting-outputs
