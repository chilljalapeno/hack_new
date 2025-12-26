// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level_six_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LevelSixEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LevelSixEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LevelSixEvent()';
}


}

/// @nodoc
class $LevelSixEventCopyWith<$Res>  {
$LevelSixEventCopyWith(LevelSixEvent _, $Res Function(LevelSixEvent) __);
}


/// Adds pattern-matching-related methods to [LevelSixEvent].
extension LevelSixEventPatterns on LevelSixEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Safe value)?  safe,TResult Function( Phishing value)?  phishing,TResult Function( Complete value)?  complete,TResult Function( Change value)?  change,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Safe() when safe != null:
return safe(_that);case Phishing() when phishing != null:
return phishing(_that);case Complete() when complete != null:
return complete(_that);case Change() when change != null:
return change(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Safe value)  safe,required TResult Function( Phishing value)  phishing,required TResult Function( Complete value)  complete,required TResult Function( Change value)  change,}){
final _that = this;
switch (_that) {
case Safe():
return safe(_that);case Phishing():
return phishing(_that);case Complete():
return complete(_that);case Change():
return change(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Safe value)?  safe,TResult? Function( Phishing value)?  phishing,TResult? Function( Complete value)?  complete,TResult? Function( Change value)?  change,}){
final _that = this;
switch (_that) {
case Safe() when safe != null:
return safe(_that);case Phishing() when phishing != null:
return phishing(_that);case Complete() when complete != null:
return complete(_that);case Change() when change != null:
return change(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int emailNumber,  int numberOfSelected)?  safe,TResult Function( int emailNumber,  int numberOfSelected)?  phishing,TResult Function()?  complete,TResult Function( int emailNumber,  int increase)?  change,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Safe() when safe != null:
return safe(_that.emailNumber,_that.numberOfSelected);case Phishing() when phishing != null:
return phishing(_that.emailNumber,_that.numberOfSelected);case Complete() when complete != null:
return complete();case Change() when change != null:
return change(_that.emailNumber,_that.increase);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int emailNumber,  int numberOfSelected)  safe,required TResult Function( int emailNumber,  int numberOfSelected)  phishing,required TResult Function()  complete,required TResult Function( int emailNumber,  int increase)  change,}) {final _that = this;
switch (_that) {
case Safe():
return safe(_that.emailNumber,_that.numberOfSelected);case Phishing():
return phishing(_that.emailNumber,_that.numberOfSelected);case Complete():
return complete();case Change():
return change(_that.emailNumber,_that.increase);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int emailNumber,  int numberOfSelected)?  safe,TResult? Function( int emailNumber,  int numberOfSelected)?  phishing,TResult? Function()?  complete,TResult? Function( int emailNumber,  int increase)?  change,}) {final _that = this;
switch (_that) {
case Safe() when safe != null:
return safe(_that.emailNumber,_that.numberOfSelected);case Phishing() when phishing != null:
return phishing(_that.emailNumber,_that.numberOfSelected);case Complete() when complete != null:
return complete();case Change() when change != null:
return change(_that.emailNumber,_that.increase);case _:
  return null;

}
}

}

/// @nodoc


class Safe implements LevelSixEvent {
  const Safe({required this.emailNumber, required this.numberOfSelected});
  

 final  int emailNumber;
 final  int numberOfSelected;

/// Create a copy of LevelSixEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SafeCopyWith<Safe> get copyWith => _$SafeCopyWithImpl<Safe>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Safe&&(identical(other.emailNumber, emailNumber) || other.emailNumber == emailNumber)&&(identical(other.numberOfSelected, numberOfSelected) || other.numberOfSelected == numberOfSelected));
}


@override
int get hashCode => Object.hash(runtimeType,emailNumber,numberOfSelected);

@override
String toString() {
  return 'LevelSixEvent.safe(emailNumber: $emailNumber, numberOfSelected: $numberOfSelected)';
}


}

