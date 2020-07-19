// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseItem _$FirebaseItemFromJson(Map<String, dynamic> json) {
  return FirebaseItem(
    text: json['text'] as String,
    title: json['title'] as String,
    summary: json['summary'] as String,
  );
}

Map<String, dynamic> _$FirebaseItemToJson(FirebaseItem instance) =>
    <String, dynamic>{
      'text': instance.text,
      'title': instance.title,
      'summary': instance.summary,
    };
