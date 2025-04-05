import 'package:freezed_annotation/freezed_annotation.dart';

part 'juice_model.freezed.dart';
part 'juice_model.g.dart';

@freezed
class JuiceModel with _$JuiceModel {
  const factory JuiceModel({
    required String id,
    required String name,
    required String description,
    required String mood,
    required String activity,
    @JsonKey(name: 'emoji_cocktail') required String emojiCocktail,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _JuiceModel;

  factory JuiceModel.fromJson(Map<String, dynamic> json) => _$JuiceModelFromJson(json);
}
