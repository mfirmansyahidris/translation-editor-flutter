// ignore_for_file: camel_case_types

import 'package:dart_eval/dart_eval_bridge.dart';
import 'package:dart_eval/src/eval/shared/stdlib/core/base.dart';
import 'package:dart_eval/src/eval/shared/stdlib/core/num.dart';
import 'package:dart_eval/src/eval/shared/stdlib/core/object.dart';

/// dart_eval bimodal wrapper for [Duration]
class $Duration implements Duration, $Instance {
  static void configureForRuntime(Runtime runtime) {
    runtime.registerBridgeFunc(
        'dart:core', 'Duration.', const _$Duration_new().call);
    runtime.registerBridgeFunc(
        'dart:core', 'Duration.zero*g', const _$Duration_zero().call);
    runtime.registerBridgeFunc(
        'dart:core',
        'Duration.microsecondsPerMillisecond*g',
        (runtime, target, args) => $int(Duration.microsecondsPerMillisecond));
    runtime.registerBridgeFunc('dart:core', 'Duration.millisecondsPerSecond*g',
        (runtime, target, args) => $int(Duration.millisecondsPerSecond));
    runtime.registerBridgeFunc('dart:core', 'Duration.secondsPerMinute*g',
        (runtime, target, args) => $int(Duration.secondsPerMinute));
    runtime.registerBridgeFunc('dart:core', 'Duration.minutesPerHour*g',
        (runtime, target, args) => $int(Duration.minutesPerHour));
    runtime.registerBridgeFunc('dart:core', 'Duration.hoursPerDay*g',
        (runtime, target, args) => $int(Duration.hoursPerDay));
  }

  /// Compile-time type definition for [$Duration]
  static const $type = BridgeTypeRef(BridgeTypeSpec('dart:core', 'Duration'));

