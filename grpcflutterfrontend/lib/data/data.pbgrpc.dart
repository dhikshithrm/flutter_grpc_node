///
//  Generated code. Do not modify.
//  source: lib/data.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'data.pb.dart' as $0;
export 'data.pb.dart';

class TodoClient extends $grpc.Client {
  static final _$createTodo = $grpc.ClientMethod<$0.TodoItem, $0.TodoItem>(
      '/todoPackage.Todo/createTodo',
      ($0.TodoItem value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TodoItem.fromBuffer(value));
  static final _$readTodo = $grpc.ClientMethod<$0.voidnoparam, $0.TodoItems>(
      '/todoPackage.Todo/readTodo',
      ($0.voidnoparam value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TodoItems.fromBuffer(value));
  static final _$readTodosSTream =
      $grpc.ClientMethod<$0.voidnoparam, $0.TodoItem>(
          '/todoPackage.Todo/readTodosSTream',
          ($0.voidnoparam value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.TodoItem.fromBuffer(value));

  TodoClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.TodoItem> createTodo($0.TodoItem request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTodo, request, options: options);
  }

  $grpc.ResponseFuture<$0.TodoItems> readTodo($0.voidnoparam request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$readTodo, request, options: options);
  }

  $grpc.ResponseStream<$0.TodoItem> readTodosSTream($0.voidnoparam request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$readTodosSTream, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class TodoServiceBase extends $grpc.Service {
  $core.String get $name => 'todoPackage.Todo';

  TodoServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.TodoItem, $0.TodoItem>(
        'createTodo',
        createTodo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TodoItem.fromBuffer(value),
        ($0.TodoItem value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.voidnoparam, $0.TodoItems>(
        'readTodo',
        readTodo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.voidnoparam.fromBuffer(value),
        ($0.TodoItems value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.voidnoparam, $0.TodoItem>(
        'readTodosSTream',
        readTodosSTream_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.voidnoparam.fromBuffer(value),
        ($0.TodoItem value) => value.writeToBuffer()));
  }

  $async.Future<$0.TodoItem> createTodo_Pre(
      $grpc.ServiceCall call, $async.Future<$0.TodoItem> request) async {
    return createTodo(call, await request);
  }

  $async.Future<$0.TodoItems> readTodo_Pre(
      $grpc.ServiceCall call, $async.Future<$0.voidnoparam> request) async {
    return readTodo(call, await request);
  }

  $async.Stream<$0.TodoItem> readTodosSTream_Pre(
      $grpc.ServiceCall call, $async.Future<$0.voidnoparam> request) async* {
    yield* readTodosSTream(call, await request);
  }

  $async.Future<$0.TodoItem> createTodo(
      $grpc.ServiceCall call, $0.TodoItem request);
  $async.Future<$0.TodoItems> readTodo(
      $grpc.ServiceCall call, $0.voidnoparam request);
  $async.Stream<$0.TodoItem> readTodosSTream(
      $grpc.ServiceCall call, $0.voidnoparam request);
}
