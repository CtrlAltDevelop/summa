// This is a generated file - do not edit.
//
// Generated from apps/reports/grpc/reports.proto.

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

import 'reports.pb.dart' as $0;

export 'reports.pb.dart';

@$pb.GrpcServiceName('config.reports.ReportsController')
class ReportsControllerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ReportsControllerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.ExportReply> exportCsv(
    $0.ExportRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$exportCsv, request, options: options);
  }

  $grpc.ResponseFuture<$0.ReportReply> monthly(
    $0.ReportRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$monthly, request, options: options);
  }

  // method descriptors

  static final _$exportCsv =
      $grpc.ClientMethod<$0.ExportRequest, $0.ExportReply>(
          '/config.reports.ReportsController/ExportCsv',
          ($0.ExportRequest value) => value.writeToBuffer(),
          $0.ExportReply.fromBuffer);
  static final _$monthly = $grpc.ClientMethod<$0.ReportRequest, $0.ReportReply>(
      '/config.reports.ReportsController/Monthly',
      ($0.ReportRequest value) => value.writeToBuffer(),
      $0.ReportReply.fromBuffer);
}

@$pb.GrpcServiceName('config.reports.ReportsController')
abstract class ReportsControllerServiceBase extends $grpc.Service {
  $core.String get $name => 'config.reports.ReportsController';

  ReportsControllerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ExportRequest, $0.ExportReply>(
        'ExportCsv',
        exportCsv_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ExportRequest.fromBuffer(value),
        ($0.ExportReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReportRequest, $0.ReportReply>(
        'Monthly',
        monthly_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ReportRequest.fromBuffer(value),
        ($0.ReportReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.ExportReply> exportCsv_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.ExportRequest> $request) async {
    return exportCsv($call, await $request);
  }

  $async.Future<$0.ExportReply> exportCsv(
      $grpc.ServiceCall call, $0.ExportRequest request);

  $async.Future<$0.ReportReply> monthly_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.ReportRequest> $request) async {
    return monthly($call, await $request);
  }

  $async.Future<$0.ReportReply> monthly(
      $grpc.ServiceCall call, $0.ReportRequest request);
}
