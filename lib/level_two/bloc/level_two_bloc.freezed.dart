// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level_two_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LevelTwoEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LevelTwoEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LevelTwoEvent()';
}


}

/// @nodoc
class $LevelTwoEventCopyWith<$Res>  {
$LevelTwoEventCopyWith(LevelTwoEvent _, $Res Function(LevelTwoEvent) __);
}


/// Adds pattern-matching-related methods to [LevelTwoEvent].
extension LevelTwoEventPatterns on LevelTwoEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Infected value)?  infected,TResult Function( Safe value)?  safe,TResult Function( Check value)?  check,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Infected() when infected != null:
return infected(_that);case Safe() when safe != null:
return safe(_that);case Check() when check != null:
return check(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Infected value)  infected,required TResult Function( Safe value)  safe,required TResult Function( Check value)  check,}){
final _that = this;
switch (_that) {
case Infected():
return infected(_that);case Safe():
return safe(_that);case Check():
return check(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Infected value)?  infected,TResult? Function( Safe value)?  safe,TResult? Function( Check value)?  check,}){
final _that = this;
switch (_that) {
case Infected() when infected != null:
return infected(_that);case Safe() when safe != null:
return safe(_that);case Check() when check != null:
return check(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int serverNumber)?  infected,TResult Function( int serverNumber)?  safe,TResult Function()?  check,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Infected() when infected != null:
return infected(_that.serverNumber);case Safe() when safe != null:
return safe(_that.serverNumber);case Check() when check != null:
return check();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int serverNumber)  infected,required TResult Function( int serverNumber)  safe,required TResult Function()  check,}) {final _that = this;
switch (_that) {
case Infected():
return infected(_that.serverNumber);case Safe():
return safe(_that.serverNumber);case Check():
return check();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int serverNumber)?  infected,TResult? Function( int serverNumber)?  safe,TResult? Function()?  check,}) {final _that = this;
switch (_that) {
case Infected() when infected != null:
return infected(_that.serverNumber);case Safe() when safe != null:
return safe(_that.serverNumber);case Check() when check != null:
return check();case _:
  return null;

}
}

}

/// @nodoc


class Infected implements LevelTwoEvent {
  const Infected({required this.serverNumber});
  

 final  int serverNumber;

/// Create a copy of LevelTwoEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InfectedCopyWith<Infected> get copyWith => _$InfectedCopyWithImpl<Infected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Infected&&(identical(other.serverNumber, serverNumber) || other.serverNumber == serverNumber));
}


@override
int get hashCode => Object.hash(runtimeType,serverNumber);

@override
String toString() {
  return 'LevelTwoEvent.infected(serverNumber: $serverNumber)';
}


}

/// @nodoc
abstract mixin class $InfectedCopyWith<$Res> implements $LevelTwoEventCopyWith<$Res> {
  factory $InfectedCopyWith(Infected value, $Res Function(Infected) _then) = _$InfectedCopyWithImpl;
@useResult
$Res call({
 int serverNumber
});




}
/// @nodoc
class _$InfectedCopyWithImpl<$Res>
    implements $InfectedCopyWith<$Res> {
  _$InfectedCopyWithImpl(this._self, this._then);

  final Infected _self;
  final $Res Function(Infected) _then;

/// Create a copy of LevelTwoEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? serverNumber = null,}) {
  return _then(Infected(
serverNumber: null == serverNumber ? _self.serverNumber : serverNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class Safe implements LevelTwoEvent {
  const Safe({required this.serverNumber});
  

 final  int serverNumber;

/// Create a copy of LevelTwoEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SafeCopyWith<Safe> get copyWith => _$SafeCopyWithImpl<Safe>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Safe&&(identical(other.serverNumber, serverNumber) || other.serverNumber == serverNumber));
}


@override
int get hashCode => Object.hash(runtimeType,serverNumber);

@override
String toString() {
  return 'LevelTwoEvent.safe(serverNumber: $serverNumber)';
}


}

/// @nodoc
abstract mixin class $SafeCopyWith<$Res> implements $LevelTwoEventCopyWith<$Res> {
  factory $SafeCopyWith(Safe value, $Res Function(Safe) _then) = _$SafeCopyWithImpl;
@useResult
$Res call({
 int serverNumber
});




}
/// @nodoc
class _$SafeCopyWithImpl<$Res>
    implements $SafeCopyWith<$Res> {
  _$SafeCopyWithImpl(this._self, this._then);

  final Safe _self;
  final $Res Function(Safe) _then;

/// Create a copy of LevelTwoEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? serverNumber = null,}) {
  return _then(Safe(
serverNumber: null == serverNumber ? _self.serverNumber : serverNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class Check implements LevelTwoEvent {
  const Check();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Check);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LevelTwoEvent.check()';
}


}




/// @nodoc
mixin _$LevelTwoState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LevelTwoState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LevelTwoState()';
}


}

/// @nodoc
class $LevelTwoStateCopyWith<$Res>  {
$LevelTwoStateCopyWith(LevelTwoState _, $Res Function(LevelTwoState) __);
}


/// Adds pattern-matching-related methods to [LevelTwoState].
extension LevelTwoStatePatterns on LevelTwoState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Win value)?  win,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Win() when win != null:
return win(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Win value)  win,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Win():
return win(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Win value)?  win,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Win() when win != null:
return win(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<ServerType> winServers,  List<ServerType> servers,  int correctServers)?  initial,TResult Function()?  win,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that.winServers,_that.servers,_that.correctServers);case Win() when win != null:
return win();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<ServerType> winServers,  List<ServerType> servers,  int correctServers)  initial,required TResult Function()  win,}) {final _that = this;
switch (_that) {
case Initial():
return initial(_that.winServers,_that.servers,_that.correctServers);case Win():
return win();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<ServerType> winServers,  List<ServerType> servers,  int correctServers)?  initial,TResult? Function()?  win,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that.winServers,_that.servers,_that.correctServers);case Win() when win != null:
return win();case _:
  return null;

}
}

}