/// @nodoc
abstract mixin class $SafeCopyWith<$Res> implements $LevelSixEventCopyWith<$Res> {
  factory $SafeCopyWith(Safe value, $Res Function(Safe) _then) = _$SafeCopyWithImpl;
@useResult
$Res call({
 int emailNumber, int numberOfSelected
});




}
/// @nodoc
class _$SafeCopyWithImpl<$Res>
    implements $SafeCopyWith<$Res> {
  _$SafeCopyWithImpl(this._self, this._then);

  final Safe _self;
  final $Res Function(Safe) _then;

/// Create a copy of LevelSixEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? emailNumber = null,Object? numberOfSelected = null,}) {
  return _then(Safe(
emailNumber: null == emailNumber ? _self.emailNumber : emailNumber // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected: null == numberOfSelected ? _self.numberOfSelected : numberOfSelected // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class Phishing implements LevelSixEvent {
  const Phishing({required this.emailNumber, required this.numberOfSelected});
  

 final  int emailNumber;
 final  int numberOfSelected;

/// Create a copy of LevelSixEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhishingCopyWith<Phishing> get copyWith => _$PhishingCopyWithImpl<Phishing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Phishing&&(identical(other.emailNumber, emailNumber) || other.emailNumber == emailNumber)&&(identical(other.numberOfSelected, numberOfSelected) || other.numberOfSelected == numberOfSelected));
}


@override
int get hashCode => Object.hash(runtimeType,emailNumber,numberOfSelected);

@override
String toString() {
  return 'LevelSixEvent.phishing(emailNumber: $emailNumber, numberOfSelected: $numberOfSelected)';
}


}

/// @nodoc
abstract mixin class $PhishingCopyWith<$Res> implements $LevelSixEventCopyWith<$Res> {
  factory $PhishingCopyWith(Phishing value, $Res Function(Phishing) _then) = _$PhishingCopyWithImpl;
@useResult
$Res call({
 int emailNumber, int numberOfSelected
});




}
/// @nodoc
class _$PhishingCopyWithImpl<$Res>
    implements $PhishingCopyWith<$Res> {
  _$PhishingCopyWithImpl(this._self, this._then);

  final Phishing _self;
  final $Res Function(Phishing) _then;

/// Create a copy of LevelSixEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? emailNumber = null,Object? numberOfSelected = null,}) {
  return _then(Phishing(
emailNumber: null == emailNumber ? _self.emailNumber : emailNumber // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected: null == numberOfSelected ? _self.numberOfSelected : numberOfSelected // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class Complete implements LevelSixEvent {
  const Complete();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Complete);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LevelSixEvent.complete()';
}


}




/// @nodoc


class Change implements LevelSixEvent {
  const Change({required this.emailNumber, required this.increase});
  

 final  int emailNumber;
 final  int increase;

/// Create a copy of LevelSixEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeCopyWith<Change> get copyWith => _$ChangeCopyWithImpl<Change>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Change&&(identical(other.emailNumber, emailNumber) || other.emailNumber == emailNumber)&&(identical(other.increase, increase) || other.increase == increase));
}


@override
int get hashCode => Object.hash(runtimeType,emailNumber,increase);

@override
String toString() {
  return 'LevelSixEvent.change(emailNumber: $emailNumber, increase: $increase)';
}


}

