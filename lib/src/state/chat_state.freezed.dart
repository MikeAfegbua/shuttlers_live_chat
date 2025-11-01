// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatState {

 bool get connected; List<ChatMessage> get messages; bool get loading; String? get error; int get presenceCount; Set<String> get typingUsers; Map<String, String> get deliveryByClientId; Set<String> get seenClientIds;
/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatStateCopyWith<ChatState> get copyWith => _$ChatStateCopyWithImpl<ChatState>(this as ChatState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatState&&(identical(other.connected, connected) || other.connected == connected)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.error, error) || other.error == error)&&(identical(other.presenceCount, presenceCount) || other.presenceCount == presenceCount)&&const DeepCollectionEquality().equals(other.typingUsers, typingUsers)&&const DeepCollectionEquality().equals(other.deliveryByClientId, deliveryByClientId)&&const DeepCollectionEquality().equals(other.seenClientIds, seenClientIds));
}


@override
int get hashCode => Object.hash(runtimeType,connected,const DeepCollectionEquality().hash(messages),loading,error,presenceCount,const DeepCollectionEquality().hash(typingUsers),const DeepCollectionEquality().hash(deliveryByClientId),const DeepCollectionEquality().hash(seenClientIds));

@override
String toString() {
  return 'ChatState(connected: $connected, messages: $messages, loading: $loading, error: $error, presenceCount: $presenceCount, typingUsers: $typingUsers, deliveryByClientId: $deliveryByClientId, seenClientIds: $seenClientIds)';
}


}

/// @nodoc
abstract mixin class $ChatStateCopyWith<$Res>  {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) _then) = _$ChatStateCopyWithImpl;
@useResult
$Res call({
 bool connected, List<ChatMessage> messages, bool loading, String? error, int presenceCount, Set<String> typingUsers, Map<String, String> deliveryByClientId, Set<String> seenClientIds
});




}
/// @nodoc
class _$ChatStateCopyWithImpl<$Res>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._self, this._then);

  final ChatState _self;
  final $Res Function(ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? connected = null,Object? messages = null,Object? loading = null,Object? error = freezed,Object? presenceCount = null,Object? typingUsers = null,Object? deliveryByClientId = null,Object? seenClientIds = null,}) {
  return _then(_self.copyWith(
connected: null == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,presenceCount: null == presenceCount ? _self.presenceCount : presenceCount // ignore: cast_nullable_to_non_nullable
as int,typingUsers: null == typingUsers ? _self.typingUsers : typingUsers // ignore: cast_nullable_to_non_nullable
as Set<String>,deliveryByClientId: null == deliveryByClientId ? _self.deliveryByClientId : deliveryByClientId // ignore: cast_nullable_to_non_nullable
as Map<String, String>,seenClientIds: null == seenClientIds ? _self.seenClientIds : seenClientIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatState].
extension ChatStatePatterns on ChatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatState value)  $default,){
final _that = this;
switch (_that) {
case _ChatState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatState value)?  $default,){
final _that = this;
switch (_that) {
case _ChatState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool connected,  List<ChatMessage> messages,  bool loading,  String? error,  int presenceCount,  Set<String> typingUsers,  Map<String, String> deliveryByClientId,  Set<String> seenClientIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that.connected,_that.messages,_that.loading,_that.error,_that.presenceCount,_that.typingUsers,_that.deliveryByClientId,_that.seenClientIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool connected,  List<ChatMessage> messages,  bool loading,  String? error,  int presenceCount,  Set<String> typingUsers,  Map<String, String> deliveryByClientId,  Set<String> seenClientIds)  $default,) {final _that = this;
switch (_that) {
case _ChatState():
return $default(_that.connected,_that.messages,_that.loading,_that.error,_that.presenceCount,_that.typingUsers,_that.deliveryByClientId,_that.seenClientIds);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool connected,  List<ChatMessage> messages,  bool loading,  String? error,  int presenceCount,  Set<String> typingUsers,  Map<String, String> deliveryByClientId,  Set<String> seenClientIds)?  $default,) {final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that.connected,_that.messages,_that.loading,_that.error,_that.presenceCount,_that.typingUsers,_that.deliveryByClientId,_that.seenClientIds);case _:
  return null;

}
}

}

