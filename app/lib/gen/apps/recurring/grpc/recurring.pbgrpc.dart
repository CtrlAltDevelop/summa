// This is a generated file - do not edit.
//
// Generated from apps/recurring/grpc/recurring.proto.

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

import 'recurring.pb.dart' as $0;

export 'recurring.pb.dart';

@$pb.GrpcServiceName('config.recurring.RecurringController')
class RecurringControllerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  RecurringControllerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.RecurringReply> create(
    $0.RecurringCreate request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> delete(
    $0.RecurringRef request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$0.RecurringListReply> list(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$list, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> resolve(
    $0.OccurrenceAnswer request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$resolve, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> setActive(
    $0.RecurringActive request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$setActive, request, options: options);
  }

  // method descriptors

  static final _$create =
      $grpc.ClientMethod<$0.RecurringCreate, $0.RecurringReply>(
          '/config.recurring.RecurringController/Create',
          ($0.RecurringCreate value) => value.writeToBuffer(),
          $0.RecurringReply.fromBuffer);
  static final _$delete = $grpc.ClientMethod<$0.RecurringRef, $1.Empty>(
      '/config.recurring.RecurringController/Delete',
      ($0.RecurringRef value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
  static final _$list = $grpc.ClientMethod<$1.Empty, $0.RecurringListReply>(
      '/config.recurring.RecurringController/List',
      ($1.Empty value) => value.writeToBuffer(),
      $0.RecurringListReply.fromBuffer);
  static final _$resolve = $grpc.ClientMethod<$0.OccurrenceAnswer, $1.Empty>(
      '/config.recurring.RecurringController/Resolve',
      ($0.OccurrenceAnswer value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
  static final _$setActive = $grpc.ClientMethod<$0.RecurringActive, $1.Empty>(
      '/config.recurring.RecurringController/SetActive',
      ($0.RecurringActive value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
}

@$pb.GrpcServiceName('config.recurring.RecurringController')
abstract class RecurringControllerServiceBase extends $grpc.Service {
  $core.String get $name => 'config.recurring.RecurringController';

  RecurringControllerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RecurringCreate, $0.RecurringReply>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RecurringCreate.fromBuffer(value),
        ($0.RecurringReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RecurringRef, $1.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RecurringRef.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.RecurringListReply>(
        'List',
        list_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.RecurringListReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.OccurrenceAnswer, $1.Empty>(
        'Resolve',
        resolve_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.OccurrenceAnswer.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RecurringActive, $1.Empty>(
        'SetActive',
        setActive_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RecurringActive.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.RecurringReply> create_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RecurringCreate> $request) async {
    return create($call, await $request);
  }

  $async.Future<$0.RecurringReply> create(
      $grpc.ServiceCall call, $0.RecurringCreate request);

  $async.Future<$1.Empty> delete_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.RecurringRef> $request) async {
    return delete($call, await $request);
  }

  $async.Future<$1.Empty> delete(
      $grpc.ServiceCall call, $0.RecurringRef request);

  $async.Future<$0.RecurringListReply> list_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return list($call, await $request);
  }

  $async.Future<$0.RecurringListReply> list(
      $grpc.ServiceCall call, $1.Empty request);

  $async.Future<$1.Empty> resolve_Pre($grpc.ServiceCall $call,
      $async.Future<$0.OccurrenceAnswer> $request) async {
    return resolve($call, await $request);
  }

  $async.Future<$1.Empty> resolve(
      $grpc.ServiceCall call, $0.OccurrenceAnswer request);

  $async.Future<$1.Empty> setActive_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RecurringActive> $request) async {
    return setActive($call, await $request);
  }

  $async.Future<$1.Empty> setActive(
      $grpc.ServiceCall call, $0.RecurringActive request);
}
