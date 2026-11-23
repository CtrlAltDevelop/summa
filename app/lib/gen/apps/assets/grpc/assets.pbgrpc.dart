// This is a generated file - do not edit.
//
// Generated from apps/assets/grpc/assets.proto.

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

import 'assets.pb.dart' as $0;

export 'assets.pb.dart';

@$pb.GrpcServiceName('config.assets.AssetsController')
class AssetsControllerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AssetsControllerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.Empty> addLot(
    $0.LotAdd request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addLot, request, options: options);
  }

  $grpc.ResponseFuture<$0.AssetReply> create(
    $0.AssetCreate request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> delete(
    $0.AssetRef request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$0.AssetListReply> list(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$list, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> sell(
    $0.AssetSell request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$sell, request, options: options);
  }

  // method descriptors

  static final _$addLot = $grpc.ClientMethod<$0.LotAdd, $1.Empty>(
      '/config.assets.AssetsController/AddLot',
      ($0.LotAdd value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
  static final _$create = $grpc.ClientMethod<$0.AssetCreate, $0.AssetReply>(
      '/config.assets.AssetsController/Create',
      ($0.AssetCreate value) => value.writeToBuffer(),
      $0.AssetReply.fromBuffer);
  static final _$delete = $grpc.ClientMethod<$0.AssetRef, $1.Empty>(
      '/config.assets.AssetsController/Delete',
      ($0.AssetRef value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
  static final _$list = $grpc.ClientMethod<$1.Empty, $0.AssetListReply>(
      '/config.assets.AssetsController/List',
      ($1.Empty value) => value.writeToBuffer(),
      $0.AssetListReply.fromBuffer);
  static final _$sell = $grpc.ClientMethod<$0.AssetSell, $1.Empty>(
      '/config.assets.AssetsController/Sell',
      ($0.AssetSell value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
}

@$pb.GrpcServiceName('config.assets.AssetsController')
abstract class AssetsControllerServiceBase extends $grpc.Service {
  $core.String get $name => 'config.assets.AssetsController';

  AssetsControllerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.LotAdd, $1.Empty>(
        'AddLot',
        addLot_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LotAdd.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AssetCreate, $0.AssetReply>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AssetCreate.fromBuffer(value),
        ($0.AssetReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AssetRef, $1.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AssetRef.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.AssetListReply>(
        'List',
        list_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.AssetListReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AssetSell, $1.Empty>(
        'Sell',
        sell_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AssetSell.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> addLot_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.LotAdd> $request) async {
    return addLot($call, await $request);
  }

  $async.Future<$1.Empty> addLot($grpc.ServiceCall call, $0.LotAdd request);

  $async.Future<$0.AssetReply> create_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.AssetCreate> $request) async {
    return create($call, await $request);
  }

  $async.Future<$0.AssetReply> create(
      $grpc.ServiceCall call, $0.AssetCreate request);

  $async.Future<$1.Empty> delete_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.AssetRef> $request) async {
    return delete($call, await $request);
  }

  $async.Future<$1.Empty> delete($grpc.ServiceCall call, $0.AssetRef request);

  $async.Future<$0.AssetListReply> list_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return list($call, await $request);
  }

  $async.Future<$0.AssetListReply> list(
      $grpc.ServiceCall call, $1.Empty request);

  $async.Future<$1.Empty> sell_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.AssetSell> $request) async {
    return sell($call, await $request);
  }

  $async.Future<$1.Empty> sell($grpc.ServiceCall call, $0.AssetSell request);
}

@$pb.GrpcServiceName('config.assets.RatesController')
class RatesControllerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  RatesControllerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.ConvertReply> convert(
    $0.ConvertRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$convert, request, options: options);
  }

  $grpc.ResponseFuture<$0.RateListReply> list(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$list, request, options: options);
  }

  // method descriptors

  static final _$convert =
      $grpc.ClientMethod<$0.ConvertRequest, $0.ConvertReply>(
          '/config.assets.RatesController/Convert',
          ($0.ConvertRequest value) => value.writeToBuffer(),
          $0.ConvertReply.fromBuffer);
  static final _$list = $grpc.ClientMethod<$1.Empty, $0.RateListReply>(
      '/config.assets.RatesController/List',
      ($1.Empty value) => value.writeToBuffer(),
      $0.RateListReply.fromBuffer);
}

@$pb.GrpcServiceName('config.assets.RatesController')
abstract class RatesControllerServiceBase extends $grpc.Service {
  $core.String get $name => 'config.assets.RatesController';

  RatesControllerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ConvertRequest, $0.ConvertReply>(
        'Convert',
        convert_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ConvertRequest.fromBuffer(value),
        ($0.ConvertReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.RateListReply>(
        'List',
        list_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.RateListReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.ConvertReply> convert_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ConvertRequest> $request) async {
    return convert($call, await $request);
  }

  $async.Future<$0.ConvertReply> convert(
      $grpc.ServiceCall call, $0.ConvertRequest request);

  $async.Future<$0.RateListReply> list_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return list($call, await $request);
  }

  $async.Future<$0.RateListReply> list(
      $grpc.ServiceCall call, $1.Empty request);
}
