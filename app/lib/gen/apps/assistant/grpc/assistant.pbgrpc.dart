// This is a generated file - do not edit.
//
// Generated from apps/assistant/grpc/assistant.proto.

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
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart' as $0;

import 'assistant.pb.dart' as $1;

export 'assistant.pb.dart';

@$pb.GrpcServiceName('config.assistant.AssistantController')
class AssistantControllerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AssistantControllerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.Empty> clear(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$clear, request, options: options);
  }

  $grpc.ResponseFuture<$1.ChatReply> history(
    $1.HistoryQuery request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$history, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> linkCard(
    $1.CardLink request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$linkCard, request, options: options);
  }

  $grpc.ResponseFuture<$1.SmsCard> parseSms(
    $1.SmsText request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$parseSms, request, options: options);
  }

  $grpc.ResponseFuture<$1.ChatReply> send(
    $1.MessageSend request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$send, request, options: options);
  }

  // method descriptors

  static final _$clear = $grpc.ClientMethod<$0.Empty, $0.Empty>(
      '/config.assistant.AssistantController/Clear',
      ($0.Empty value) => value.writeToBuffer(),
      $0.Empty.fromBuffer);
  static final _$history = $grpc.ClientMethod<$1.HistoryQuery, $1.ChatReply>(
      '/config.assistant.AssistantController/History',
      ($1.HistoryQuery value) => value.writeToBuffer(),
      $1.ChatReply.fromBuffer);
  static final _$linkCard = $grpc.ClientMethod<$1.CardLink, $0.Empty>(
      '/config.assistant.AssistantController/LinkCard',
      ($1.CardLink value) => value.writeToBuffer(),
      $0.Empty.fromBuffer);
  static final _$parseSms = $grpc.ClientMethod<$1.SmsText, $1.SmsCard>(
      '/config.assistant.AssistantController/ParseSms',
      ($1.SmsText value) => value.writeToBuffer(),
      $1.SmsCard.fromBuffer);
  static final _$send = $grpc.ClientMethod<$1.MessageSend, $1.ChatReply>(
      '/config.assistant.AssistantController/Send',
      ($1.MessageSend value) => value.writeToBuffer(),
      $1.ChatReply.fromBuffer);
}

@$pb.GrpcServiceName('config.assistant.AssistantController')
abstract class AssistantControllerServiceBase extends $grpc.Service {
  $core.String get $name => 'config.assistant.AssistantController';

  AssistantControllerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Empty>(
        'Clear',
        clear_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.HistoryQuery, $1.ChatReply>(
        'History',
        history_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.HistoryQuery.fromBuffer(value),
        ($1.ChatReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CardLink, $0.Empty>(
        'LinkCard',
        linkCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.CardLink.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SmsText, $1.SmsCard>(
        'ParseSms',
        parseSms_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SmsText.fromBuffer(value),
        ($1.SmsCard value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.MessageSend, $1.ChatReply>(
        'Send',
        send_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.MessageSend.fromBuffer(value),
        ($1.ChatReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.Empty> clear_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return clear($call, await $request);
  }

  $async.Future<$0.Empty> clear($grpc.ServiceCall call, $0.Empty request);

  $async.Future<$1.ChatReply> history_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.HistoryQuery> $request) async {
    return history($call, await $request);
  }

  $async.Future<$1.ChatReply> history(
      $grpc.ServiceCall call, $1.HistoryQuery request);

  $async.Future<$0.Empty> linkCard_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.CardLink> $request) async {
    return linkCard($call, await $request);
  }

  $async.Future<$0.Empty> linkCard($grpc.ServiceCall call, $1.CardLink request);

  $async.Future<$1.SmsCard> parseSms_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.SmsText> $request) async {
    return parseSms($call, await $request);
  }

  $async.Future<$1.SmsCard> parseSms(
      $grpc.ServiceCall call, $1.SmsText request);

  $async.Future<$1.ChatReply> send_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.MessageSend> $request) async {
    return send($call, await $request);
  }

  $async.Future<$1.ChatReply> send(
      $grpc.ServiceCall call, $1.MessageSend request);
}
