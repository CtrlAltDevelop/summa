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

@$pb.GrpcServiceName('config.wallets.LedgerController')
class LedgerControllerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  LedgerControllerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.Empty> delete(
    $0.EntryRef request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$0.EntryReply> edit(
    $0.EntryEdit request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$edit, request, options: options);
  }

  $grpc.ResponseFuture<$0.EntryListReply> list(
    $0.EntryQuery request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$list, request, options: options);
  }

  $grpc.ResponseFuture<$0.EntryReply> record(
    $0.EntryRecord request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$record, request, options: options);
  }

  // method descriptors

  static final _$delete = $grpc.ClientMethod<$0.EntryRef, $1.Empty>(
      '/config.wallets.LedgerController/Delete',
      ($0.EntryRef value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
  static final _$edit = $grpc.ClientMethod<$0.EntryEdit, $0.EntryReply>(
      '/config.wallets.LedgerController/Edit',
      ($0.EntryEdit value) => value.writeToBuffer(),
      $0.EntryReply.fromBuffer);
  static final _$list = $grpc.ClientMethod<$0.EntryQuery, $0.EntryListReply>(
      '/config.wallets.LedgerController/List',
      ($0.EntryQuery value) => value.writeToBuffer(),
      $0.EntryListReply.fromBuffer);
  static final _$record = $grpc.ClientMethod<$0.EntryRecord, $0.EntryReply>(
      '/config.wallets.LedgerController/Record',
      ($0.EntryRecord value) => value.writeToBuffer(),
      $0.EntryReply.fromBuffer);
}

@$pb.GrpcServiceName('config.wallets.LedgerController')
abstract class LedgerControllerServiceBase extends $grpc.Service {
  $core.String get $name => 'config.wallets.LedgerController';

  LedgerControllerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.EntryRef, $1.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EntryRef.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EntryEdit, $0.EntryReply>(
        'Edit',
        edit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EntryEdit.fromBuffer(value),
        ($0.EntryReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EntryQuery, $0.EntryListReply>(
        'List',
        list_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EntryQuery.fromBuffer(value),
        ($0.EntryListReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EntryRecord, $0.EntryReply>(
        'Record',
        record_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EntryRecord.fromBuffer(value),
        ($0.EntryReply value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> delete_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.EntryRef> $request) async {
    return delete($call, await $request);
  }

  $async.Future<$1.Empty> delete($grpc.ServiceCall call, $0.EntryRef request);

  $async.Future<$0.EntryReply> edit_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.EntryEdit> $request) async {
    return edit($call, await $request);
  }

  $async.Future<$0.EntryReply> edit(
      $grpc.ServiceCall call, $0.EntryEdit request);

  $async.Future<$0.EntryListReply> list_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.EntryQuery> $request) async {
    return list($call, await $request);
  }

  $async.Future<$0.EntryListReply> list(
      $grpc.ServiceCall call, $0.EntryQuery request);

  $async.Future<$0.EntryReply> record_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.EntryRecord> $request) async {
    return record($call, await $request);
  }

  $async.Future<$0.EntryReply> record(
      $grpc.ServiceCall call, $0.EntryRecord request);
}

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