/// @nodoc
abstract mixin class $ChangeCopyWith<$Res> implements $LevelSixEventCopyWith<$Res> {
  factory $ChangeCopyWith(Change value, $Res Function(Change) _then) = _$ChangeCopyWithImpl;
@useResult
$Res call({
 int emailNumber, int increase
});




}
/// @nodoc
class _$ChangeCopyWithImpl<$Res>
    implements $ChangeCopyWith<$Res> {
  _$ChangeCopyWithImpl(this._self, this._then);

  final Change _self;
  final $Res Function(Change) _then;

/// Create a copy of LevelSixEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? emailNumber = null,Object? increase = null,}) {
  return _then(Change(
emailNumber: null == emailNumber ? _self.emailNumber : emailNumber // ignore: cast_nullable_to_non_nullable
as int,increase: null == increase ? _self.increase : increase // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$LevelSixState {

 int get email1; int get email2; int get email3; int get email4; int get email5; int get numberOfSelected1; int get numberOfSelected2; int get numberOfSelected3; int get numberOfSelected4; int get numberOfSelected5; bool get email1Check; bool get email2Check; bool get email3Check; bool get email4Check; bool get email5Check;
/// Create a copy of LevelSixState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LevelSixStateCopyWith<LevelSixState> get copyWith => _$LevelSixStateCopyWithImpl<LevelSixState>(this as LevelSixState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LevelSixState&&(identical(other.email1, email1) || other.email1 == email1)&&(identical(other.email2, email2) || other.email2 == email2)&&(identical(other.email3, email3) || other.email3 == email3)&&(identical(other.email4, email4) || other.email4 == email4)&&(identical(other.email5, email5) || other.email5 == email5)&&(identical(other.numberOfSelected1, numberOfSelected1) || other.numberOfSelected1 == numberOfSelected1)&&(identical(other.numberOfSelected2, numberOfSelected2) || other.numberOfSelected2 == numberOfSelected2)&&(identical(other.numberOfSelected3, numberOfSelected3) || other.numberOfSelected3 == numberOfSelected3)&&(identical(other.numberOfSelected4, numberOfSelected4) || other.numberOfSelected4 == numberOfSelected4)&&(identical(other.numberOfSelected5, numberOfSelected5) || other.numberOfSelected5 == numberOfSelected5)&&(identical(other.email1Check, email1Check) || other.email1Check == email1Check)&&(identical(other.email2Check, email2Check) || other.email2Check == email2Check)&&(identical(other.email3Check, email3Check) || other.email3Check == email3Check)&&(identical(other.email4Check, email4Check) || other.email4Check == email4Check)&&(identical(other.email5Check, email5Check) || other.email5Check == email5Check));
}


@override
int get hashCode => Object.hash(runtimeType,email1,email2,email3,email4,email5,numberOfSelected1,numberOfSelected2,numberOfSelected3,numberOfSelected4,numberOfSelected5,email1Check,email2Check,email3Check,email4Check,email5Check);

@override
String toString() {
  return 'LevelSixState(email1: $email1, email2: $email2, email3: $email3, email4: $email4, email5: $email5, numberOfSelected1: $numberOfSelected1, numberOfSelected2: $numberOfSelected2, numberOfSelected3: $numberOfSelected3, numberOfSelected4: $numberOfSelected4, numberOfSelected5: $numberOfSelected5, email1Check: $email1Check, email2Check: $email2Check, email3Check: $email3Check, email4Check: $email4Check, email5Check: $email5Check)';
}


}

/// @nodoc
abstract mixin class $LevelSixStateCopyWith<$Res>  {
  factory $LevelSixStateCopyWith(LevelSixState value, $Res Function(LevelSixState) _then) = _$LevelSixStateCopyWithImpl;
@useResult
$Res call({
 int email1, int email2, int email3, int email4, int email5, int numberOfSelected1, int numberOfSelected2, int numberOfSelected3, int numberOfSelected4, int numberOfSelected5, bool email1Check, bool email2Check, bool email3Check, bool email4Check, bool email5Check
});




}
/// @nodoc
class _$LevelSixStateCopyWithImpl<$Res>
    implements $LevelSixStateCopyWith<$Res> {
  _$LevelSixStateCopyWithImpl(this._self, this._then);

  final LevelSixState _self;
  final $Res Function(LevelSixState) _then;

/// Create a copy of LevelSixState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email1 = null,Object? email2 = null,Object? email3 = null,Object? email4 = null,Object? email5 = null,Object? numberOfSelected1 = null,Object? numberOfSelected2 = null,Object? numberOfSelected3 = null,Object? numberOfSelected4 = null,Object? numberOfSelected5 = null,Object? email1Check = null,Object? email2Check = null,Object? email3Check = null,Object? email4Check = null,Object? email5Check = null,}) {
  return _then(_self.copyWith(
email1: null == email1 ? _self.email1 : email1 // ignore: cast_nullable_to_non_nullable
as int,email2: null == email2 ? _self.email2 : email2 // ignore: cast_nullable_to_non_nullable
as int,email3: null == email3 ? _self.email3 : email3 // ignore: cast_nullable_to_non_nullable
as int,email4: null == email4 ? _self.email4 : email4 // ignore: cast_nullable_to_non_nullable
as int,email5: null == email5 ? _self.email5 : email5 // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected1: null == numberOfSelected1 ? _self.numberOfSelected1 : numberOfSelected1 // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected2: null == numberOfSelected2 ? _self.numberOfSelected2 : numberOfSelected2 // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected3: null == numberOfSelected3 ? _self.numberOfSelected3 : numberOfSelected3 // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected4: null == numberOfSelected4 ? _self.numberOfSelected4 : numberOfSelected4 // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected5: null == numberOfSelected5 ? _self.numberOfSelected5 : numberOfSelected5 // ignore: cast_nullable_to_non_nullable
as int,email1Check: null == email1Check ? _self.email1Check : email1Check // ignore: cast_nullable_to_non_nullable
as bool,email2Check: null == email2Check ? _self.email2Check : email2Check // ignore: cast_nullable_to_non_nullable
as bool,email3Check: null == email3Check ? _self.email3Check : email3Check // ignore: cast_nullable_to_non_nullable
as bool,email4Check: null == email4Check ? _self.email4Check : email4Check // ignore: cast_nullable_to_non_nullable
as bool,email5Check: null == email5Check ? _self.email5Check : email5Check // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LevelSixState].
extension LevelSixStatePatterns on LevelSixState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Completed value)?  completed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Completed() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Completed value)  completed,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Completed():
return completed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Completed value)?  completed,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Completed() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int email1,  int email2,  int email3,  int email4,  int email5,  int numberOfSelected1,  int numberOfSelected2,  int numberOfSelected3,  int numberOfSelected4,  int numberOfSelected5,  bool email1Check,  bool email2Check,  bool email3Check,  bool email4Check,  bool email5Check)?  initial,TResult Function( int email1,  int email2,  int email3,  int email4,  int email5,  int numberOfSelected1,  int numberOfSelected2,  int numberOfSelected3,  int numberOfSelected4,  int numberOfSelected5,  bool email1Check,  bool email2Check,  bool email3Check,  bool email4Check,  bool email5Check)?  completed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that.email1,_that.email2,_that.email3,_that.email4,_that.email5,_that.numberOfSelected1,_that.numberOfSelected2,_that.numberOfSelected3,_that.numberOfSelected4,_that.numberOfSelected5,_that.email1Check,_that.email2Check,_that.email3Check,_that.email4Check,_that.email5Check);case Completed() when completed != null:
return completed(_that.email1,_that.email2,_that.email3,_that.email4,_that.email5,_that.numberOfSelected1,_that.numberOfSelected2,_that.numberOfSelected3,_that.numberOfSelected4,_that.numberOfSelected5,_that.email1Check,_that.email2Check,_that.email3Check,_that.email4Check,_that.email5Check);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int email1,  int email2,  int email3,  int email4,  int email5,  int numberOfSelected1,  int numberOfSelected2,  int numberOfSelected3,  int numberOfSelected4,  int numberOfSelected5,  bool email1Check,  bool email2Check,  bool email3Check,  bool email4Check,  bool email5Check)  initial,required TResult Function( int email1,  int email2,  int email3,  int email4,  int email5,  int numberOfSelected1,  int numberOfSelected2,  int numberOfSelected3,  int numberOfSelected4,  int numberOfSelected5,  bool email1Check,  bool email2Check,  bool email3Check,  bool email4Check,  bool email5Check)  completed,}) {final _that = this;
switch (_that) {
case Initial():
return initial(_that.email1,_that.email2,_that.email3,_that.email4,_that.email5,_that.numberOfSelected1,_that.numberOfSelected2,_that.numberOfSelected3,_that.numberOfSelected4,_that.numberOfSelected5,_that.email1Check,_that.email2Check,_that.email3Check,_that.email4Check,_that.email5Check);case Completed():
return completed(_that.email1,_that.email2,_that.email3,_that.email4,_that.email5,_that.numberOfSelected1,_that.numberOfSelected2,_that.numberOfSelected3,_that.numberOfSelected4,_that.numberOfSelected5,_that.email1Check,_that.email2Check,_that.email3Check,_that.email4Check,_that.email5Check);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int email1,  int email2,  int email3,  int email4,  int email5,  int numberOfSelected1,  int numberOfSelected2,  int numberOfSelected3,  int numberOfSelected4,  int numberOfSelected5,  bool email1Check,  bool email2Check,  bool email3Check,  bool email4Check,  bool email5Check)?  initial,TResult? Function( int email1,  int email2,  int email3,  int email4,  int email5,  int numberOfSelected1,  int numberOfSelected2,  int numberOfSelected3,  int numberOfSelected4,  int numberOfSelected5,  bool email1Check,  bool email2Check,  bool email3Check,  bool email4Check,  bool email5Check)?  completed,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that.email1,_that.email2,_that.email3,_that.email4,_that.email5,_that.numberOfSelected1,_that.numberOfSelected2,_that.numberOfSelected3,_that.numberOfSelected4,_that.numberOfSelected5,_that.email1Check,_that.email2Check,_that.email3Check,_that.email4Check,_that.email5Check);case Completed() when completed != null:
return completed(_that.email1,_that.email2,_that.email3,_that.email4,_that.email5,_that.numberOfSelected1,_that.numberOfSelected2,_that.numberOfSelected3,_that.numberOfSelected4,_that.numberOfSelected5,_that.email1Check,_that.email2Check,_that.email3Check,_that.email4Check,_that.email5Check);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements LevelSixState {
  const Initial({this.email1 = 3, this.email2 = 4, this.email3 = 2, this.email4 = 0, this.email5 = 0, this.numberOfSelected1 = 0, this.numberOfSelected2 = 0, this.numberOfSelected3 = 0, this.numberOfSelected4 = 0, this.numberOfSelected5 = 0, this.email1Check = false, this.email2Check = false, this.email3Check = false, this.email4Check = false, this.email5Check = false});
  

@override@JsonKey() final  int email1;
@override@JsonKey() final  int email2;
@override@JsonKey() final  int email3;
@override@JsonKey() final  int email4;
@override@JsonKey() final  int email5;
@override@JsonKey() final  int numberOfSelected1;
@override@JsonKey() final  int numberOfSelected2;
@override@JsonKey() final  int numberOfSelected3;
@override@JsonKey() final  int numberOfSelected4;
@override@JsonKey() final  int numberOfSelected5;
@override@JsonKey() final  bool email1Check;
@override@JsonKey() final  bool email2Check;
@override@JsonKey() final  bool email3Check;
@override@JsonKey() final  bool email4Check;
@override@JsonKey() final  bool email5Check;

/// Create a copy of LevelSixState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialCopyWith<Initial> get copyWith => _$InitialCopyWithImpl<Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial&&(identical(other.email1, email1) || other.email1 == email1)&&(identical(other.email2, email2) || other.email2 == email2)&&(identical(other.email3, email3) || other.email3 == email3)&&(identical(other.email4, email4) || other.email4 == email4)&&(identical(other.email5, email5) || other.email5 == email5)&&(identical(other.numberOfSelected1, numberOfSelected1) || other.numberOfSelected1 == numberOfSelected1)&&(identical(other.numberOfSelected2, numberOfSelected2) || other.numberOfSelected2 == numberOfSelected2)&&(identical(other.numberOfSelected3, numberOfSelected3) || other.numberOfSelected3 == numberOfSelected3)&&(identical(other.numberOfSelected4, numberOfSelected4) || other.numberOfSelected4 == numberOfSelected4)&&(identical(other.numberOfSelected5, numberOfSelected5) || other.numberOfSelected5 == numberOfSelected5)&&(identical(other.email1Check, email1Check) || other.email1Check == email1Check)&&(identical(other.email2Check, email2Check) || other.email2Check == email2Check)&&(identical(other.email3Check, email3Check) || other.email3Check == email3Check)&&(identical(other.email4Check, email4Check) || other.email4Check == email4Check)&&(identical(other.email5Check, email5Check) || other.email5Check == email5Check));
}