/// @nodoc


class _ChatState implements ChatState {
  const _ChatState({this.connected = false, final  List<ChatMessage> messages = const <ChatMessage>[], this.loading = false, this.error, this.presenceCount = 0, final  Set<String> typingUsers = const <String>{}, final  Map<String, String> deliveryByClientId = const <String, String>{}, final  Set<String> seenClientIds = const <String>{}}): _messages = messages,_typingUsers = typingUsers,_deliveryByClientId = deliveryByClientId,_seenClientIds = seenClientIds;
  

@override@JsonKey() final  bool connected;
 final  List<ChatMessage> _messages;
@override@JsonKey() List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  bool loading;
@override final  String? error;
@override@JsonKey() final  int presenceCount;
 final  Set<String> _typingUsers;
@override@JsonKey() Set<String> get typingUsers {
  if (_typingUsers is EqualUnmodifiableSetView) return _typingUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_typingUsers);
}

 final  Map<String, String> _deliveryByClientId;
@override@JsonKey() Map<String, String> get deliveryByClientId {
  if (_deliveryByClientId is EqualUnmodifiableMapView) return _deliveryByClientId;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_deliveryByClientId);
}

 final  Set<String> _seenClientIds;
@override@JsonKey() Set<String> get seenClientIds {
  if (_seenClientIds is EqualUnmodifiableSetView) return _seenClientIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_seenClientIds);
}


/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatStateCopyWith<_ChatState> get copyWith => __$ChatStateCopyWithImpl<_ChatState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatState&&(identical(other.connected, connected) || other.connected == connected)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.error, error) || other.error == error)&&(identical(other.presenceCount, presenceCount) || other.presenceCount == presenceCount)&&const DeepCollectionEquality().equals(other._typingUsers, _typingUsers)&&const DeepCollectionEquality().equals(other._deliveryByClientId, _deliveryByClientId)&&const DeepCollectionEquality().equals(other._seenClientIds, _seenClientIds));
}


@override
int get hashCode => Object.hash(runtimeType,connected,const DeepCollectionEquality().hash(_messages),loading,error,presenceCount,const DeepCollectionEquality().hash(_typingUsers),const DeepCollectionEquality().hash(_deliveryByClientId),const DeepCollectionEquality().hash(_seenClientIds));

@override
String toString() {
  return 'ChatState(connected: $connected, messages: $messages, loading: $loading, error: $error, presenceCount: $presenceCount, typingUsers: $typingUsers, deliveryByClientId: $deliveryByClientId, seenClientIds: $seenClientIds)';
}


}

/// @nodoc
abstract mixin class _$ChatStateCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory _$ChatStateCopyWith(_ChatState value, $Res Function(_ChatState) _then) = __$ChatStateCopyWithImpl;
@override @useResult
$Res call({
 bool connected, List<ChatMessage> messages, bool loading, String? error, int presenceCount, Set<String> typingUsers, Map<String, String> deliveryByClientId, Set<String> seenClientIds
});




}
/// @nodoc
class __$ChatStateCopyWithImpl<$Res>
    implements _$ChatStateCopyWith<$Res> {
  __$ChatStateCopyWithImpl(this._self, this._then);

  final _ChatState _self;
  final $Res Function(_ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? connected = null,Object? messages = null,Object? loading = null,Object? error = freezed,Object? presenceCount = null,Object? typingUsers = null,Object? deliveryByClientId = null,Object? seenClientIds = null,}) {
  return _then(_ChatState(
connected: null == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,presenceCount: null == presenceCount ? _self.presenceCount : presenceCount // ignore: cast_nullable_to_non_nullable
as int,typingUsers: null == typingUsers ? _self._typingUsers : typingUsers // ignore: cast_nullable_to_non_nullable
as Set<String>,deliveryByClientId: null == deliveryByClientId ? _self._deliveryByClientId : deliveryByClientId // ignore: cast_nullable_to_non_nullable
as Map<String, String>,seenClientIds: null == seenClientIds ? _self._seenClientIds : seenClientIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
