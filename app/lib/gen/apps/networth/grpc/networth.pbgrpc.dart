// This is a generated file - do not edit.
//
// Generated from apps/networth/grpc/networth.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart' as $1;

import 'networth.pb.dart' as $0;

export 'networth.pb.dart';

@$pb.GrpcServiceName('config.networth.NetWorthController')
class NetWorthControllerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  NetWorthControllerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.BasketReply> createBasket(
    $0.BasketCreate request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createBasket, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteBasket(
    $0.BasketRef request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteBasket, request, options: options);
  }

  $grpc.ResponseFuture<$0.NetWorthReply> get(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$get, request, options: options);
  }

  $grpc.ResponseFuture<$0.HistoryReply> history(
    $0.HistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$history, request, options: options);
  }

  $grpc.ResponseFuture<$0.BasketListReply> listBaskets(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listBaskets, request, options: options);
  }

  // method descriptors

  static final _$createBasket =
      $grpc.ClientMethod<$0.BasketCreate, $0.BasketReply>(
          '/config.networth.NetWorthController/CreateBasket',
          ($0.BasketCreate value) => value.writeToBuffer(),
          $0.BasketReply.fromBuffer);
  static final _$deleteBasket = $grpc.ClientMethod<$0.BasketRef, $1.Empty>(
      '/config.networth.NetWorthController/DeleteBasket',
      ($0.BasketRef value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
  static final _$get = $grpc.ClientMethod<$1.Empty, $0.NetWorthReply>(
      '/config.networth.NetWorthController/Get',
      ($1.Empty value) => value.writeToBuffer(),
      $0.NetWorthReply.fromBuffer);
  static final _$history =
      $grpc.ClientMethod<$0.HistoryRequest, $0.HistoryReply>(
          '/config.networth.NetWorthController/History',
          ($0.HistoryRequest value) => value.writeToBuffer(),
          $0.HistoryReply.fromBuffer);
  static final _$listBaskets = $grpc.ClientMethod<$1.Empty, $0.BasketListReply>(
      '/config.networth.NetWorthController/ListBaskets',
      ($1.Empty value) => value.writeToBuffer(),
      $0.BasketListReply.fromBuffer);
}

@$pb.GrpcServiceName('config.networth.NetWorthController')
abstract class NetWorthControllerServiceBase extends $grpc.Service {
  $core.String get $name => 'config.networth.NetWorthController';

  NetWorthControllerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.BasketCreate, $0.BasketReply>(
        'CreateBasket',
        createBasket_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BasketCreate.fromBuffer(value),
        ($0.BasketReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BasketRef, $1.Empty>(
        'DeleteBasket',
        deleteBasket_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BasketRef.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.NetWorthReply>(
        'Get',
        get_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.NetWorthReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HistoryRequest, $0.HistoryReply>(
        'History',
        history_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HistoryRequest.fromBuffer(value),
        ($0.HistoryReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.BasketListReply>(
        'ListBaskets',
        listBaskets_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.BasketListReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.BasketReply> createBasket_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.BasketCreate> $request) async {
    return createBasket($call, await $request);
  }

  $async.Future<$0.BasketReply> createBasket(
      $grpc.ServiceCall call, $0.BasketCreate request);

  $async.Future<$1.Empty> deleteBasket_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.BasketRef> $request) async {
    return deleteBasket($call, await $request);
  }

  $async.Future<$1.Empty> deleteBasket(
      $grpc.ServiceCall call, $0.BasketRef request);

  $async.Future<$0.NetWorthReply> get_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return get($call, await $request);
  }

  $async.Future<$0.NetWorthReply> get($grpc.ServiceCall call, $1.Empty request);

  $async.Future<$0.HistoryReply> history_Pre($grpc.ServiceCall $call,
      $async.Future<$0.HistoryRequest> $request) async {
    return history($call, await $request);
  }

  $async.Future<$0.HistoryReply> history(
      $grpc.ServiceCall call, $0.HistoryRequest request);

  $async.Future<$0.BasketListReply> listBaskets_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return listBaskets($call, await $request);
  }

  $async.Future<$0.BasketListReply> listBaskets(
      $grpc.ServiceCall call, $1.Empty request);
}
