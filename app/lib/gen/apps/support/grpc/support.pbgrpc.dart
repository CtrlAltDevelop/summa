// This is a generated file - do not edit.
//
// Generated from apps/support/grpc/support.proto.

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

import 'support.pb.dart' as $0;

export 'support.pb.dart';

@$pb.GrpcServiceName('config.support.SupportController')
class SupportControllerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  SupportControllerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.AssignResult> assign(
    $0.AssignRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$assign, request, options: options);
  }

  $grpc.ResponseFuture<$0.CannedList> canned(
    $0.CannedRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$canned, request, options: options);
  }

  $grpc.ResponseFuture<$0.CategoryList> categories(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$categories, request, options: options);
  }

  $grpc.ResponseFuture<$0.ChannelList> channels(
    $0.ChannelsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$channels, request, options: options);
  }

  $grpc.ResponseFuture<$0.ClaimResult> claim(
    $0.ClaimRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$claim, request, options: options);
  }

  $grpc.ResponseFuture<$0.CountResult> count(
    $0.CountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$count, request, options: options);
  }

  $grpc.ResponseFuture<$0.Ticket> createChannel(
    $0.CreateChannelRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createChannel, request, options: options);
  }

  $grpc.ResponseFuture<$0.Ticket> createGroup(
    $0.CreateGroupRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeletedMessage> delete(
    $0.DeleteRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$0.Ticket> direct(
    $0.DirectRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$direct, request, options: options);
  }

  $grpc.ResponseFuture<$0.EditedMessage> edit(
    $0.EditRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$edit, request, options: options);
  }

  $grpc.ResponseFuture<$0.Ticket> get(
    $0.GetRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$get, request, options: options);
  }

  $grpc.ResponseFuture<$0.InvitedParticipant> invite(
    $0.InviteRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$invite, request, options: options);
  }

  $grpc.ResponseFuture<$0.JoinedParticipant> join(
    $0.JoinRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$join, request, options: options);
  }

  $grpc.ResponseFuture<$0.LeaveResult> leave(
    $0.LeaveRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$leave, request, options: options);
  }

  $grpc.ResponseFuture<$0.TicketList> list(
    $0.ListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$list, request, options: options);
  }

  $grpc.ResponseFuture<$0.MessageList> messages(
    $0.MessagesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$messages, request, options: options);
  }

  $grpc.ResponseFuture<$0.OpenedTicket> open(
    $0.OpenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$open, request, options: options);
  }

  $grpc.ResponseFuture<$0.PriorityResult> priority(
    $0.PriorityRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$priority, request, options: options);
  }

  $grpc.ResponseFuture<$0.RateResult> rate(
    $0.RateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$rate, request, options: options);
  }

  $grpc.ResponseFuture<$0.ReadResult> read(
    $0.ReadRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$read, request, options: options);
  }

  $grpc.ResponseFuture<$0.SentMessage> send(
    $0.SendRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$send, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatsResult> stats(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$stats, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusResult> status(
    $0.StatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$status, request, options: options);
  }

  $grpc.ResponseFuture<$0.TagResult> tag(
    $0.TagRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$tag, request, options: options);
  }

  $grpc.ResponseFuture<$0.TagList> tags(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$tags, request, options: options);
  }

  $grpc.ResponseFuture<$0.TypingResult> typing(
    $0.TypingRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$typing, request, options: options);
  }

  $grpc.ResponseFuture<$0.UnreadResult> unread(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$unread, request, options: options);
  }

  $grpc.ResponseFuture<$0.UnreadTicketResult> unreadTicket(
    $0.UnreadTicketRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$unreadTicket, request, options: options);
  }

  // method descriptors

  static final _$assign = $grpc.ClientMethod<$0.AssignRequest, $0.AssignResult>(
      '/config.support.SupportController/Assign',
      ($0.AssignRequest value) => value.writeToBuffer(),
      $0.AssignResult.fromBuffer);
  static final _$canned = $grpc.ClientMethod<$0.CannedRequest, $0.CannedList>(
      '/config.support.SupportController/Canned',
      ($0.CannedRequest value) => value.writeToBuffer(),
      $0.CannedList.fromBuffer);
  static final _$categories = $grpc.ClientMethod<$1.Empty, $0.CategoryList>(
      '/config.support.SupportController/Categories',
      ($1.Empty value) => value.writeToBuffer(),
      $0.CategoryList.fromBuffer);
  static final _$channels =
      $grpc.ClientMethod<$0.ChannelsRequest, $0.ChannelList>(
          '/config.support.SupportController/Channels',
          ($0.ChannelsRequest value) => value.writeToBuffer(),
          $0.ChannelList.fromBuffer);
  static final _$claim = $grpc.ClientMethod<$0.ClaimRequest, $0.ClaimResult>(
      '/config.support.SupportController/Claim',
      ($0.ClaimRequest value) => value.writeToBuffer(),
      $0.ClaimResult.fromBuffer);
  static final _$count = $grpc.ClientMethod<$0.CountRequest, $0.CountResult>(
      '/config.support.SupportController/Count',
      ($0.CountRequest value) => value.writeToBuffer(),
      $0.CountResult.fromBuffer);
  static final _$createChannel =
      $grpc.ClientMethod<$0.CreateChannelRequest, $0.Ticket>(
          '/config.support.SupportController/CreateChannel',
          ($0.CreateChannelRequest value) => value.writeToBuffer(),
          $0.Ticket.fromBuffer);
  static final _$createGroup =
      $grpc.ClientMethod<$0.CreateGroupRequest, $0.Ticket>(
          '/config.support.SupportController/CreateGroup',
          ($0.CreateGroupRequest value) => value.writeToBuffer(),
          $0.Ticket.fromBuffer);
  static final _$delete =
      $grpc.ClientMethod<$0.DeleteRequest, $0.DeletedMessage>(
          '/config.support.SupportController/Delete',
          ($0.DeleteRequest value) => value.writeToBuffer(),
          $0.DeletedMessage.fromBuffer);
  static final _$direct = $grpc.ClientMethod<$0.DirectRequest, $0.Ticket>(
      '/config.support.SupportController/Direct',
      ($0.DirectRequest value) => value.writeToBuffer(),
      $0.Ticket.fromBuffer);
  static final _$edit = $grpc.ClientMethod<$0.EditRequest, $0.EditedMessage>(
      '/config.support.SupportController/Edit',
      ($0.EditRequest value) => value.writeToBuffer(),
      $0.EditedMessage.fromBuffer);
  static final _$get = $grpc.ClientMethod<$0.GetRequest, $0.Ticket>(
      '/config.support.SupportController/Get',
      ($0.GetRequest value) => value.writeToBuffer(),
      $0.Ticket.fromBuffer);
  static final _$invite =
      $grpc.ClientMethod<$0.InviteRequest, $0.InvitedParticipant>(
          '/config.support.SupportController/Invite',
          ($0.InviteRequest value) => value.writeToBuffer(),
          $0.InvitedParticipant.fromBuffer);
  static final _$join =
      $grpc.ClientMethod<$0.JoinRequest, $0.JoinedParticipant>(
          '/config.support.SupportController/Join',
          ($0.JoinRequest value) => value.writeToBuffer(),
          $0.JoinedParticipant.fromBuffer);
  static final _$leave = $grpc.ClientMethod<$0.LeaveRequest, $0.LeaveResult>(
      '/config.support.SupportController/Leave',
      ($0.LeaveRequest value) => value.writeToBuffer(),
      $0.LeaveResult.fromBuffer);
  static final _$list = $grpc.ClientMethod<$0.ListRequest, $0.TicketList>(
      '/config.support.SupportController/List',
      ($0.ListRequest value) => value.writeToBuffer(),
      $0.TicketList.fromBuffer);
  static final _$messages =
      $grpc.ClientMethod<$0.MessagesRequest, $0.MessageList>(
          '/config.support.SupportController/Messages',
          ($0.MessagesRequest value) => value.writeToBuffer(),
          $0.MessageList.fromBuffer);
  static final _$open = $grpc.ClientMethod<$0.OpenRequest, $0.OpenedTicket>(
      '/config.support.SupportController/Open',
      ($0.OpenRequest value) => value.writeToBuffer(),
      $0.OpenedTicket.fromBuffer);
  static final _$priority =
      $grpc.ClientMethod<$0.PriorityRequest, $0.PriorityResult>(
          '/config.support.SupportController/Priority',
          ($0.PriorityRequest value) => value.writeToBuffer(),
          $0.PriorityResult.fromBuffer);
  static final _$rate = $grpc.ClientMethod<$0.RateRequest, $0.RateResult>(
      '/config.support.SupportController/Rate',
      ($0.RateRequest value) => value.writeToBuffer(),
      $0.RateResult.fromBuffer);
  static final _$read = $grpc.ClientMethod<$0.ReadRequest, $0.ReadResult>(
      '/config.support.SupportController/Read',
      ($0.ReadRequest value) => value.writeToBuffer(),
      $0.ReadResult.fromBuffer);
  static final _$send = $grpc.ClientMethod<$0.SendRequest, $0.SentMessage>(
      '/config.support.SupportController/Send',
      ($0.SendRequest value) => value.writeToBuffer(),
      $0.SentMessage.fromBuffer);
  static final _$stats = $grpc.ClientMethod<$1.Empty, $0.StatsResult>(
      '/config.support.SupportController/Stats',
      ($1.Empty value) => value.writeToBuffer(),
      $0.StatsResult.fromBuffer);
  static final _$status = $grpc.ClientMethod<$0.StatusRequest, $0.StatusResult>(
      '/config.support.SupportController/Status',
      ($0.StatusRequest value) => value.writeToBuffer(),
      $0.StatusResult.fromBuffer);
  static final _$tag = $grpc.ClientMethod<$0.TagRequest, $0.TagResult>(
      '/config.support.SupportController/Tag',
      ($0.TagRequest value) => value.writeToBuffer(),
      $0.TagResult.fromBuffer);
  static final _$tags = $grpc.ClientMethod<$1.Empty, $0.TagList>(
      '/config.support.SupportController/Tags',
      ($1.Empty value) => value.writeToBuffer(),
      $0.TagList.fromBuffer);
  static final _$typing = $grpc.ClientMethod<$0.TypingRequest, $0.TypingResult>(
      '/config.support.SupportController/Typing',
      ($0.TypingRequest value) => value.writeToBuffer(),
      $0.TypingResult.fromBuffer);
  static final _$unread = $grpc.ClientMethod<$1.Empty, $0.UnreadResult>(
      '/config.support.SupportController/Unread',
      ($1.Empty value) => value.writeToBuffer(),
      $0.UnreadResult.fromBuffer);
  static final _$unreadTicket =
      $grpc.ClientMethod<$0.UnreadTicketRequest, $0.UnreadTicketResult>(
          '/config.support.SupportController/UnreadTicket',
          ($0.UnreadTicketRequest value) => value.writeToBuffer(),
          $0.UnreadTicketResult.fromBuffer);
}

