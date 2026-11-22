// This is a generated file - do not edit.
//
// Generated from infrastructure/auth/sms_code/grpc/auth_sms_code.proto.

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

import 'auth_sms_code.pb.dart' as $0;

export 'auth_sms_code.pb.dart';

@$pb.GrpcServiceName('config.auth_sms_code.SmsCodeController')
class SmsCodeControllerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  SmsCodeControllerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.Challenge> loginStart(
    $0.LoginStartRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$loginStart, request, options: options);
  }

  $grpc.ResponseFuture<$0.LoginResult> loginVerify(
    $0.LoginVerifyRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$loginVerify, request, options: options);
  }

  $grpc.ResponseFuture<$0.Message> logout(
    $0.LogoutRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$logout, request, options: options);
  }

  $grpc.ResponseFuture<$0.Challenge> signupStart(
    $0.SignupStartRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$signupStart, request, options: options);
  }

  $grpc.ResponseFuture<$0.LoginResult> signupVerify(
    $0.SignupVerifyRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$signupVerify, request, options: options);
  }

  // method descriptors

  static final _$loginStart =
      $grpc.ClientMethod<$0.LoginStartRequest, $0.Challenge>(
          '/config.auth_sms_code.SmsCodeController/LoginStart',
          ($0.LoginStartRequest value) => value.writeToBuffer(),
          $0.Challenge.fromBuffer);
  static final _$loginVerify =
      $grpc.ClientMethod<$0.LoginVerifyRequest, $0.LoginResult>(
          '/config.auth_sms_code.SmsCodeController/LoginVerify',
          ($0.LoginVerifyRequest value) => value.writeToBuffer(),
          $0.LoginResult.fromBuffer);
  static final _$logout = $grpc.ClientMethod<$0.LogoutRequest, $0.Message>(
      '/config.auth_sms_code.SmsCodeController/Logout',
      ($0.LogoutRequest value) => value.writeToBuffer(),
      $0.Message.fromBuffer);
  static final _$signupStart =
      $grpc.ClientMethod<$0.SignupStartRequest, $0.Challenge>(
          '/config.auth_sms_code.SmsCodeController/SignupStart',
          ($0.SignupStartRequest value) => value.writeToBuffer(),
          $0.Challenge.fromBuffer);
  static final _$signupVerify =
      $grpc.ClientMethod<$0.SignupVerifyRequest, $0.LoginResult>(
          '/config.auth_sms_code.SmsCodeController/SignupVerify',
          ($0.SignupVerifyRequest value) => value.writeToBuffer(),
          $0.LoginResult.fromBuffer);
}

@$pb.GrpcServiceName('config.auth_sms_code.SmsCodeController')
abstract class SmsCodeControllerServiceBase extends $grpc.Service {
  $core.String get $name => 'config.auth_sms_code.SmsCodeController';

  SmsCodeControllerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.LoginStartRequest, $0.Challenge>(
        'LoginStart',
        loginStart_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LoginStartRequest.fromBuffer(value),
        ($0.Challenge value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LoginVerifyRequest, $0.LoginResult>(
        'LoginVerify',
        loginVerify_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.LoginVerifyRequest.fromBuffer(value),
        ($0.LoginResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LogoutRequest, $0.Message>(
        'Logout',
        logout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LogoutRequest.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SignupStartRequest, $0.Challenge>(
        'SignupStart',
        signupStart_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SignupStartRequest.fromBuffer(value),
        ($0.Challenge value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SignupVerifyRequest, $0.LoginResult>(
        'SignupVerify',
        signupVerify_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SignupVerifyRequest.fromBuffer(value),
        ($0.LoginResult value) => value.writeToBuffer()));
  }

  $async.Future<$0.Challenge> loginStart_Pre($grpc.ServiceCall $call,
      $async.Future<$0.LoginStartRequest> $request) async {
    return loginStart($call, await $request);
  }

  $async.Future<$0.Challenge> loginStart(
      $grpc.ServiceCall call, $0.LoginStartRequest request);

  $async.Future<$0.LoginResult> loginVerify_Pre($grpc.ServiceCall $call,
      $async.Future<$0.LoginVerifyRequest> $request) async {
    return loginVerify($call, await $request);
  }

  $async.Future<$0.LoginResult> loginVerify(
      $grpc.ServiceCall call, $0.LoginVerifyRequest request);

  $async.Future<$0.Message> logout_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.LogoutRequest> $request) async {
    return logout($call, await $request);
  }

  $async.Future<$0.Message> logout(
      $grpc.ServiceCall call, $0.LogoutRequest request);

  $async.Future<$0.Challenge> signupStart_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SignupStartRequest> $request) async {
    return signupStart($call, await $request);
  }

  $async.Future<$0.Challenge> signupStart(
      $grpc.ServiceCall call, $0.SignupStartRequest request);

  $async.Future<$0.LoginResult> signupVerify_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SignupVerifyRequest> $request) async {
    return signupVerify($call, await $request);
  }

  $async.Future<$0.LoginResult> signupVerify(
      $grpc.ServiceCall call, $0.SignupVerifyRequest request);
}
