// This is a generated file - do not edit.
//
// Generated from apps/wallets/grpc/wallets.proto.

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

import 'wallets.pb.dart' as $0;

export 'wallets.pb.dart';

@$pb.GrpcServiceName('config.wallets.WalletsController')
class WalletsControllerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  WalletsControllerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.WalletReply> archive(
    $0.WalletRef request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$archive, request, options: options);
  }

  $grpc.ResponseFuture<$0.WalletReply> create(
    $0.WalletCreate request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$0.WalletListReply> list(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$list, request, options: options);
  }

  // method descriptors

  static final _$archive = $grpc.ClientMethod<$0.WalletRef, $0.WalletReply>(
      '/config.wallets.WalletsController/Archive',
      ($0.WalletRef value) => value.writeToBuffer(),
      $0.WalletReply.fromBuffer);
  static final _$create = $grpc.ClientMethod<$0.WalletCreate, $0.WalletReply>(
      '/config.wallets.WalletsController/Create',
      ($0.WalletCreate value) => value.writeToBuffer(),
      $0.WalletReply.fromBuffer);
  static final _$list = $grpc.ClientMethod<$1.Empty, $0.WalletListReply>(
      '/config.wallets.WalletsController/List',
      ($1.Empty value) => value.writeToBuffer(),
      $0.WalletListReply.fromBuffer);
}

@$pb.GrpcServiceName('config.wallets.WalletsController')
abstract class WalletsControllerServiceBase extends $grpc.Service {
  $core.String get $name => 'config.wallets.WalletsController';

  WalletsControllerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.WalletRef, $0.WalletReply>(
        'Archive',
        archive_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WalletRef.fromBuffer(value),
        ($0.WalletReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WalletCreate, $0.WalletReply>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WalletCreate.fromBuffer(value),
        ($0.WalletReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.WalletListReply>(
        'List',
        list_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.WalletListReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.WalletReply> archive_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.WalletRef> $request) async {
    return archive($call, await $request);
  }

  $async.Future<$0.WalletReply> archive(
      $grpc.ServiceCall call, $0.WalletRef request);

  $async.Future<$0.WalletReply> create_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.WalletCreate> $request) async {
    return create($call, await $request);
  }

  $async.Future<$0.WalletReply> create(
      $grpc.ServiceCall call, $0.WalletCreate request);

  $async.Future<$0.WalletListReply> list_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return list($call, await $request);
  }

  $async.Future<$0.WalletListReply> list(
      $grpc.ServiceCall call, $1.Empty request);
}
