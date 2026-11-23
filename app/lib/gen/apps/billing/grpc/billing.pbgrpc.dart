// This is a generated file - do not edit.
//
// Generated from apps/billing/grpc/billing.proto.

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

import 'billing.pb.dart' as $0;

export 'billing.pb.dart';

@$pb.GrpcServiceName('config.billing.BillingController')
class BillingControllerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  BillingControllerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.CheckoutReply> checkout(
    $0.CheckoutRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$checkout, request, options: options);
  }

  $grpc.ResponseFuture<$0.PlanListReply> plans(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$plans, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusReply> startTrial(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$startTrial, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusReply> status(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$status, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusReply> verify(
    $0.VerifyRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verify, request, options: options);
  }

  // method descriptors

  static final _$checkout =
      $grpc.ClientMethod<$0.CheckoutRequest, $0.CheckoutReply>(
          '/config.billing.BillingController/Checkout',
          ($0.CheckoutRequest value) => value.writeToBuffer(),
          $0.CheckoutReply.fromBuffer);
  static final _$plans = $grpc.ClientMethod<$1.Empty, $0.PlanListReply>(
      '/config.billing.BillingController/Plans',
      ($1.Empty value) => value.writeToBuffer(),
      $0.PlanListReply.fromBuffer);
  static final _$startTrial = $grpc.ClientMethod<$1.Empty, $0.StatusReply>(
      '/config.billing.BillingController/StartTrial',
      ($1.Empty value) => value.writeToBuffer(),
      $0.StatusReply.fromBuffer);
  static final _$status = $grpc.ClientMethod<$1.Empty, $0.StatusReply>(
      '/config.billing.BillingController/Status',
      ($1.Empty value) => value.writeToBuffer(),
      $0.StatusReply.fromBuffer);
  static final _$verify = $grpc.ClientMethod<$0.VerifyRequest, $0.StatusReply>(
      '/config.billing.BillingController/Verify',
      ($0.VerifyRequest value) => value.writeToBuffer(),
      $0.StatusReply.fromBuffer);
}

@$pb.GrpcServiceName('config.billing.BillingController')
abstract class BillingControllerServiceBase extends $grpc.Service {
  $core.String get $name => 'config.billing.BillingController';

  BillingControllerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CheckoutRequest, $0.CheckoutReply>(
        'Checkout',
        checkout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CheckoutRequest.fromBuffer(value),
        ($0.CheckoutReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.PlanListReply>(
        'Plans',
        plans_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.PlanListReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.StatusReply>(
        'StartTrial',
        startTrial_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.StatusReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.StatusReply>(
        'Status',
        status_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.StatusReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyRequest, $0.StatusReply>(
        'Verify',
        verify_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifyRequest.fromBuffer(value),
        ($0.StatusReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.CheckoutReply> checkout_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CheckoutRequest> $request) async {
    return checkout($call, await $request);
  }

  $async.Future<$0.CheckoutReply> checkout(
      $grpc.ServiceCall call, $0.CheckoutRequest request);

  $async.Future<$0.PlanListReply> plans_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return plans($call, await $request);
  }

  $async.Future<$0.PlanListReply> plans(
      $grpc.ServiceCall call, $1.Empty request);

  $async.Future<$0.StatusReply> startTrial_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return startTrial($call, await $request);
  }

  $async.Future<$0.StatusReply> startTrial(
      $grpc.ServiceCall call, $1.Empty request);

  $async.Future<$0.StatusReply> status_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return status($call, await $request);
  }

  $async.Future<$0.StatusReply> status(
      $grpc.ServiceCall call, $1.Empty request);

  $async.Future<$0.StatusReply> verify_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.VerifyRequest> $request) async {
    return verify($call, await $request);
  }

  $async.Future<$0.StatusReply> verify(
      $grpc.ServiceCall call, $0.VerifyRequest request);
}
