// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:dart_eval/dart_eval_bridge.dart';
import 'package:dart_eval/stdlib/core.dart';

/// Wrapper for [Future]
class $Future<T> implements Future<T>, $Instance {
  /// Configure [$Future] for runtime in a [Runtime]
  static void configureForRuntime(Runtime runtime) {
    runtime.registerBridgeFunc(
        'dart:core', 'Future.delayed', const _$Future_delayed().call);
  }

  static const $declaration = BridgeClassDef(
      BridgeClassType(BridgeTypeRef(CoreTypes.future), isAbstract: true),
      constructors: {
        'delayed': BridgeConstructorDef(BridgeFunctionDef(
            returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.future)),
            params: [
              BridgeParameter(
                  'duration', BridgeTypeAnnotation($Duration.$type), false)
            ],
            namedParams: []))
      },
      methods: {
        'then': BridgeMethodDef(BridgeFunctionDef(
            returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.future)),
            params: [
              BridgeParameter(
                  'onValue',
                  BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.function)),
                  false)
            ],
            namedParams: []))
      },
      getters: {},
      setters: {},
      fields: {},
      wrap: true);

  $Future.wrap(this.$value) : _superclass = $Object($value);

  @override
  final Future<T> $value;

  @override
  Future get $reified =>
      $value.then((value) => value is $Value ? value.$value : value);

  final $Instance _superclass;

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case 'then':
        return __then;
      default:
        return _superclass.$getProperty(runtime, identifier);
    }
  }

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {}

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType(CoreTypes.future);

  @override
  Stream<T> asStream() => $value.asStream();

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) =>
      $value.catchError(onError, test: test);

  static const $Function __then = $Function(_then);

  static $Value? _then(Runtime runtime, $Value? target, List<$Value?> args) {
    final $t = target as $Future;
    final $then = args[0] as EvalFunction;
    final $result = ($t.$value)
        .then((value) => $then.call(runtime, target, [runtime.wrap(value)]));
    return $Future.wrap($result);
  }

  @override
  Future<R> then<R>(FutureOr<R> Function(T value) onValue,
          {Function? onError}) =>
      $value.then(onValue, onError: onError);

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) =>
      $value.timeout(timeLimit, onTimeout: onTimeout);

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) =>
      $value.whenComplete(action);
}

class _$Future_delayed implements EvalCallable {
  const _$Future_delayed();

  @override
  $Value? call(Runtime runtime, $Value? target, List<$Value?> args) {
    return $Future.wrap(Future.delayed(args[0]!.$value));
  }
}
