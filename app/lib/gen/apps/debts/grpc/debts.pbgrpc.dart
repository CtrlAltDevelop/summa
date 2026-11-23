// This is a generated file - do not edit.
//
// Generated from apps/debts/grpc/debts.proto.

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

import 'debts.pb.dart' as $0;

export 'debts.pb.dart';

@$pb.GrpcServiceName('config.debts.DebtsController')
class DebtsControllerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  DebtsControllerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.DebtReply> create(
    $0.DebtCreate request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> delete(
    $0.DebtRef request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$0.DebtListReply> list(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$list, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> pay(
    $0.InstallmentPay request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$pay, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> unpay(
    $0.InstallmentRef request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$unpay, request, options: options);
  }

  // method descriptors

  static final _$create = $grpc.ClientMethod<$0.DebtCreate, $0.DebtReply>(
      '/config.debts.DebtsController/Create',
      ($0.DebtCreate value) => value.writeToBuffer(),
      $0.DebtReply.fromBuffer);
  static final _$delete = $grpc.ClientMethod<$0.DebtRef, $1.Empty>(
      '/config.debts.DebtsController/Delete',
      ($0.DebtRef value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
  static final _$list = $grpc.ClientMethod<$1.Empty, $0.DebtListReply>(
      '/config.debts.DebtsController/List',
      ($1.Empty value) => value.writeToBuffer(),
      $0.DebtListReply.fromBuffer);
  static final _$pay = $grpc.ClientMethod<$0.InstallmentPay, $1.Empty>(
      '/config.debts.DebtsController/Pay',
      ($0.InstallmentPay value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
  static final _$unpay = $grpc.ClientMethod<$0.InstallmentRef, $1.Empty>(
      '/config.debts.DebtsController/Unpay',
      ($0.InstallmentRef value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
}

@$pb.GrpcServiceName('config.debts.DebtsController')
abstract class DebtsControllerServiceBase extends $grpc.Service {
  $core.String get $name => 'config.debts.DebtsController';

  DebtsControllerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.DebtCreate, $0.DebtReply>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DebtCreate.fromBuffer(value),
        ($0.DebtReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DebtRef, $1.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DebtRef.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.DebtListReply>(
        'List',
        list_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.DebtListReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InstallmentPay, $1.Empty>(
        'Pay',
        pay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.InstallmentPay.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InstallmentRef, $1.Empty>(
        'Unpay',
        unpay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.InstallmentRef.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.DebtReply> create_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.DebtCreate> $request) async {
    return create($call, await $request);
  }

  $async.Future<$0.DebtReply> create(
      $grpc.ServiceCall call, $0.DebtCreate request);

  $async.Future<$1.Empty> delete_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.DebtRef> $request) async {
    return delete($call, await $request);
  }

  $async.Future<$1.Empty> delete($grpc.ServiceCall call, $0.DebtRef request);

  $async.Future<$0.DebtListReply> list_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return list($call, await $request);
  }

  $async.Future<$0.DebtListReply> list(
      $grpc.ServiceCall call, $1.Empty request);

  $async.Future<$1.Empty> pay_Pre($grpc.ServiceCall $call,
      $async.Future<$0.InstallmentPay> $request) async {
    return pay($call, await $request);
  }

  $async.Future<$1.Empty> pay(
      $grpc.ServiceCall call, $0.InstallmentPay request);

  $async.Future<$1.Empty> unpay_Pre($grpc.ServiceCall $call,
      $async.Future<$0.InstallmentRef> $request) async {
    return unpay($call, await $request);
  }

  $async.Future<$1.Empty> unpay(
      $grpc.ServiceCall call, $0.InstallmentRef request);
}
