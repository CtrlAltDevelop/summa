// This is a generated file - do not edit.
//
// Generated from apps/sync/grpc/sync.proto.

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

import 'sync.pb.dart' as $0;

export 'sync.pb.dart';

@$pb.GrpcServiceName('config.sync.SyncController')
class SyncControllerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  SyncControllerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.ChangesReply> changes(
    $0.ChangesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$changes, request, options: options);
  }

  // method descriptors

  static final _$changes =
      $grpc.ClientMethod<$0.ChangesRequest, $0.ChangesReply>(
          '/config.sync.SyncController/Changes',
          ($0.ChangesRequest value) => value.writeToBuffer(),
          $0.ChangesReply.fromBuffer);
}

@$pb.GrpcServiceName('config.sync.SyncController')
abstract class SyncControllerServiceBase extends $grpc.Service {
  $core.String get $name => 'config.sync.SyncController';

  SyncControllerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ChangesRequest, $0.ChangesReply>(
        'Changes',
        changes_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChangesRequest.fromBuffer(value),
        ($0.ChangesReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.ChangesReply> changes_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ChangesRequest> $request) async {
    return changes($call, await $request);
  }

  $async.Future<$0.ChangesReply> changes(
      $grpc.ServiceCall call, $0.ChangesRequest request);
}
