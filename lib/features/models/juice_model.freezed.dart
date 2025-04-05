// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'juice_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

JuiceModel _$JuiceModelFromJson(Map<String, dynamic> json) {
  return _JuiceModel.fromJson(json);
}

/// @nodoc
mixin _$JuiceModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get mood => throw _privateConstructorUsedError;
  String get activity => throw _privateConstructorUsedError;
  @JsonKey(name: 'emoji_cocktail')
  String get emojiCocktail => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this JuiceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JuiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JuiceModelCopyWith<JuiceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JuiceModelCopyWith<$Res> {
  factory $JuiceModelCopyWith(
    JuiceModel value,
    $Res Function(JuiceModel) then,
  ) = _$JuiceModelCopyWithImpl<$Res, JuiceModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    String mood,
    String activity,
    @JsonKey(name: 'emoji_cocktail') String emojiCocktail,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class _$JuiceModelCopyWithImpl<$Res, $Val extends JuiceModel>
    implements $JuiceModelCopyWith<$Res> {
  _$JuiceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JuiceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? mood = null,
    Object? activity = null,
    Object? emojiCocktail = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            mood:
                null == mood
                    ? _value.mood
                    : mood // ignore: cast_nullable_to_non_nullable
                        as String,
            activity:
                null == activity
                    ? _value.activity
                    : activity // ignore: cast_nullable_to_non_nullable
                        as String,
            emojiCocktail:
                null == emojiCocktail
                    ? _value.emojiCocktail
                    : emojiCocktail // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JuiceModelImplCopyWith<$Res>
    implements $JuiceModelCopyWith<$Res> {
  factory _$$JuiceModelImplCopyWith(
    _$JuiceModelImpl value,
    $Res Function(_$JuiceModelImpl) then,
  ) = __$$JuiceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    String mood,
    String activity,
    @JsonKey(name: 'emoji_cocktail') String emojiCocktail,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class __$$JuiceModelImplCopyWithImpl<$Res>
    extends _$JuiceModelCopyWithImpl<$Res, _$JuiceModelImpl>
    implements _$$JuiceModelImplCopyWith<$Res> {
  __$$JuiceModelImplCopyWithImpl(
    _$JuiceModelImpl _value,
    $Res Function(_$JuiceModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JuiceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? mood = null,
    Object? activity = null,
    Object? emojiCocktail = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$JuiceModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        mood:
            null == mood
                ? _value.mood
                : mood // ignore: cast_nullable_to_non_nullable
                    as String,
        activity:
            null == activity
                ? _value.activity
                : activity // ignore: cast_nullable_to_non_nullable
                    as String,
        emojiCocktail:
            null == emojiCocktail
                ? _value.emojiCocktail
                : emojiCocktail // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JuiceModelImpl implements _JuiceModel {
  const _$JuiceModelImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.mood,
    required this.activity,
    @JsonKey(name: 'emoji_cocktail') required this.emojiCocktail,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$JuiceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$JuiceModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String mood;
  @override
  final String activity;
  @override
  @JsonKey(name: 'emoji_cocktail')
  final String emojiCocktail;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'JuiceModel(id: $id, name: $name, description: $description, mood: $mood, activity: $activity, emojiCocktail: $emojiCocktail, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JuiceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.mood, mood) || other.mood == mood) &&
            (identical(other.activity, activity) ||
                other.activity == activity) &&
            (identical(other.emojiCocktail, emojiCocktail) ||
                other.emojiCocktail == emojiCocktail) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    mood,
    activity,
    emojiCocktail,
    createdAt,
  );

  /// Create a copy of JuiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JuiceModelImplCopyWith<_$JuiceModelImpl> get copyWith =>
      __$$JuiceModelImplCopyWithImpl<_$JuiceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JuiceModelImplToJson(this);
  }
}

abstract class _JuiceModel implements JuiceModel {
  const factory _JuiceModel({
    required final String id,
    required final String name,
    required final String description,
    required final String mood,
    required final String activity,
    @JsonKey(name: 'emoji_cocktail') required final String emojiCocktail,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
  }) = _$JuiceModelImpl;

  factory _JuiceModel.fromJson(Map<String, dynamic> json) =
      _$JuiceModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get mood;
  @override
  String get activity;
  @override
  @JsonKey(name: 'emoji_cocktail')
  String get emojiCocktail;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of JuiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JuiceModelImplCopyWith<_$JuiceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
