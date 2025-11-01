// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paged_messages_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PagedMessagesResponse {

 List<ChatMessage> get messages; String? get nextCursor;
/// Create a copy of PagedMessagesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PagedMessagesResponseCopyWith<PagedMessagesResponse> get copyWith => _$PagedMessagesResponseCopyWithImpl<PagedMessagesResponse>(this as PagedMessagesResponse, _$identity);

  /// Serializes this PagedMessagesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PagedMessagesResponse&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(messages),nextCursor);

@override
String toString() {
  return 'PagedMessagesResponse(messages: $messages, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class $PagedMessagesResponseCopyWith<$Res>  {
  factory $PagedMessagesResponseCopyWith(PagedMessagesResponse value, $Res Function(PagedMessagesResponse) _then) = _$PagedMessagesResponseCopyWithImpl;
@useResult
$Res call({
 List<ChatMessage> messages, String? nextCursor
});




}
/// @nodoc
class _$PagedMessagesResponseCopyWithImpl<$Res>
    implements $PagedMessagesResponseCopyWith<$Res> {
  _$PagedMessagesResponseCopyWithImpl(this._self, this._then);

  final PagedMessagesResponse _self;
  final $Res Function(PagedMessagesResponse) _then;

/// Create a copy of PagedMessagesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,Object? nextCursor = freezed,}) {
  return _then(_self.copyWith(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PagedMessagesResponse].
extension PagedMessagesResponsePatterns on PagedMessagesResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PagedMessagesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PagedMessagesResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PagedMessagesResponse value)  $default,){
final _that = this;
switch (_that) {
case _PagedMessagesResponse():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PagedMessagesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PagedMessagesResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatMessage> messages,  String? nextCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PagedMessagesResponse() when $default != null:
return $default(_that.messages,_that.nextCursor);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatMessage> messages,  String? nextCursor)  $default,) {final _that = this;
switch (_that) {
case _PagedMessagesResponse():
return $default(_that.messages,_that.nextCursor);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatMessage> messages,  String? nextCursor)?  $default,) {final _that = this;
switch (_that) {
case _PagedMessagesResponse() when $default != null:
return $default(_that.messages,_that.nextCursor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PagedMessagesResponse implements PagedMessagesResponse {
  const _PagedMessagesResponse({required final  List<ChatMessage> messages, this.nextCursor}): _messages = messages;
  factory _PagedMessagesResponse.fromJson(Map<String, dynamic> json) => _$PagedMessagesResponseFromJson(json);

 final  List<ChatMessage> _messages;
@override List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override final  String? nextCursor;

/// Create a copy of PagedMessagesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PagedMessagesResponseCopyWith<_PagedMessagesResponse> get copyWith => __$PagedMessagesResponseCopyWithImpl<_PagedMessagesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PagedMessagesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PagedMessagesResponse&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),nextCursor);

@override
String toString() {
  return 'PagedMessagesResponse(messages: $messages, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class _$PagedMessagesResponseCopyWith<$Res> implements $PagedMessagesResponseCopyWith<$Res> {
  factory _$PagedMessagesResponseCopyWith(_PagedMessagesResponse value, $Res Function(_PagedMessagesResponse) _then) = __$PagedMessagesResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ChatMessage> messages, String? nextCursor
});




}
/// @nodoc
class __$PagedMessagesResponseCopyWithImpl<$Res>
    implements _$PagedMessagesResponseCopyWith<$Res> {
  __$PagedMessagesResponseCopyWithImpl(this._self, this._then);

  final _PagedMessagesResponse _self;
  final $Res Function(_PagedMessagesResponse) _then;

/// Create a copy of PagedMessagesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? nextCursor = freezed,}) {
  return _then(_PagedMessagesResponse(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