@$pb.GrpcServiceName('config.support.SupportController')
abstract class SupportControllerServiceBase extends $grpc.Service {
  $core.String get $name => 'config.support.SupportController';

  SupportControllerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.AssignRequest, $0.AssignResult>(
        'Assign',
        assign_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AssignRequest.fromBuffer(value),
        ($0.AssignResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CannedRequest, $0.CannedList>(
        'Canned',
        canned_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CannedRequest.fromBuffer(value),
        ($0.CannedList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.CategoryList>(
        'Categories',
        categories_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.CategoryList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChannelsRequest, $0.ChannelList>(
        'Channels',
        channels_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChannelsRequest.fromBuffer(value),
        ($0.ChannelList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ClaimRequest, $0.ClaimResult>(
        'Claim',
        claim_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ClaimRequest.fromBuffer(value),
        ($0.ClaimResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CountRequest, $0.CountResult>(
        'Count',
        count_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CountRequest.fromBuffer(value),
        ($0.CountResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateChannelRequest, $0.Ticket>(
        'CreateChannel',
        createChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateChannelRequest.fromBuffer(value),
        ($0.Ticket value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateGroupRequest, $0.Ticket>(
        'CreateGroup',
        createGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateGroupRequest.fromBuffer(value),
        ($0.Ticket value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteRequest, $0.DeletedMessage>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteRequest.fromBuffer(value),
        ($0.DeletedMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DirectRequest, $0.Ticket>(
        'Direct',
        direct_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DirectRequest.fromBuffer(value),
        ($0.Ticket value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EditRequest, $0.EditedMessage>(
        'Edit',
        edit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EditRequest.fromBuffer(value),
        ($0.EditedMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRequest, $0.Ticket>(
        'Get',
        get_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetRequest.fromBuffer(value),
        ($0.Ticket value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InviteRequest, $0.InvitedParticipant>(
        'Invite',
        invite_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.InviteRequest.fromBuffer(value),
        ($0.InvitedParticipant value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JoinRequest, $0.JoinedParticipant>(
        'Join',
        join_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.JoinRequest.fromBuffer(value),
        ($0.JoinedParticipant value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LeaveRequest, $0.LeaveResult>(
        'Leave',
        leave_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LeaveRequest.fromBuffer(value),
        ($0.LeaveResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListRequest, $0.TicketList>(
        'List',
        list_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListRequest.fromBuffer(value),
        ($0.TicketList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MessagesRequest, $0.MessageList>(
        'Messages',
        messages_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MessagesRequest.fromBuffer(value),
        ($0.MessageList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.OpenRequest, $0.OpenedTicket>(
        'Open',
        open_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.OpenRequest.fromBuffer(value),
        ($0.OpenedTicket value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PriorityRequest, $0.PriorityResult>(
        'Priority',
        priority_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PriorityRequest.fromBuffer(value),
        ($0.PriorityResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RateRequest, $0.RateResult>(
        'Rate',
        rate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RateRequest.fromBuffer(value),
        ($0.RateResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReadRequest, $0.ReadResult>(
        'Read',
        read_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ReadRequest.fromBuffer(value),
        ($0.ReadResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SendRequest, $0.SentMessage>(
        'Send',
        send_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SendRequest.fromBuffer(value),
        ($0.SentMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.StatsResult>(
        'Stats',
        stats_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.StatsResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StatusRequest, $0.StatusResult>(
        'Status',
        status_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StatusRequest.fromBuffer(value),
        ($0.StatusResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TagRequest, $0.TagResult>(
        'Tag',
        tag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TagRequest.fromBuffer(value),
        ($0.TagResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.TagList>(
        'Tags',
        tags_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.TagList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TypingRequest, $0.TypingResult>(
        'Typing',
        typing_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TypingRequest.fromBuffer(value),
        ($0.TypingResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.UnreadResult>(
        'Unread',
        unread_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.UnreadResult value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.UnreadTicketRequest, $0.UnreadTicketResult>(
            'UnreadTicket',
            unreadTicket_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.UnreadTicketRequest.fromBuffer(value),
            ($0.UnreadTicketResult value) => value.writeToBuffer()));
  }

  $async.Future<$0.AssignResult> assign_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.AssignRequest> $request) async {
    return assign($call, await $request);
  }

  $async.Future<$0.AssignResult> assign(
      $grpc.ServiceCall call, $0.AssignRequest request);

  $async.Future<$0.CannedList> canned_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.CannedRequest> $request) async {
    return canned($call, await $request);
  }

  $async.Future<$0.CannedList> canned(
      $grpc.ServiceCall call, $0.CannedRequest request);

  $async.Future<$0.CategoryList> categories_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return categories($call, await $request);
  }

  $async.Future<$0.CategoryList> categories(
      $grpc.ServiceCall call, $1.Empty request);

  $async.Future<$0.ChannelList> channels_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ChannelsRequest> $request) async {
    return channels($call, await $request);
  }

  $async.Future<$0.ChannelList> channels(
      $grpc.ServiceCall call, $0.ChannelsRequest request);

  $async.Future<$0.ClaimResult> claim_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.ClaimRequest> $request) async {
    return claim($call, await $request);
  }

  $async.Future<$0.ClaimResult> claim(
      $grpc.ServiceCall call, $0.ClaimRequest request);

  $async.Future<$0.CountResult> count_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.CountRequest> $request) async {
    return count($call, await $request);
  }

  $async.Future<$0.CountResult> count(
      $grpc.ServiceCall call, $0.CountRequest request);

  $async.Future<$0.Ticket> createChannel_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateChannelRequest> $request) async {
    return createChannel($call, await $request);
  }

  $async.Future<$0.Ticket> createChannel(
      $grpc.ServiceCall call, $0.CreateChannelRequest request);

  $async.Future<$0.Ticket> createGroup_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateGroupRequest> $request) async {
    return createGroup($call, await $request);
  }

  $async.Future<$0.Ticket> createGroup(
      $grpc.ServiceCall call, $0.CreateGroupRequest request);

  $async.Future<$0.DeletedMessage> delete_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.DeleteRequest> $request) async {
    return delete($call, await $request);
  }

  $async.Future<$0.DeletedMessage> delete(
      $grpc.ServiceCall call, $0.DeleteRequest request);

  $async.Future<$0.Ticket> direct_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.DirectRequest> $request) async {
    return direct($call, await $request);
  }

  $async.Future<$0.Ticket> direct(
      $grpc.ServiceCall call, $0.DirectRequest request);

  $async.Future<$0.EditedMessage> edit_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.EditRequest> $request) async {
    return edit($call, await $request);
  }

  $async.Future<$0.EditedMessage> edit(
      $grpc.ServiceCall call, $0.EditRequest request);

  $async.Future<$0.Ticket> get_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.GetRequest> $request) async {
    return get($call, await $request);
  }

  $async.Future<$0.Ticket> get($grpc.ServiceCall call, $0.GetRequest request);

  $async.Future<$0.InvitedParticipant> invite_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.InviteRequest> $request) async {
    return invite($call, await $request);
  }

  $async.Future<$0.InvitedParticipant> invite(
      $grpc.ServiceCall call, $0.InviteRequest request);

  $async.Future<$0.JoinedParticipant> join_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.JoinRequest> $request) async {
    return join($call, await $request);
  }

  $async.Future<$0.JoinedParticipant> join(
      $grpc.ServiceCall call, $0.JoinRequest request);

  $async.Future<$0.LeaveResult> leave_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.LeaveRequest> $request) async {
    return leave($call, await $request);
  }

  $async.Future<$0.LeaveResult> leave(
      $grpc.ServiceCall call, $0.LeaveRequest request);

  $async.Future<$0.TicketList> list_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.ListRequest> $request) async {
    return list($call, await $request);
  }

  $async.Future<$0.TicketList> list(
      $grpc.ServiceCall call, $0.ListRequest request);

  $async.Future<$0.MessageList> messages_Pre($grpc.ServiceCall $call,
      $async.Future<$0.MessagesRequest> $request) async {
    return messages($call, await $request);
  }

  $async.Future<$0.MessageList> messages(
      $grpc.ServiceCall call, $0.MessagesRequest request);

  $async.Future<$0.OpenedTicket> open_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.OpenRequest> $request) async {
    return open($call, await $request);
  }

  $async.Future<$0.OpenedTicket> open(
      $grpc.ServiceCall call, $0.OpenRequest request);

  $async.Future<$0.PriorityResult> priority_Pre($grpc.ServiceCall $call,
      $async.Future<$0.PriorityRequest> $request) async {
    return priority($call, await $request);
  }

  $async.Future<$0.PriorityResult> priority(
      $grpc.ServiceCall call, $0.PriorityRequest request);

  $async.Future<$0.RateResult> rate_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.RateRequest> $request) async {
    return rate($call, await $request);
  }

  $async.Future<$0.RateResult> rate(
      $grpc.ServiceCall call, $0.RateRequest request);

  $async.Future<$0.ReadResult> read_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.ReadRequest> $request) async {
    return read($call, await $request);
  }

  $async.Future<$0.ReadResult> read(
      $grpc.ServiceCall call, $0.ReadRequest request);

  $async.Future<$0.SentMessage> send_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.SendRequest> $request) async {
    return send($call, await $request);
  }

  $async.Future<$0.SentMessage> send(
      $grpc.ServiceCall call, $0.SendRequest request);

  $async.Future<$0.StatsResult> stats_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return stats($call, await $request);
  }

  $async.Future<$0.StatsResult> stats($grpc.ServiceCall call, $1.Empty request);

  $async.Future<$0.StatusResult> status_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.StatusRequest> $request) async {
    return status($call, await $request);
  }

  $async.Future<$0.StatusResult> status(
      $grpc.ServiceCall call, $0.StatusRequest request);

  $async.Future<$0.TagResult> tag_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.TagRequest> $request) async {
    return tag($call, await $request);
  }

  $async.Future<$0.TagResult> tag(
      $grpc.ServiceCall call, $0.TagRequest request);

  $async.Future<$0.TagList> tags_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return tags($call, await $request);
  }

  $async.Future<$0.TagList> tags($grpc.ServiceCall call, $1.Empty request);

  $async.Future<$0.TypingResult> typing_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.TypingRequest> $request) async {
    return typing($call, await $request);
  }

  $async.Future<$0.TypingResult> typing(
      $grpc.ServiceCall call, $0.TypingRequest request);

  $async.Future<$0.UnreadResult> unread_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return unread($call, await $request);
  }

  $async.Future<$0.UnreadResult> unread(
      $grpc.ServiceCall call, $1.Empty request);

  $async.Future<$0.UnreadTicketResult> unreadTicket_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UnreadTicketRequest> $request) async {
    return unreadTicket($call, await $request);
  }

  $async.Future<$0.UnreadTicketResult> unreadTicket(
      $grpc.ServiceCall call, $0.UnreadTicketRequest request);
}
