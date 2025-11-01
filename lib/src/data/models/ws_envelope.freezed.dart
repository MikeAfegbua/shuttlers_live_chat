// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ws_envelope.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WsEnvelope {

 String get type; String? get version; Map<String, dynamic> get payload; String? get ts; String? get requestId; WsError? get error;
/// Create a copy of WsEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsEnvelopeCopyWith<WsEnvelope> get copyWith => _$WsEnvelopeCopyWithImpl<WsEnvelope>(this as WsEnvelope, _$identity);

  /// Serializes this WsEnvelope to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsEnvelope&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other.payload, payload)&&(identical(other.ts, ts) || other.ts == ts)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,const DeepCollectionEquality().hash(payload),ts,requestId,error);

@override
String toString() {
  return 'WsEnvelope(type: $type, version: $version, payload: $payload, ts: $ts, requestId: $requestId, error: $error)';
}


}

/// @nodoc
abstract mixin class $WsEnvelopeCopyWith<$Res>  {
  factory $WsEnvelopeCopyWith(WsEnvelope value, $Res Function(WsEnvelope) _then) = _$WsEnvelopeCopyWithImpl;
@useResult
$Res call({
 String type, String? version, Map<String, dynamic> payload, String? ts, String? requestId, WsError? error
});


$WsErrorCopyWith<$Res>? get error;

}
/// @nodoc
class _$WsEnvelopeCopyWithImpl<$Res>
    implements $WsEnvelopeCopyWith<$Res> {
  _$WsEnvelopeCopyWithImpl(this._self, this._then);

  final WsEnvelope _self;
  final $Res Function(WsEnvelope) _then;

/// Create a copy of WsEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = freezed,Object? payload = null,Object? ts = freezed,Object? requestId = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,ts: freezed == ts ? _self.ts : ts // ignore: cast_nullable_to_non_nullable
as String?,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as WsError?,
  ));
}
/// Create a copy of WsEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $WsErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// Adds pattern-matching-related methods to [WsEnvelope].
extension WsEnvelopePatterns on WsEnvelope {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsEnvelope value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsEnvelope() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsEnvelope value)  $default,){
final _that = this;
switch (_that) {
case _WsEnvelope():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsEnvelope value)?  $default,){
final _that = this;
switch (_that) {
case _WsEnvelope() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String? version,  Map<String, dynamic> payload,  String? ts,  String? requestId,  WsError? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsEnvelope() when $default != null:
return $default(_that.type,_that.version,_that.payload,_that.ts,_that.requestId,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String? version,  Map<String, dynamic> payload,  String? ts,  String? requestId,  WsError? error)  $default,) {final _that = this;
switch (_that) {
case _WsEnvelope():
return $default(_that.type,_that.version,_that.payload,_that.ts,_that.requestId,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String? version,  Map<String, dynamic> payload,  String? ts,  String? requestId,  WsError? error)?  $default,) {final _that = this;
switch (_that) {
case _WsEnvelope() when $default != null:
return $default(_that.type,_that.version,_that.payload,_that.ts,_that.requestId,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsEnvelope implements WsEnvelope {
  const _WsEnvelope({required this.type, this.version, final  Map<String, dynamic> payload = const {}, this.ts, this.requestId, this.error}): _payload = payload;
  factory _WsEnvelope.fromJson(Map<String, dynamic> json) => _$WsEnvelopeFromJson(json);

@override final  String type;
@override final  String? version;
 final  Map<String, dynamic> _payload;
@override@JsonKey() Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}

@override final  String? ts;
@override final  String? requestId;
@override final  WsError? error;

/// Create a copy of WsEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsEnvelopeCopyWith<_WsEnvelope> get copyWith => __$WsEnvelopeCopyWithImpl<_WsEnvelope>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsEnvelopeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsEnvelope&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other._payload, _payload)&&(identical(other.ts, ts) || other.ts == ts)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,const DeepCollectionEquality().hash(_payload),ts,requestId,error);

@override
String toString() {
  return 'WsEnvelope(type: $type, version: $version, payload: $payload, ts: $ts, requestId: $requestId, error: $error)';
}


}

/// @nodoc
abstract mixin class _$WsEnvelopeCopyWith<$Res> implements $WsEnvelopeCopyWith<$Res> {
  factory _$WsEnvelopeCopyWith(_WsEnvelope value, $Res Function(_WsEnvelope) _then) = __$WsEnvelopeCopyWithImpl;
@override @useResult
$Res call({
 String type, String? version, Map<String, dynamic> payload, String? ts, String? requestId, WsError? error
});


@override $WsErrorCopyWith<$Res>? get error;

}
/// @nodoc
class __$WsEnvelopeCopyWithImpl<$Res>
    implements _$WsEnvelopeCopyWith<$Res> {
  __$WsEnvelopeCopyWithImpl(this._self, this._then);

  final _WsEnvelope _self;
  final $Res Function(_WsEnvelope) _then;

/// Create a copy of WsEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = freezed,Object? payload = null,Object? ts = freezed,Object? requestId = freezed,Object? error = freezed,}) {
  return _then(_WsEnvelope(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,ts: freezed == ts ? _self.ts : ts // ignore: cast_nullable_to_non_nullable
as String?,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as WsError?,
  ));
}

/// Create a copy of WsEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $WsErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// @nodoc
mixin _$WsError {

 String get code; String get message; Map<String, dynamic>? get details;
/// Create a copy of WsError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsErrorCopyWith<WsError> get copyWith => _$WsErrorCopyWithImpl<WsError>(this as WsError, _$identity);

  /// Serializes this WsError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.details, details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,const DeepCollectionEquality().hash(details));

@override
String toString() {
  return 'WsError(code: $code, message: $message, details: $details)';
}


}

/// @nodoc
abstract mixin class $WsErrorCopyWith<$Res>  {
  factory $WsErrorCopyWith(WsError value, $Res Function(WsError) _then) = _$WsErrorCopyWithImpl;
@useResult
$Res call({
 String code, String message, Map<String, dynamic>? details
});




}
/// @nodoc
class _$WsErrorCopyWithImpl<$Res>
    implements $WsErrorCopyWith<$Res> {
  _$WsErrorCopyWithImpl(this._self, this._then);

  final WsError _self;
  final $Res Function(WsError) _then;

/// Create a copy of WsError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,Object? details = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [WsError].
extension WsErrorPatterns on WsError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsError() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsError value)  $default,){
final _that = this;
switch (_that) {
case _WsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsError value)?  $default,){
final _that = this;
switch (_that) {
case _WsError() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String message,  Map<String, dynamic>? details)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsError() when $default != null:
return $default(_that.code,_that.message,_that.details);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String message,  Map<String, dynamic>? details)  $default,) {final _that = this;
switch (_that) {
case _WsError():
return $default(_that.code,_that.message,_that.details);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String message,  Map<String, dynamic>? details)?  $default,) {final _that = this;
switch (_that) {
case _WsError() when $default != null:
return $default(_that.code,_that.message,_that.details);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsError implements WsError {
  const _WsError({required this.code, required this.message, final  Map<String, dynamic>? details}): _details = details;
  factory _WsError.fromJson(Map<String, dynamic> json) => _$WsErrorFromJson(json);

@override final  String code;
@override final  String message;
 final  Map<String, dynamic>? _details;
@override Map<String, dynamic>? get details {
  final value = _details;
  if (value == null) return null;
  if (_details is EqualUnmodifiableMapView) return _details;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of WsError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsErrorCopyWith<_WsError> get copyWith => __$WsErrorCopyWithImpl<_WsError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._details, _details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,const DeepCollectionEquality().hash(_details));

@override
String toString() {
  return 'WsError(code: $code, message: $message, details: $details)';
}


}

/// @nodoc
abstract mixin class _$WsErrorCopyWith<$Res> implements $WsErrorCopyWith<$Res> {
  factory _$WsErrorCopyWith(_WsError value, $Res Function(_WsError) _then) = __$WsErrorCopyWithImpl;
@override @useResult
$Res call({
 String code, String message, Map<String, dynamic>? details
});




}
/// @nodoc
class __$WsErrorCopyWithImpl<$Res>
    implements _$WsErrorCopyWith<$Res> {
  __$WsErrorCopyWithImpl(this._self, this._then);

  final _WsError _self;
  final $Res Function(_WsError) _then;

/// Create a copy of WsError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? details = freezed,}) {
  return _then(_WsError(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self._details : details // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$MessageCreatedPayload {

 String get id; String get clientId; String get tripId; String get userId; String get username; String get text; String get createdAt; String? get avatarUrl;
/// Create a copy of MessageCreatedPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageCreatedPayloadCopyWith<MessageCreatedPayload> get copyWith => _$MessageCreatedPayloadCopyWithImpl<MessageCreatedPayload>(this as MessageCreatedPayload, _$identity);

  /// Serializes this MessageCreatedPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageCreatedPayload&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,clientId,tripId,userId,username,text,createdAt,avatarUrl);

@override
String toString() {
  return 'MessageCreatedPayload(id: $id, clientId: $clientId, tripId: $tripId, userId: $userId, username: $username, text: $text, createdAt: $createdAt, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $MessageCreatedPayloadCopyWith<$Res>  {
  factory $MessageCreatedPayloadCopyWith(MessageCreatedPayload value, $Res Function(MessageCreatedPayload) _then) = _$MessageCreatedPayloadCopyWithImpl;
@useResult
$Res call({
 String id, String clientId, String tripId, String userId, String username, String text, String createdAt, String? avatarUrl
});




}
/// @nodoc
class _$MessageCreatedPayloadCopyWithImpl<$Res>
    implements $MessageCreatedPayloadCopyWith<$Res> {
  _$MessageCreatedPayloadCopyWithImpl(this._self, this._then);

  final MessageCreatedPayload _self;
  final $Res Function(MessageCreatedPayload) _then;

/// Create a copy of MessageCreatedPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? clientId = null,Object? tripId = null,Object? userId = null,Object? username = null,Object? text = null,Object? createdAt = null,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageCreatedPayload].
extension MessageCreatedPayloadPatterns on MessageCreatedPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageCreatedPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageCreatedPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageCreatedPayload value)  $default,){
final _that = this;
switch (_that) {
case _MessageCreatedPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageCreatedPayload value)?  $default,){
final _that = this;
switch (_that) {
case _MessageCreatedPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String clientId,  String tripId,  String userId,  String username,  String text,  String createdAt,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageCreatedPayload() when $default != null:
return $default(_that.id,_that.clientId,_that.tripId,_that.userId,_that.username,_that.text,_that.createdAt,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String clientId,  String tripId,  String userId,  String username,  String text,  String createdAt,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _MessageCreatedPayload():
return $default(_that.id,_that.clientId,_that.tripId,_that.userId,_that.username,_that.text,_that.createdAt,_that.avatarUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String clientId,  String tripId,  String userId,  String username,  String text,  String createdAt,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _MessageCreatedPayload() when $default != null:
return $default(_that.id,_that.clientId,_that.tripId,_that.userId,_that.username,_that.text,_that.createdAt,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageCreatedPayload implements MessageCreatedPayload {
  const _MessageCreatedPayload({required this.id, required this.clientId, required this.tripId, required this.userId, required this.username, required this.text, required this.createdAt, this.avatarUrl});
  factory _MessageCreatedPayload.fromJson(Map<String, dynamic> json) => _$MessageCreatedPayloadFromJson(json);

@override final  String id;
@override final  String clientId;
@override final  String tripId;
@override final  String userId;
@override final  String username;
@override final  String text;
@override final  String createdAt;
@override final  String? avatarUrl;

/// Create a copy of MessageCreatedPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageCreatedPayloadCopyWith<_MessageCreatedPayload> get copyWith => __$MessageCreatedPayloadCopyWithImpl<_MessageCreatedPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageCreatedPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageCreatedPayload&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,clientId,tripId,userId,username,text,createdAt,avatarUrl);

@override
String toString() {
  return 'MessageCreatedPayload(id: $id, clientId: $clientId, tripId: $tripId, userId: $userId, username: $username, text: $text, createdAt: $createdAt, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$MessageCreatedPayloadCopyWith<$Res> implements $MessageCreatedPayloadCopyWith<$Res> {
  factory _$MessageCreatedPayloadCopyWith(_MessageCreatedPayload value, $Res Function(_MessageCreatedPayload) _then) = __$MessageCreatedPayloadCopyWithImpl;
@override @useResult
$Res call({
 String id, String clientId, String tripId, String userId, String username, String text, String createdAt, String? avatarUrl
});




}
/// @nodoc
class __$MessageCreatedPayloadCopyWithImpl<$Res>
    implements _$MessageCreatedPayloadCopyWith<$Res> {
  __$MessageCreatedPayloadCopyWithImpl(this._self, this._then);

  final _MessageCreatedPayload _self;
  final $Res Function(_MessageCreatedPayload) _then;

/// Create a copy of MessageCreatedPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? clientId = null,Object? tripId = null,Object? userId = null,Object? username = null,Object? text = null,Object? createdAt = null,Object? avatarUrl = freezed,}) {
  return _then(_MessageCreatedPayload(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MessageAckPayload {

 String get clientId; String get serverId; String get status;
/// Create a copy of MessageAckPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageAckPayloadCopyWith<MessageAckPayload> get copyWith => _$MessageAckPayloadCopyWithImpl<MessageAckPayload>(this as MessageAckPayload, _$identity);

  /// Serializes this MessageAckPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageAckPayload&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,serverId,status);

@override
String toString() {
  return 'MessageAckPayload(clientId: $clientId, serverId: $serverId, status: $status)';
}


}

/// @nodoc
abstract mixin class $MessageAckPayloadCopyWith<$Res>  {
  factory $MessageAckPayloadCopyWith(MessageAckPayload value, $Res Function(MessageAckPayload) _then) = _$MessageAckPayloadCopyWithImpl;
@useResult
$Res call({
 String clientId, String serverId, String status
});




}
/// @nodoc
class _$MessageAckPayloadCopyWithImpl<$Res>
    implements $MessageAckPayloadCopyWith<$Res> {
  _$MessageAckPayloadCopyWithImpl(this._self, this._then);

  final MessageAckPayload _self;
  final $Res Function(MessageAckPayload) _then;

/// Create a copy of MessageAckPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientId = null,Object? serverId = null,Object? status = null,}) {
  return _then(_self.copyWith(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageAckPayload].
extension MessageAckPayloadPatterns on MessageAckPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageAckPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageAckPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageAckPayload value)  $default,){
final _that = this;
switch (_that) {
case _MessageAckPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageAckPayload value)?  $default,){
final _that = this;
switch (_that) {
case _MessageAckPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String clientId,  String serverId,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageAckPayload() when $default != null:
return $default(_that.clientId,_that.serverId,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String clientId,  String serverId,  String status)  $default,) {final _that = this;
switch (_that) {
case _MessageAckPayload():
return $default(_that.clientId,_that.serverId,_that.status);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String clientId,  String serverId,  String status)?  $default,) {final _that = this;
switch (_that) {
case _MessageAckPayload() when $default != null:
return $default(_that.clientId,_that.serverId,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageAckPayload implements MessageAckPayload {
  const _MessageAckPayload({required this.clientId, required this.serverId, required this.status});
  factory _MessageAckPayload.fromJson(Map<String, dynamic> json) => _$MessageAckPayloadFromJson(json);

@override final  String clientId;
@override final  String serverId;
@override final  String status;

/// Create a copy of MessageAckPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageAckPayloadCopyWith<_MessageAckPayload> get copyWith => __$MessageAckPayloadCopyWithImpl<_MessageAckPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageAckPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageAckPayload&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,serverId,status);

@override
String toString() {
  return 'MessageAckPayload(clientId: $clientId, serverId: $serverId, status: $status)';
}


}

/// @nodoc
abstract mixin class _$MessageAckPayloadCopyWith<$Res> implements $MessageAckPayloadCopyWith<$Res> {
  factory _$MessageAckPayloadCopyWith(_MessageAckPayload value, $Res Function(_MessageAckPayload) _then) = __$MessageAckPayloadCopyWithImpl;
@override @useResult
$Res call({
 String clientId, String serverId, String status
});




}
/// @nodoc
class __$MessageAckPayloadCopyWithImpl<$Res>
    implements _$MessageAckPayloadCopyWith<$Res> {
  __$MessageAckPayloadCopyWithImpl(this._self, this._then);

  final _MessageAckPayload _self;
  final $Res Function(_MessageAckPayload) _then;

/// Create a copy of MessageAckPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientId = null,Object? serverId = null,Object? status = null,}) {
  return _then(_MessageAckPayload(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TypingPayload {

 String get userId; String get username;
/// Create a copy of TypingPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TypingPayloadCopyWith<TypingPayload> get copyWith => _$TypingPayloadCopyWithImpl<TypingPayload>(this as TypingPayload, _$identity);

  /// Serializes this TypingPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TypingPayload&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,username);

@override
String toString() {
  return 'TypingPayload(userId: $userId, username: $username)';
}


}

/// @nodoc
abstract mixin class $TypingPayloadCopyWith<$Res>  {
  factory $TypingPayloadCopyWith(TypingPayload value, $Res Function(TypingPayload) _then) = _$TypingPayloadCopyWithImpl;
@useResult
$Res call({
 String userId, String username
});




}
/// @nodoc
class _$TypingPayloadCopyWithImpl<$Res>
    implements $TypingPayloadCopyWith<$Res> {
  _$TypingPayloadCopyWithImpl(this._self, this._then);

  final TypingPayload _self;
  final $Res Function(TypingPayload) _then;

/// Create a copy of TypingPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? username = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TypingPayload].
extension TypingPayloadPatterns on TypingPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TypingPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TypingPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TypingPayload value)  $default,){
final _that = this;
switch (_that) {
case _TypingPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TypingPayload value)?  $default,){
final _that = this;
switch (_that) {
case _TypingPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String username)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TypingPayload() when $default != null:
return $default(_that.userId,_that.username);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String username)  $default,) {final _that = this;
switch (_that) {
case _TypingPayload():
return $default(_that.userId,_that.username);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String username)?  $default,) {final _that = this;
switch (_that) {
case _TypingPayload() when $default != null:
return $default(_that.userId,_that.username);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TypingPayload implements TypingPayload {
  const _TypingPayload({required this.userId, required this.username});
  factory _TypingPayload.fromJson(Map<String, dynamic> json) => _$TypingPayloadFromJson(json);

@override final  String userId;
@override final  String username;

/// Create a copy of TypingPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TypingPayloadCopyWith<_TypingPayload> get copyWith => __$TypingPayloadCopyWithImpl<_TypingPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TypingPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TypingPayload&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,username);

@override
String toString() {
  return 'TypingPayload(userId: $userId, username: $username)';
}


}

/// @nodoc
abstract mixin class _$TypingPayloadCopyWith<$Res> implements $TypingPayloadCopyWith<$Res> {
  factory _$TypingPayloadCopyWith(_TypingPayload value, $Res Function(_TypingPayload) _then) = __$TypingPayloadCopyWithImpl;
@override @useResult
$Res call({
 String userId, String username
});




}
/// @nodoc
class __$TypingPayloadCopyWithImpl<$Res>
    implements _$TypingPayloadCopyWith<$Res> {
  __$TypingPayloadCopyWithImpl(this._self, this._then);

  final _TypingPayload _self;
  final $Res Function(_TypingPayload) _then;

/// Create a copy of TypingPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? username = null,}) {
  return _then(_TypingPayload(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PresencePayload {

 int get count;
/// Create a copy of PresencePayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PresencePayloadCopyWith<PresencePayload> get copyWith => _$PresencePayloadCopyWithImpl<PresencePayload>(this as PresencePayload, _$identity);

  /// Serializes this PresencePayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PresencePayload&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'PresencePayload(count: $count)';
}


}

/// @nodoc
abstract mixin class $PresencePayloadCopyWith<$Res>  {
  factory $PresencePayloadCopyWith(PresencePayload value, $Res Function(PresencePayload) _then) = _$PresencePayloadCopyWithImpl;
@useResult
$Res call({
 int count
});




}
/// @nodoc
class _$PresencePayloadCopyWithImpl<$Res>
    implements $PresencePayloadCopyWith<$Res> {
  _$PresencePayloadCopyWithImpl(this._self, this._then);

  final PresencePayload _self;
  final $Res Function(PresencePayload) _then;

/// Create a copy of PresencePayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PresencePayload].
extension PresencePayloadPatterns on PresencePayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PresencePayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PresencePayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PresencePayload value)  $default,){
final _that = this;
switch (_that) {
case _PresencePayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PresencePayload value)?  $default,){
final _that = this;
switch (_that) {
case _PresencePayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PresencePayload() when $default != null:
return $default(_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count)  $default,) {final _that = this;
switch (_that) {
case _PresencePayload():
return $default(_that.count);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count)?  $default,) {final _that = this;
switch (_that) {
case _PresencePayload() when $default != null:
return $default(_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PresencePayload implements PresencePayload {
  const _PresencePayload({required this.count});
  factory _PresencePayload.fromJson(Map<String, dynamic> json) => _$PresencePayloadFromJson(json);

@override final  int count;

/// Create a copy of PresencePayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PresencePayloadCopyWith<_PresencePayload> get copyWith => __$PresencePayloadCopyWithImpl<_PresencePayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PresencePayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PresencePayload&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'PresencePayload(count: $count)';
}


}

/// @nodoc
abstract mixin class _$PresencePayloadCopyWith<$Res> implements $PresencePayloadCopyWith<$Res> {
  factory _$PresencePayloadCopyWith(_PresencePayload value, $Res Function(_PresencePayload) _then) = __$PresencePayloadCopyWithImpl;
@override @useResult
$Res call({
 int count
});




}
/// @nodoc
class __$PresencePayloadCopyWithImpl<$Res>
    implements _$PresencePayloadCopyWith<$Res> {
  __$PresencePayloadCopyWithImpl(this._self, this._then);

  final _PresencePayload _self;
  final $Res Function(_PresencePayload) _then;

/// Create a copy of PresencePayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(_PresencePayload(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MessageSendPayload {

 String get tripId; String get clientId; String get text;
/// Create a copy of MessageSendPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageSendPayloadCopyWith<MessageSendPayload> get copyWith => _$MessageSendPayloadCopyWithImpl<MessageSendPayload>(this as MessageSendPayload, _$identity);

  /// Serializes this MessageSendPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageSendPayload&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tripId,clientId,text);

@override
String toString() {
  return 'MessageSendPayload(tripId: $tripId, clientId: $clientId, text: $text)';
}


}

/// @nodoc
abstract mixin class $MessageSendPayloadCopyWith<$Res>  {
  factory $MessageSendPayloadCopyWith(MessageSendPayload value, $Res Function(MessageSendPayload) _then) = _$MessageSendPayloadCopyWithImpl;
@useResult
$Res call({
 String tripId, String clientId, String text
});




}
/// @nodoc
class _$MessageSendPayloadCopyWithImpl<$Res>
    implements $MessageSendPayloadCopyWith<$Res> {
  _$MessageSendPayloadCopyWithImpl(this._self, this._then);

  final MessageSendPayload _self;
  final $Res Function(MessageSendPayload) _then;

/// Create a copy of MessageSendPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? clientId = null,Object? text = null,}) {
  return _then(_self.copyWith(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageSendPayload].
extension MessageSendPayloadPatterns on MessageSendPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageSendPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageSendPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageSendPayload value)  $default,){
final _that = this;
switch (_that) {
case _MessageSendPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageSendPayload value)?  $default,){
final _that = this;
switch (_that) {
case _MessageSendPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String clientId,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageSendPayload() when $default != null:
return $default(_that.tripId,_that.clientId,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String clientId,  String text)  $default,) {final _that = this;
switch (_that) {
case _MessageSendPayload():
return $default(_that.tripId,_that.clientId,_that.text);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String clientId,  String text)?  $default,) {final _that = this;
switch (_that) {
case _MessageSendPayload() when $default != null:
return $default(_that.tripId,_that.clientId,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageSendPayload implements MessageSendPayload {
  const _MessageSendPayload({required this.tripId, required this.clientId, required this.text});
  factory _MessageSendPayload.fromJson(Map<String, dynamic> json) => _$MessageSendPayloadFromJson(json);

@override final  String tripId;
@override final  String clientId;
@override final  String text;

/// Create a copy of MessageSendPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageSendPayloadCopyWith<_MessageSendPayload> get copyWith => __$MessageSendPayloadCopyWithImpl<_MessageSendPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageSendPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageSendPayload&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tripId,clientId,text);

@override
String toString() {
  return 'MessageSendPayload(tripId: $tripId, clientId: $clientId, text: $text)';
}


}

/// @nodoc
abstract mixin class _$MessageSendPayloadCopyWith<$Res> implements $MessageSendPayloadCopyWith<$Res> {
  factory _$MessageSendPayloadCopyWith(_MessageSendPayload value, $Res Function(_MessageSendPayload) _then) = __$MessageSendPayloadCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String clientId, String text
});




}
/// @nodoc
class __$MessageSendPayloadCopyWithImpl<$Res>
    implements _$MessageSendPayloadCopyWith<$Res> {
  __$MessageSendPayloadCopyWithImpl(this._self, this._then);

  final _MessageSendPayload _self;
  final $Res Function(_MessageSendPayload) _then;

/// Create a copy of MessageSendPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? clientId = null,Object? text = null,}) {
  return _then(_MessageSendPayload(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TypingEventPayload {

 String get tripId;
/// Create a copy of TypingEventPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TypingEventPayloadCopyWith<TypingEventPayload> get copyWith => _$TypingEventPayloadCopyWithImpl<TypingEventPayload>(this as TypingEventPayload, _$identity);

  /// Serializes this TypingEventPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TypingEventPayload&&(identical(other.tripId, tripId) || other.tripId == tripId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'TypingEventPayload(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class $TypingEventPayloadCopyWith<$Res>  {
  factory $TypingEventPayloadCopyWith(TypingEventPayload value, $Res Function(TypingEventPayload) _then) = _$TypingEventPayloadCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class _$TypingEventPayloadCopyWithImpl<$Res>
    implements $TypingEventPayloadCopyWith<$Res> {
  _$TypingEventPayloadCopyWithImpl(this._self, this._then);

  final TypingEventPayload _self;
  final $Res Function(TypingEventPayload) _then;

/// Create a copy of TypingEventPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,}) {
  return _then(_self.copyWith(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TypingEventPayload].
extension TypingEventPayloadPatterns on TypingEventPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TypingEventPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TypingEventPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TypingEventPayload value)  $default,){
final _that = this;
switch (_that) {
case _TypingEventPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TypingEventPayload value)?  $default,){
final _that = this;
switch (_that) {
case _TypingEventPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TypingEventPayload() when $default != null:
return $default(_that.tripId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId)  $default,) {final _that = this;
switch (_that) {
case _TypingEventPayload():
return $default(_that.tripId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId)?  $default,) {final _that = this;
switch (_that) {
case _TypingEventPayload() when $default != null:
return $default(_that.tripId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TypingEventPayload implements TypingEventPayload {
  const _TypingEventPayload({required this.tripId});
  factory _TypingEventPayload.fromJson(Map<String, dynamic> json) => _$TypingEventPayloadFromJson(json);

@override final  String tripId;

/// Create a copy of TypingEventPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TypingEventPayloadCopyWith<_TypingEventPayload> get copyWith => __$TypingEventPayloadCopyWithImpl<_TypingEventPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TypingEventPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TypingEventPayload&&(identical(other.tripId, tripId) || other.tripId == tripId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'TypingEventPayload(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$TypingEventPayloadCopyWith<$Res> implements $TypingEventPayloadCopyWith<$Res> {
  factory _$TypingEventPayloadCopyWith(_TypingEventPayload value, $Res Function(_TypingEventPayload) _then) = __$TypingEventPayloadCopyWithImpl;
@override @useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$TypingEventPayloadCopyWithImpl<$Res>
    implements _$TypingEventPayloadCopyWith<$Res> {
  __$TypingEventPayloadCopyWithImpl(this._self, this._then);

  final _TypingEventPayload _self;
  final $Res Function(_TypingEventPayload) _then;

/// Create a copy of TypingEventPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_TypingEventPayload(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