@override
int get hashCode => Object.hash(runtimeType,email1,email2,email3,email4,email5,numberOfSelected1,numberOfSelected2,numberOfSelected3,numberOfSelected4,numberOfSelected5,email1Check,email2Check,email3Check,email4Check,email5Check);

@override
String toString() {
  return 'LevelSixState.initial(email1: $email1, email2: $email2, email3: $email3, email4: $email4, email5: $email5, numberOfSelected1: $numberOfSelected1, numberOfSelected2: $numberOfSelected2, numberOfSelected3: $numberOfSelected3, numberOfSelected4: $numberOfSelected4, numberOfSelected5: $numberOfSelected5, email1Check: $email1Check, email2Check: $email2Check, email3Check: $email3Check, email4Check: $email4Check, email5Check: $email5Check)';
}


}

/// @nodoc
abstract mixin class $InitialCopyWith<$Res> implements $LevelSixStateCopyWith<$Res> {
  factory $InitialCopyWith(Initial value, $Res Function(Initial) _then) = _$InitialCopyWithImpl;
@override @useResult
$Res call({
 int email1, int email2, int email3, int email4, int email5, int numberOfSelected1, int numberOfSelected2, int numberOfSelected3, int numberOfSelected4, int numberOfSelected5, bool email1Check, bool email2Check, bool email3Check, bool email4Check, bool email5Check
});




}
/// @nodoc
class _$InitialCopyWithImpl<$Res>
    implements $InitialCopyWith<$Res> {
  _$InitialCopyWithImpl(this._self, this._then);

  final Initial _self;
  final $Res Function(Initial) _then;

/// Create a copy of LevelSixState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email1 = null,Object? email2 = null,Object? email3 = null,Object? email4 = null,Object? email5 = null,Object? numberOfSelected1 = null,Object? numberOfSelected2 = null,Object? numberOfSelected3 = null,Object? numberOfSelected4 = null,Object? numberOfSelected5 = null,Object? email1Check = null,Object? email2Check = null,Object? email3Check = null,Object? email4Check = null,Object? email5Check = null,}) {
  return _then(Initial(
email1: null == email1 ? _self.email1 : email1 // ignore: cast_nullable_to_non_nullable
as int,email2: null == email2 ? _self.email2 : email2 // ignore: cast_nullable_to_non_nullable
as int,email3: null == email3 ? _self.email3 : email3 // ignore: cast_nullable_to_non_nullable
as int,email4: null == email4 ? _self.email4 : email4 // ignore: cast_nullable_to_non_nullable
as int,email5: null == email5 ? _self.email5 : email5 // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected1: null == numberOfSelected1 ? _self.numberOfSelected1 : numberOfSelected1 // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected2: null == numberOfSelected2 ? _self.numberOfSelected2 : numberOfSelected2 // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected3: null == numberOfSelected3 ? _self.numberOfSelected3 : numberOfSelected3 // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected4: null == numberOfSelected4 ? _self.numberOfSelected4 : numberOfSelected4 // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected5: null == numberOfSelected5 ? _self.numberOfSelected5 : numberOfSelected5 // ignore: cast_nullable_to_non_nullable
as int,email1Check: null == email1Check ? _self.email1Check : email1Check // ignore: cast_nullable_to_non_nullable
as bool,email2Check: null == email2Check ? _self.email2Check : email2Check // ignore: cast_nullable_to_non_nullable
as bool,email3Check: null == email3Check ? _self.email3Check : email3Check // ignore: cast_nullable_to_non_nullable
as bool,email4Check: null == email4Check ? _self.email4Check : email4Check // ignore: cast_nullable_to_non_nullable
as bool,email5Check: null == email5Check ? _self.email5Check : email5Check // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class Completed implements LevelSixState {
  const Completed({this.email1 = 3, this.email2 = 4, this.email3 = 2, this.email4 = 0, this.email5 = 0, this.numberOfSelected1 = 0, this.numberOfSelected2 = 0, this.numberOfSelected3 = 0, this.numberOfSelected4 = 0, this.numberOfSelected5 = 0, this.email1Check = false, this.email2Check = false, this.email3Check = false, this.email4Check = false, this.email5Check = false});
  

@override@JsonKey() final  int email1;
@override@JsonKey() final  int email2;
@override@JsonKey() final  int email3;
@override@JsonKey() final  int email4;
@override@JsonKey() final  int email5;
@override@JsonKey() final  int numberOfSelected1;
@override@JsonKey() final  int numberOfSelected2;
@override@JsonKey() final  int numberOfSelected3;
@override@JsonKey() final  int numberOfSelected4;
@override@JsonKey() final  int numberOfSelected5;
@override@JsonKey() final  bool email1Check;
@override@JsonKey() final  bool email2Check;
@override@JsonKey() final  bool email3Check;
@override@JsonKey() final  bool email4Check;
@override@JsonKey() final  bool email5Check;

/// Create a copy of LevelSixState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompletedCopyWith<Completed> get copyWith => _$CompletedCopyWithImpl<Completed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Completed&&(identical(other.email1, email1) || other.email1 == email1)&&(identical(other.email2, email2) || other.email2 == email2)&&(identical(other.email3, email3) || other.email3 == email3)&&(identical(other.email4, email4) || other.email4 == email4)&&(identical(other.email5, email5) || other.email5 == email5)&&(identical(other.numberOfSelected1, numberOfSelected1) || other.numberOfSelected1 == numberOfSelected1)&&(identical(other.numberOfSelected2, numberOfSelected2) || other.numberOfSelected2 == numberOfSelected2)&&(identical(other.numberOfSelected3, numberOfSelected3) || other.numberOfSelected3 == numberOfSelected3)&&(identical(other.numberOfSelected4, numberOfSelected4) || other.numberOfSelected4 == numberOfSelected4)&&(identical(other.numberOfSelected5, numberOfSelected5) || other.numberOfSelected5 == numberOfSelected5)&&(identical(other.email1Check, email1Check) || other.email1Check == email1Check)&&(identical(other.email2Check, email2Check) || other.email2Check == email2Check)&&(identical(other.email3Check, email3Check) || other.email3Check == email3Check)&&(identical(other.email4Check, email4Check) || other.email4Check == email4Check)&&(identical(other.email5Check, email5Check) || other.email5Check == email5Check));
}


@override
int get hashCode => Object.hash(runtimeType,email1,email2,email3,email4,email5,numberOfSelected1,numberOfSelected2,numberOfSelected3,numberOfSelected4,numberOfSelected5,email1Check,email2Check,email3Check,email4Check,email5Check);

@override
String toString() {
  return 'LevelSixState.completed(email1: $email1, email2: $email2, email3: $email3, email4: $email4, email5: $email5, numberOfSelected1: $numberOfSelected1, numberOfSelected2: $numberOfSelected2, numberOfSelected3: $numberOfSelected3, numberOfSelected4: $numberOfSelected4, numberOfSelected5: $numberOfSelected5, email1Check: $email1Check, email2Check: $email2Check, email3Check: $email3Check, email4Check: $email4Check, email5Check: $email5Check)';
}


}

/// @nodoc
abstract mixin class $CompletedCopyWith<$Res> implements $LevelSixStateCopyWith<$Res> {
  factory $CompletedCopyWith(Completed value, $Res Function(Completed) _then) = _$CompletedCopyWithImpl;
@override @useResult
$Res call({
 int email1, int email2, int email3, int email4, int email5, int numberOfSelected1, int numberOfSelected2, int numberOfSelected3, int numberOfSelected4, int numberOfSelected5, bool email1Check, bool email2Check, bool email3Check, bool email4Check, bool email5Check
});




}
/// @nodoc
class _$CompletedCopyWithImpl<$Res>
    implements $CompletedCopyWith<$Res> {
  _$CompletedCopyWithImpl(this._self, this._then);

  final Completed _self;
  final $Res Function(Completed) _then;

/// Create a copy of LevelSixState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email1 = null,Object? email2 = null,Object? email3 = null,Object? email4 = null,Object? email5 = null,Object? numberOfSelected1 = null,Object? numberOfSelected2 = null,Object? numberOfSelected3 = null,Object? numberOfSelected4 = null,Object? numberOfSelected5 = null,Object? email1Check = null,Object? email2Check = null,Object? email3Check = null,Object? email4Check = null,Object? email5Check = null,}) {
  return _then(Completed(
email1: null == email1 ? _self.email1 : email1 // ignore: cast_nullable_to_non_nullable
as int,email2: null == email2 ? _self.email2 : email2 // ignore: cast_nullable_to_non_nullable
as int,email3: null == email3 ? _self.email3 : email3 // ignore: cast_nullable_to_non_nullable
as int,email4: null == email4 ? _self.email4 : email4 // ignore: cast_nullable_to_non_nullable
as int,email5: null == email5 ? _self.email5 : email5 // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected1: null == numberOfSelected1 ? _self.numberOfSelected1 : numberOfSelected1 // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected2: null == numberOfSelected2 ? _self.numberOfSelected2 : numberOfSelected2 // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected3: null == numberOfSelected3 ? _self.numberOfSelected3 : numberOfSelected3 // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected4: null == numberOfSelected4 ? _self.numberOfSelected4 : numberOfSelected4 // ignore: cast_nullable_to_non_nullable
as int,numberOfSelected5: null == numberOfSelected5 ? _self.numberOfSelected5 : numberOfSelected5 // ignore: cast_nullable_to_non_nullable
as int,email1Check: null == email1Check ? _self.email1Check : email1Check // ignore: cast_nullable_to_non_nullable
as bool,email2Check: null == email2Check ? _self.email2Check : email2Check // ignore: cast_nullable_to_non_nullable
as bool,email3Check: null == email3Check ? _self.email3Check : email3Check // ignore: cast_nullable_to_non_nullable
as bool,email4Check: null == email4Check ? _self.email4Check : email4Check // ignore: cast_nullable_to_non_nullable
as bool,email5Check: null == email5Check ? _self.email5Check : email5Check // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
