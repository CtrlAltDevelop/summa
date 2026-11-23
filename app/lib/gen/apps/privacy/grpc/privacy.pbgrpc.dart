// This is a generated file - do not edit.
//
// Generated from apps/privacy/grpc/privacy.proto.

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

import 'privacy.pb.dart' as $0;

export 'privacy.pb.dart';

@$pb.GrpcServiceName('config.privacy.PrivacyController')
class PrivacyControllerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  PrivacyControllerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.Empty> deleteAccount(
    $0.DeleteConfirmation request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.PrivacySettings> getSettings(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSettings, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> setChatRetention(
    $0.ChatRetention request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$setChatRetention, request, options: options);
  }

  // method descriptors

  static final _$deleteAccount =
      $grpc.ClientMethod<$0.DeleteConfirmation, $1.Empty>(
          '/config.privacy.PrivacyController/DeleteAccount',
          ($0.DeleteConfirmation value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
  static final _$getSettings = $grpc.ClientMethod<$1.Empty, $0.PrivacySettings>(
      '/config.privacy.PrivacyController/GetSettings',
      ($1.Empty value) => value.writeToBuffer(),
      $0.PrivacySettings.fromBuffer);
  static final _$setChatRetention =
      $grpc.ClientMethod<$0.ChatRetention, $1.Empty>(
          '/config.privacy.PrivacyController/SetChatRetention',
          ($0.ChatRetention value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
}

@$pb.GrpcServiceName('config.privacy.PrivacyController')
abstract class PrivacyControllerServiceBase extends $grpc.Service {
  $core.String get $name => 'config.privacy.PrivacyController';

  PrivacyControllerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.DeleteConfirmation, $1.Empty>(
        'DeleteAccount',
        deleteAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteConfirmation.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.PrivacySettings>(
        'GetSettings',
        getSettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.PrivacySettings value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChatRetention, $1.Empty>(
        'SetChatRetention',
        setChatRetention_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChatRetention.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> deleteAccount_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DeleteConfirmation> $request) async {
    return deleteAccount($call, await $request);
  }

  $async.Future<$1.Empty> deleteAccount(
      $grpc.ServiceCall call, $0.DeleteConfirmation request);

  $async.Future<$0.PrivacySettings> getSettings_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return getSettings($call, await $request);
  }

  $async.Future<$0.PrivacySettings> getSettings(
      $grpc.ServiceCall call, $1.Empty request);

  $async.Future<$1.Empty> setChatRetention_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.ChatRetention> $request) async {
    return setChatRetention($call, await $request);
  }

  $async.Future<$1.Empty> setChatRetention(
      $grpc.ServiceCall call, $0.ChatRetention request);
}
