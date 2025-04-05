// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JuiceModelImpl _$$JuiceModelImplFromJson(Map<String, dynamic> json) =>
    _$JuiceModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      mood: json['mood'] as String,
      activity: json['activity'] as String,
      emojiCocktail: json['emoji_cocktail'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$JuiceModelImplToJson(_$JuiceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'mood': instance.mood,
      'activity': instance.activity,
      'emoji_cocktail': instance.emojiCocktail,
      'created_at': instance.createdAt.toIso8601String(),
    };
