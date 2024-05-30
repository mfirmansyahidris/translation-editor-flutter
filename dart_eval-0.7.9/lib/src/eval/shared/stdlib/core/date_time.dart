// ignore_for_file: body_might_complete_normally_nullable

import 'package:dart_eval/dart_eval_bridge.dart';
import 'package:dart_eval/stdlib/core.dart';

/// dart_eval [$Instance] wrapper of a [DateTime]
class $DateTime implements DateTime, $Instance {
  /// Configure the [$DateTime] class for runtime with a [Runtime]
  static void configureForRuntime(Runtime runtime) {
    runtime.registerBridgeFunc('dart:core', 'DateTime.now',
        (runtime, target, args) => $DateTime.wrap(DateTime.now()));
    runtime.registerBridgeFunc('dart:core', 'DateTime.', $new);
    runtime.registerBridgeFunc('dart:core', 'DateTime.parse', $parse);
    runtime.registerBridgeFunc('dart:core', 'DateTime.tryParse', $tryParse);
  }

  static const _dtDurationGetter = BridgeMethodDef(BridgeFunctionDef(
      returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.duration)),
      params: [],
      namedParams: []));

  static const _dtBoolGetter = BridgeMethodDef(BridgeFunctionDef(
      returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.bool)),
      params: [],
      namedParams: []));

  static const _dtIntGetter = BridgeMethodDef(BridgeFunctionDef(
      returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int)),
      params: [],
      namedParams: []));

  /// Compile-time class declaration for [$DateTime]
  static const $declaration = BridgeClassDef(
      BridgeClassType(BridgeTypeRef(CoreTypes.dateTime)),
      constructors: {
        '': BridgeConstructorDef(BridgeFunctionDef(
            returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.dateTime)),
            params: [
              BridgeParameter('year',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int)), false),
              BridgeParameter('month',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int)), true),
              BridgeParameter('day',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int)), true),
              BridgeParameter('hour',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int)), true),
              BridgeParameter('minute',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int)), true),
              BridgeParameter('second',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int)), true),
              BridgeParameter('millisecond',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int)), true),
              BridgeParameter('microsecond',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int)), true),
            ],
            namedParams: [])),
        'now': BridgeConstructorDef(BridgeFunctionDef(
            returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.dateTime)),
            params: [],
            namedParams: [])),
      },
      methods: {
        'parse': BridgeMethodDef(
            BridgeFunctionDef(
                returns:
                    BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.dateTime)),
                params: [
                  BridgeParameter(
                      'formattedString',
                      BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.string)),
                      false)
                ],
                namedParams: []),
            isStatic: true),
        'tryParse': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.dateTime),
                    nullable: true),
                params: [
                  BridgeParameter(
                      'formattedString',
                      BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.string)),
                      false)
                ],
                namedParams: []),
            isStatic: true),
        'isAfter': BridgeMethodDef(BridgeFunctionDef(
            returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.bool)),
            params: [
              BridgeParameter(
                  'other',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.dateTime)),
                  false),
            ])),
        'isBefore': BridgeMethodDef(BridgeFunctionDef(
            returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.bool)),
            params: [
              BridgeParameter(
                  'other',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.dateTime)),
                  false),
            ])),
        'isAtSameMomentAs': BridgeMethodDef(BridgeFunctionDef(
            returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.bool)),
            params: [
              BridgeParameter(
                  'other',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.dateTime)),
                  false),
            ])),
        'compareTo': BridgeMethodDef(BridgeFunctionDef(
            returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int)),
            params: [
              BridgeParameter(
                  'other',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.dateTime)),
                  false),
            ])),
        'toLocal': BridgeMethodDef(BridgeFunctionDef(
            returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.dateTime)),
            params: [])),
        'toUtc': BridgeMethodDef(BridgeFunctionDef(
            returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.dateTime)),
            params: [])),
        'toIso8601String': BridgeMethodDef(BridgeFunctionDef(
            returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.string)),
            params: [])),
        'add': BridgeMethodDef(BridgeFunctionDef(
            returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.dateTime)),
            params: [
              BridgeParameter(
                  'duration',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.duration)),
                  false)
            ])),
        'subtract': BridgeMethodDef(BridgeFunctionDef(
            returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.dateTime)),
            params: [
              BridgeParameter(
                  'duration',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.duration)),
                  false)
            ])),
        'difference': BridgeMethodDef(BridgeFunctionDef(
            returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.duration)),
            params: [
              BridgeParameter(
                  'other',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.dateTime)),
                  false)
            ])),
      },
      getters: {
        'day': _dtIntGetter,
        'hour': _dtIntGetter,
        'minute': _dtIntGetter,
        'second': _dtIntGetter,
        'millisecondsSinceEpoch': _dtIntGetter,
        'month': _dtIntGetter,
        'year': _dtIntGetter,
        'isUtc': _dtBoolGetter,
        'millisecond': _dtIntGetter,
        'microsecond': _dtIntGetter,
        'microsecondsSinceEpoch': _dtIntGetter,
        'weekday': _dtIntGetter,
        'timeZoneOffset': _dtDurationGetter,
      },
      setters: {},
      fields: {},
      wrap: true);

  static $DateTime $new(Runtime runtime, $Value? target, List<$Value?> args) {
    final year = args[0]!.$value as int;
    final month = args[1]?.$value as int?;
    final day = args[2]?.$value as int?;
    final hour = args[3]?.$value as int?;
    final minute = args[4]?.$value as int?;
    final second = args[5]?.$value as int?;
    final millisecond = args[6]?.$value as int?;
    final microsecond = args[7]?.$value as int?;
    return $DateTime.wrap(DateTime(year, month ?? 1, day ?? 1, hour ?? 0,
        minute ?? 0, second ?? 0, millisecond ?? 0, microsecond ?? 0));
  }

  /// Wrap a [DateTime] in a [$DateTime]
  $DateTime.wrap(this.$value) : _superclass = $Object($value);

  @override
  final DateTime $value;

  @override
  DateTime get $reified => $value;

  final $Instance _superclass;

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case 'day':
        return $int($value.day);
      case 'hour':
        return $int($value.hour);
      case 'minute':
        return $int($value.minute);
      case 'second':
        return $int($value.second);
      case 'millisecondsSinceEpoch':
        return $int($value.millisecondsSinceEpoch);
      //
      case 'isUtc':
        return $bool($value.isUtc);
      case 'year':
        return $int($value.year);
      case 'month':
        return $int($value.month);
      case 'millisecond':
        return $int($value.millisecond);
      case 'microsecond':
        return $int($value.microsecond);
      case 'microsecondsSinceEpoch':
        return $int($value.microsecondsSinceEpoch);
      case 'weekday':
        return $int($value.weekday);
      case 'isAfter':
        return $Function(_isAfter);
      case 'isBefore':
        return $Function(_isBefore);
      case 'isAtSameMomentAs':
        return $Function(_isAtSameMomentAs);
      case 'compareTo':
        return $Function(_compareTo);
      case 'toLocal':
        return $Function(_toLocal);
      case 'toUtc':
        return $Function(_toUtc);
      case 'toIso8601String':
        return $Function(_toIso8601String);
      case 'add':
        return $Function(_add);
      case 'subtract':
        return $Function(_subtract);
      case 'difference':
        return $Function(_difference);
      case 'timeZoneOffset':
        return $Duration.wrap($value.timeZoneOffset);
      default:
        return _superclass.$getProperty(runtime, identifier);
    }
  }

  static $Value? _difference(
      final Runtime runtime, final $Value? target, final List<$Value?> args) {
    var a = target!.$value as DateTime;
    var other = args[0]!.$value as DateTime;
    return $Duration.wrap(a.difference(other));
  }

  static $Value? _subtract(
      final Runtime runtime, final $Value? target, final List<$Value?> args) {
    var a = target!.$value as DateTime;
    var duration = args[0]!.$value as Duration;
    return $DateTime.wrap(a.subtract(duration));
  }

  static $Value? _add(
      final Runtime runtime, final $Value? target, final List<$Value?> args) {
    var a = target!.$value as DateTime;
    var duration = args[0]!.$value as Duration;
    return $DateTime.wrap(a.add(duration));
  }

  static $Value? _toIso8601String(
      final Runtime runtime, final $Value? target, final List<$Value?> args) {
    var a = target!.$value as DateTime;
    return $String(a.toIso8601String());
  }

  static $Value? _toUtc(
      final Runtime runtime, final $Value? target, final List<$Value?> args) {
    var a = target!.$value as DateTime;
    return $DateTime.wrap(a.toUtc());
  }

  static $Value? _toLocal(
      final Runtime runtime, final $Value? target, final List<$Value?> args) {
    var a = target!.$value as DateTime;
    return $DateTime.wrap(a.toLocal());
  }

  static $Value? _isAfter(
      final Runtime runtime, final $Value? target, final List<$Value?> args) {
    var a = target!.$value as DateTime;
    var other = args[0]!.$value as DateTime;
    return $bool(a.isAfter(other));
  }

  static $Value? _isBefore(
      final Runtime runtime, final $Value? target, final List<$Value?> args) {
    var a = target!.$value as DateTime;
    var other = args[0]!.$value as DateTime;
    return $bool(a.isBefore(other));
  }

  static $Value? _isAtSameMomentAs(
      final Runtime runtime, final $Value? target, final List<$Value?> args) {
    var a = target!.$value as DateTime;
    var other = args[0]!.$value as DateTime;
    return $bool(a.isAtSameMomentAs(other));
  }

  static $Value? _compareTo(
      final Runtime runtime, final $Value? target, final List<$Value?> args) {
    var a = target!.$value as DateTime;
    var other = args[0]!.$value as DateTime;
    return $int(a.compareTo(other));
  }

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    return _superclass.$setProperty(runtime, identifier, value);
  }

  @override
  int $getRuntimeType(Runtime runtime) =>
      runtime.lookupType(CoreTypes.dateTime);

  @override
  DateTime add(Duration duration) => $value.add(duration);

  @override
  int compareTo(DateTime other) => $value.compareTo(other);

  @override
  int get day => $value.day;

  @override
  Duration difference(DateTime other) => $value.difference(other);

  @override
  int get hour => $value.hour;

  @override
  bool isAfter(DateTime other) => $value.isAfter(other);

  @override
  bool isAtSameMomentAs(DateTime other) => $value.isAtSameMomentAs(other);

  @override
  bool isBefore(DateTime other) => $value.isBefore(other);

  @override
  bool get isUtc => $value.isUtc;

  @override
  int get microsecond => $value.microsecond;

  @override
  int get microsecondsSinceEpoch => $value.microsecondsSinceEpoch;

  @override
  int get millisecond => $value.millisecond;

  @override
  int get millisecondsSinceEpoch => $value.millisecondsSinceEpoch;

  @override
  int get minute => $value.minute;

  @override
  int get month => $value.month;

  @override
  int get second => $value.second;

  @override
  DateTime subtract(Duration duration) => $value.subtract(duration);

  @override
  String get timeZoneName => $value.timeZoneName;

  @override
  Duration get timeZoneOffset => $value.timeZoneOffset;

  @override
  String toIso8601String() => $value.toIso8601String();

  @override
  DateTime toLocal() => $value.toLocal();

  @override
  DateTime toUtc() => $value.toUtc();

  @override
  int get weekday => $value.weekday;

  @override
  int get year => $value.year;

  @override
  int get hashCode => $value.hashCode;

  @override
  bool operator ==(Object other) => $value == other;

  static $Value? $parse(Runtime runtime, $Value? target, List<$Value?> args) {
    final formattedString = args[0]!.$value as String;
    try {
      return $DateTime.wrap(DateTime.parse(formattedString));
    } on FormatException catch (e) {
      runtime.$throw($FormatException.wrap(e));
    }
  }

  static $Value? $tryParse(
      Runtime runtime, $Value? target, List<$Value?> args) {
    final formattedString = args[0]!.$value as String;
    final result = DateTime.tryParse(formattedString);
    return result == null ? $null() : $DateTime.wrap(result);
  }
}
