// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'timer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Timer {
  @HiveField(0)
  String get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimerCopyWith<Timer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerCopyWith<$Res> {
  factory $TimerCopyWith(Timer value, $Res Function(Timer) then) =
      _$TimerCopyWithImpl<$Res>;
  $Res call({@HiveField(0) String name});
}

/// @nodoc
class _$TimerCopyWithImpl<$Res> implements $TimerCopyWith<$Res> {
  _$TimerCopyWithImpl(this._value, this._then);

  final Timer _value;
  // ignore: unused_field
  final $Res Function(Timer) _then;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_TimerCopyWith<$Res> implements $TimerCopyWith<$Res> {
  factory _$$_TimerCopyWith(_$_Timer value, $Res Function(_$_Timer) then) =
      __$$_TimerCopyWithImpl<$Res>;
  @override
  $Res call({@HiveField(0) String name});
}

/// @nodoc
class __$$_TimerCopyWithImpl<$Res> extends _$TimerCopyWithImpl<$Res>
    implements _$$_TimerCopyWith<$Res> {
  __$$_TimerCopyWithImpl(_$_Timer _value, $Res Function(_$_Timer) _then)
      : super(_value, (v) => _then(v as _$_Timer));

  @override
  _$_Timer get _value => super._value as _$_Timer;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_$_Timer(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 0, adapterName: 'TimerAdapter')
class _$_Timer implements _Timer {
  const _$_Timer({@HiveField(0) this.name = 'timer1'});

  @override
  @JsonKey()
  @HiveField(0)
  final String name;

  @override
  String toString() {
    return 'Timer(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Timer &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_TimerCopyWith<_$_Timer> get copyWith =>
      __$$_TimerCopyWithImpl<_$_Timer>(this, _$identity);
}

abstract class _Timer implements Timer {
  const factory _Timer({@HiveField(0) final String name}) = _$_Timer;

  @override
  @HiveField(0)
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_TimerCopyWith<_$_Timer> get copyWith =>
      throw _privateConstructorUsedError;
}