  /// Compile-time class declaration for [$Duration]
  static const $declaration = BridgeClassDef(BridgeClassType($type),
      constructors: {
        '': BridgeConstructorDef(BridgeFunctionDef(
            returns: BridgeTypeAnnotation($type),
            params: [],
            namedParams: [
              BridgeParameter(
                  'days',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int),
                      nullable: true),
                  true),
              BridgeParameter(
                  'hours',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int),
                      nullable: true),
                  true),
              BridgeParameter(
                  'minutes',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int),
                      nullable: true),
                  true),
              BridgeParameter(
                  'seconds',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int),
                      nullable: true),
                  true),
              BridgeParameter(
                  'milliseconds',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int),
                      nullable: true),
                  true),
              BridgeParameter(
                  'microseconds',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int),
                      nullable: true),
                  true),
            ]))
      },
      methods: {
        '*': BridgeMethodDef(
            BridgeFunctionDef(returns: BridgeTypeAnnotation($type), params: [
          BridgeParameter('factor',
              BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.num)), false)
        ], namedParams: [])),
        '>': BridgeMethodDef(
          BridgeFunctionDef(
              returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.bool)),
              params: [
                BridgeParameter('other', BridgeTypeAnnotation($type), false)
              ]),
        ),
        '>=': BridgeMethodDef(
          BridgeFunctionDef(
              returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.bool)),
              params: [
                BridgeParameter('other', BridgeTypeAnnotation($type), false)
              ]),
        ),
        '<': BridgeMethodDef(
          BridgeFunctionDef(
              returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.bool)),
              params: [
                BridgeParameter('other', BridgeTypeAnnotation($type), false)
              ]),
        ),
        '<=': BridgeMethodDef(
          BridgeFunctionDef(
              returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.bool)),
              params: [
                BridgeParameter('other', BridgeTypeAnnotation($type), false)
              ]),
        ),
      },
      getters: {
        'zero': BridgeMethodDef(
            BridgeFunctionDef(returns: BridgeTypeAnnotation($type)),
            isStatic: true),
        'microsecondsPerMillisecond': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int))),
            isStatic: true),
        'millisecondsPerSecond': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int))),
            isStatic: true),
        'secondsPerMinute': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int))),
            isStatic: true),
        'minutesPerHour': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int))),
            isStatic: true),
        'hoursPerDay': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int))),
            isStatic: true),
        'inDays': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int))),
            isStatic: false),
        'inHours': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int))),
            isStatic: false),
        'inMinutes': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int))),
            isStatic: false),
        'inSeconds': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int))),
            isStatic: false),
        'inMilliseconds': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int))),
            isStatic: false),
        'inMicroseconds': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int))),
            isStatic: false),
        'compareTo': BridgeMethodDef(
            BridgeFunctionDef(params: [
              BridgeParameter(
                  'other',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.duration)),
                  false)
            ], returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int))),
            isStatic: false),
        'isNegative': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.bool))),
            isStatic: false),
        'abs': BridgeMethodDef(
            BridgeFunctionDef(
                params: [],
                returns:
                    BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.duration))),
            isStatic: false),
      },
      setters: {},
      fields: {},
      wrap: true);

  late final $Instance _superclass = $Object($value);

  /// Wrap a [Duration] in a [$Duration]
  $Duration.wrap(this.$value);

  @override
  final Duration $value;

  @override
  Duration get $reified => $value;

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case 'inDays':
        return $int($value.inDays);
      case 'inHours':
        return $int($value.inHours);
      case 'inMinutes':
        return $int($value.inMinutes);
      case 'inSeconds':
        return $int($value.inSeconds);
      case 'inMilliseconds':
        return $int($value.inMilliseconds);
      case 'inMicroseconds':
        return $int($value.inMicroseconds);
      case 'compareTo':
        return $Function(_compareTo);
      case 'isNegative':
        return $bool($value.isNegative);
      case 'abs':
        return $Function(_abs);
      case '<':
        return $Function(_lessThan);
      case '<=':
        return $Function(_lessThanOrEqual);
      case '>':
        return $Function(_greaterThan);
      case '>=':
        return $Function(_greaterThanOrEqual);
    }
    return _superclass.$getProperty(runtime, identifier);
  }

  static $Value? _compareTo(
      final Runtime runtime, final $Value? target, final List<$Value?> args) {
    var a = target!.$value as Duration;
    var other = args[0]!.$value as Duration;
    return $int(a.compareTo(other));
  }

  static $Value? _abs(
      final Runtime runtime, final $Value? target, final List<$Value?> args) {
    var a = target!.$value as Duration;
    return $Duration.wrap(a.abs());
  }

  static $Value? _lessThan(
      final Runtime runtime, final $Value? target, final List<$Value?> args) {
    var a = target!.$value as Duration;
    var other = args[0]!.$value as Duration;
    return $bool(a < other);
  }

  static $Value? _lessThanOrEqual(
      final Runtime runtime, final $Value? target, final List<$Value?> args) {
    var a = target!.$value as Duration;
    var other = args[0]!.$value as Duration;
    return $bool(a <= other);
  }

  static $Value? _greaterThan(
      final Runtime runtime, final $Value? target, final List<$Value?> args) {
    var a = target!.$value as Duration;
    var other = args[0]!.$value as Duration;
    return $bool(a > other);
  }

  static $Value? _greaterThanOrEqual(
      final Runtime runtime, final $Value? target, final List<$Value?> args) {
    var a = target!.$value as Duration;
    var other = args[0]!.$value as Duration;
    return $bool(a >= other);
  }

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    return _superclass.$setProperty(runtime, identifier, value);
  }

  @override
  int $getRuntimeType(Runtime runtime) =>
      runtime.lookupType(CoreTypes.duration);

  @override
  Duration operator *(num factor) => $value * factor;

  @override
  Duration operator +(Duration other) => $value + other;

  @override
  Duration operator -() => -$value;

  @override
  Duration operator -(Duration other) => $value - other;

  @override
  bool operator <(Duration other) => $value < other;

  @override
  bool operator <=(Duration other) => $value <= other;

  @override
  bool operator >(Duration other) => $value > other;

  @override
  bool operator >=(Duration other) => $value >= other;

  @override
  Duration abs() => $value.abs();

  @override
  int compareTo(Duration other) => $value.compareTo(other);

  @override
  int get inDays => $value.inDays;

  @override
  int get inHours => $value.inHours;

  @override
  int get inMicroseconds => $value.inMicroseconds;

  @override
  int get inMilliseconds => $value.inMilliseconds;

  @override
  int get inMinutes => $value.inMinutes;

  @override
  int get inSeconds => $value.inSeconds;

  @override
  bool get isNegative => $value.isNegative;

  @override
  Duration operator ~/(int quotient) => $value ~/ quotient;
}

class _$Duration_new implements EvalCallable {
  const _$Duration_new();

  @override
  $Value? call(Runtime runtime, $Value? target, List<$Value?> args) {
    return $Duration.wrap(Duration(
        days: args[0]?.$value ?? 0,
        hours: args[1]?.$value ?? 0,
        minutes: args[2]?.$value ?? 0,
        seconds: args[3]?.$value ?? 0,
        milliseconds: args[4]?.$value ?? 0,
        microseconds: args[5]?.$value ?? 0));
  }
}

class _$Duration_zero implements EvalCallable {
  const _$Duration_zero();

  @override
  $Value? call(Runtime runtime, $Value? target, List<$Value?> args) {
    return $Duration.wrap(Duration.zero);
  }
}