/// @nodoc


class Initial implements LevelTwoState {
  const Initial([final  List<ServerType> winServers = const <ServerType>[ServerType.infected, ServerType.infected, ServerType.safe, ServerType.infected, ServerType.safe, ServerType.safe, ServerType.infected, ServerType.safe], final  List<ServerType> servers = const <ServerType>[ServerType.unknown, ServerType.unknown, ServerType.unknown, ServerType.unknown, ServerType.unknown, ServerType.unknown, ServerType.unknown, ServerType.unknown], this.correctServers = 0]): assert(servers.length == 8, 'There should be 8 servers'),_winServers = winServers,_servers = servers;
  

 final  List<ServerType> _winServers;
@JsonKey() List<ServerType> get winServers {
  if (_winServers is EqualUnmodifiableListView) return _winServers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_winServers);
}

 final  List<ServerType> _servers;
@JsonKey() List<ServerType> get servers {
  if (_servers is EqualUnmodifiableListView) return _servers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_servers);
}

@JsonKey() final  int correctServers;

/// Create a copy of LevelTwoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialCopyWith<Initial> get copyWith => _$InitialCopyWithImpl<Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial&&const DeepCollectionEquality().equals(other._winServers, _winServers)&&const DeepCollectionEquality().equals(other._servers, _servers)&&(identical(other.correctServers, correctServers) || other.correctServers == correctServers));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_winServers),const DeepCollectionEquality().hash(_servers),correctServers);

@override
String toString() {
  return 'LevelTwoState.initial(winServers: $winServers, servers: $servers, correctServers: $correctServers)';
}


}

/// @nodoc
abstract mixin class $InitialCopyWith<$Res> implements $LevelTwoStateCopyWith<$Res> {
  factory $InitialCopyWith(Initial value, $Res Function(Initial) _then) = _$InitialCopyWithImpl;
@useResult
$Res call({
 List<ServerType> winServers, List<ServerType> servers, int correctServers
});




}
/// @nodoc
class _$InitialCopyWithImpl<$Res>
    implements $InitialCopyWith<$Res> {
  _$InitialCopyWithImpl(this._self, this._then);

  final Initial _self;
  final $Res Function(Initial) _then;

/// Create a copy of LevelTwoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? winServers = null,Object? servers = null,Object? correctServers = null,}) {
  return _then(Initial(
null == winServers ? _self._winServers : winServers // ignore: cast_nullable_to_non_nullable
as List<ServerType>,null == servers ? _self._servers : servers // ignore: cast_nullable_to_non_nullable
as List<ServerType>,null == correctServers ? _self.correctServers : correctServers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class Win implements LevelTwoState {
  const Win();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Win);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LevelTwoState.win()';
}


}




// dart format on
