// This is a generated file - do not edit.
//
// Generated from apps/support/grpc/support.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use accountDescriptor instead')
const Account$json = {
  '1': 'Account',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'staff', '3': 3, '4': 1, '5': 8, '10': 'staff'},
  ],
};

/// Descriptor for `Account`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountDescriptor = $convert.base64Decode(
    'CgdBY2NvdW50Eg4KAmlkGAEgASgJUgJpZBIaCgh1c2VybmFtZRgCIAEoCVIIdXNlcm5hbWUSFA'
    'oFc3RhZmYYAyABKAhSBXN0YWZm');

@$core.Deprecated('Use accountResponseDescriptor instead')
const AccountResponse$json = {
  '1': 'AccountResponse',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'staff', '3': 3, '4': 1, '5': 8, '10': 'staff'},
  ],
};

/// Descriptor for `AccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountResponseDescriptor = $convert.base64Decode(
    'Cg9BY2NvdW50UmVzcG9uc2USDgoCaWQYASABKAlSAmlkEhoKCHVzZXJuYW1lGAIgASgJUgh1c2'
    'VybmFtZRIUCgVzdGFmZhgDIAEoCFIFc3RhZmY=');

@$core.Deprecated('Use assignRequestDescriptor instead')
const AssignRequest$json = {
  '1': 'AssignRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'agent', '3': 2, '4': 1, '5': 9, '10': 'agent'},
  ],
};

/// Descriptor for `AssignRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assignRequestDescriptor = $convert.base64Decode(
    'Cg1Bc3NpZ25SZXF1ZXN0EhsKCXRpY2tldF9pZBgBIAEoCVIIdGlja2V0SWQSFAoFYWdlbnQYAi'
    'ABKAlSBWFnZW50');

@$core.Deprecated('Use assignResultDescriptor instead')
const AssignResult$json = {
  '1': 'AssignResult',
  '2': [
    {'1': 'ticket', '3': 1, '4': 1, '5': 9, '10': 'ticket'},
    {
      '1': 'assignee',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.config.support.Account',
      '10': 'assignee'
    },
    {'1': 'changed', '3': 3, '4': 1, '5': 8, '10': 'changed'},
  ],
};

/// Descriptor for `AssignResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assignResultDescriptor = $convert.base64Decode(
    'CgxBc3NpZ25SZXN1bHQSFgoGdGlja2V0GAEgASgJUgZ0aWNrZXQSMwoIYXNzaWduZWUYAiABKA'
    'syFy5jb25maWcuc3VwcG9ydC5BY2NvdW50Ughhc3NpZ25lZRIYCgdjaGFuZ2VkGAMgASgIUgdj'
    'aGFuZ2Vk');

@$core.Deprecated('Use attachmentDescriptor instead')
const Attachment$json = {
  '1': 'Attachment',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
    {'1': 'content_type', '3': 4, '4': 1, '5': 9, '10': 'contentType'},
    {'1': 'size', '3': 5, '4': 1, '5': 5, '10': 'size'},
  ],
};

/// Descriptor for `Attachment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List attachmentDescriptor = $convert.base64Decode(
    'CgpBdHRhY2htZW50Eg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhAKA3VybB'
    'gDIAEoCVIDdXJsEiEKDGNvbnRlbnRfdHlwZRgEIAEoCVILY29udGVudFR5cGUSEgoEc2l6ZRgF'
    'IAEoBVIEc2l6ZQ==');

@$core.Deprecated('Use attachmentResponseDescriptor instead')
const AttachmentResponse$json = {
  '1': 'AttachmentResponse',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
    {'1': 'content_type', '3': 4, '4': 1, '5': 9, '10': 'contentType'},
    {'1': 'size', '3': 5, '4': 1, '5': 5, '10': 'size'},
  ],
};

/// Descriptor for `AttachmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List attachmentResponseDescriptor = $convert.base64Decode(
    'ChJBdHRhY2htZW50UmVzcG9uc2USDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbW'
    'USEAoDdXJsGAMgASgJUgN1cmwSIQoMY29udGVudF90eXBlGAQgASgJUgtjb250ZW50VHlwZRIS'
    'CgRzaXplGAUgASgFUgRzaXpl');

@$core.Deprecated('Use cannedListDescriptor instead')
const CannedList$json = {
  '1': 'CannedList',
  '2': [
    {
      '1': 'replies',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.support.CannedReply',
      '10': 'replies'
    },
  ],
};

/// Descriptor for `CannedList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cannedListDescriptor = $convert.base64Decode(
    'CgpDYW5uZWRMaXN0EjUKB3JlcGxpZXMYASADKAsyGy5jb25maWcuc3VwcG9ydC5DYW5uZWRSZX'
    'BseVIHcmVwbGllcw==');

@$core.Deprecated('Use cannedReplyDescriptor instead')
const CannedReply$json = {
  '1': 'CannedReply',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'body', '3': 3, '4': 1, '5': 9, '10': 'body'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `CannedReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cannedReplyDescriptor = $convert.base64Decode(
    'CgtDYW5uZWRSZXBseRIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEhIKBG'
    'JvZHkYAyABKAlSBGJvZHkSGgoIY2F0ZWdvcnkYBCABKAlSCGNhdGVnb3J5');

@$core.Deprecated('Use cannedRequestDescriptor instead')
const CannedRequest$json = {
  '1': 'CannedRequest',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `CannedRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cannedRequestDescriptor = $convert.base64Decode(
    'Cg1DYW5uZWRSZXF1ZXN0EhoKCGNhdGVnb3J5GAEgASgJUghjYXRlZ29yeQ==');

@$core.Deprecated('Use categoryDescriptor instead')
const Category$json = {
  '1': 'Category',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'slug', '3': 3, '4': 1, '5': 9, '10': 'slug'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'default_priority', '3': 5, '4': 1, '5': 9, '10': 'defaultPriority'},
    {
      '1': 'first_response_minutes',
      '3': 6,
      '4': 1,
      '5': 5,
      '10': 'firstResponseMinutes'
    },
    {
      '1': 'resolution_minutes',
      '3': 7,
      '4': 1,
      '5': 5,
      '10': 'resolutionMinutes'
    },
  ],
};

/// Descriptor for `Category`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryDescriptor = $convert.base64Decode(
    'CghDYXRlZ29yeRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRISCgRzbHVnGA'
    'MgASgJUgRzbHVnEiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIpChBkZWZhdWx0'
    'X3ByaW9yaXR5GAUgASgJUg9kZWZhdWx0UHJpb3JpdHkSNAoWZmlyc3RfcmVzcG9uc2VfbWludX'
    'RlcxgGIAEoBVIUZmlyc3RSZXNwb25zZU1pbnV0ZXMSLQoScmVzb2x1dGlvbl9taW51dGVzGAcg'
    'ASgFUhFyZXNvbHV0aW9uTWludXRlcw==');

@$core.Deprecated('Use categoryListDescriptor instead')
const CategoryList$json = {
  '1': 'CategoryList',
  '2': [
    {
      '1': 'categories',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.support.Category',
      '10': 'categories'
    },
  ],
};

/// Descriptor for `CategoryList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryListDescriptor = $convert.base64Decode(
    'CgxDYXRlZ29yeUxpc3QSOAoKY2F0ZWdvcmllcxgBIAMoCzIYLmNvbmZpZy5zdXBwb3J0LkNhdG'
    'Vnb3J5UgpjYXRlZ29yaWVz');

@$core.Deprecated('Use categoryRefDescriptor instead')
const CategoryRef$json = {
  '1': 'CategoryRef',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'slug', '3': 3, '4': 1, '5': 9, '10': 'slug'},
  ],
};

/// Descriptor for `CategoryRef`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryRefDescriptor = $convert.base64Decode(
    'CgtDYXRlZ29yeVJlZhIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRISCgRzbH'
    'VnGAMgASgJUgRzbHVn');

@$core.Deprecated('Use categoryRefResponseDescriptor instead')
const CategoryRefResponse$json = {
  '1': 'CategoryRefResponse',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'slug', '3': 3, '4': 1, '5': 9, '10': 'slug'},
  ],
};

/// Descriptor for `CategoryRefResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryRefResponseDescriptor = $convert.base64Decode(
    'ChNDYXRlZ29yeVJlZlJlc3BvbnNlEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW'
    '1lEhIKBHNsdWcYAyABKAlSBHNsdWc=');

@$core.Deprecated('Use channelDescriptor instead')
const Channel$json = {
  '1': 'Channel',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'kind', '3': 3, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'subject', '3': 4, '4': 1, '5': 9, '10': 'subject'},
    {'1': 'slug', '3': 5, '4': 1, '5': 9, '10': 'slug'},
    {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    {'1': 'priority', '3': 7, '4': 1, '5': 9, '10': 'priority'},
    {
      '1': 'client',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.config.support.Account',
      '10': 'client'
    },
    {
      '1': 'assignee',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.config.support.Account',
      '10': 'assignee'
    },
    {
      '1': 'category',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.config.support.CategoryRef',
      '10': 'category'
    },
    {'1': 'tags', '3': 11, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'data_json', '3': 12, '4': 1, '5': 9, '10': 'dataJson'},
    {'1': 'created_at', '3': 13, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 14, '4': 1, '5': 9, '10': 'updatedAt'},
    {'1': 'last_message_at', '3': 15, '4': 1, '5': 9, '10': 'lastMessageAt'},
    {'1': 'resolved_at', '3': 16, '4': 1, '5': 9, '10': 'resolvedAt'},
    {'1': 'closed_at', '3': 17, '4': 1, '5': 9, '10': 'closedAt'},
    {'1': 'rating', '3': 18, '4': 1, '5': 5, '10': 'rating'},
    {'1': 'rating_comment', '3': 19, '4': 1, '5': 9, '10': 'ratingComment'},
    {
      '1': 'sla',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.config.support.Sla',
      '10': 'sla'
    },
    {'1': 'unread', '3': 21, '4': 1, '5': 5, '10': 'unread'},
    {
      '1': 'participants',
      '3': 22,
      '4': 3,
      '5': 11,
      '6': '.config.support.Participant',
      '10': 'participants'
    },
    {'1': 'joined', '3': 23, '4': 1, '5': 8, '10': 'joined'},
    {'1': 'members', '3': 24, '4': 1, '5': 5, '10': 'members'},
  ],
};

/// Descriptor for `Channel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelDescriptor = $convert.base64Decode(
    'CgdDaGFubmVsEg4KAmlkGAEgASgJUgJpZBIcCglyZWZlcmVuY2UYAiABKAlSCXJlZmVyZW5jZR'
    'ISCgRraW5kGAMgASgJUgRraW5kEhgKB3N1YmplY3QYBCABKAlSB3N1YmplY3QSEgoEc2x1ZxgF'
    'IAEoCVIEc2x1ZxIWCgZzdGF0dXMYBiABKAlSBnN0YXR1cxIaCghwcmlvcml0eRgHIAEoCVIIcH'
    'Jpb3JpdHkSLwoGY2xpZW50GAggASgLMhcuY29uZmlnLnN1cHBvcnQuQWNjb3VudFIGY2xpZW50'
    'EjMKCGFzc2lnbmVlGAkgASgLMhcuY29uZmlnLnN1cHBvcnQuQWNjb3VudFIIYXNzaWduZWUSNw'
    'oIY2F0ZWdvcnkYCiABKAsyGy5jb25maWcuc3VwcG9ydC5DYXRlZ29yeVJlZlIIY2F0ZWdvcnkS'
    'EgoEdGFncxgLIAMoCVIEdGFncxIbCglkYXRhX2pzb24YDCABKAlSCGRhdGFKc29uEh0KCmNyZW'
    'F0ZWRfYXQYDSABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GA4gASgJUgl1cGRhdGVkQXQS'
    'JgoPbGFzdF9tZXNzYWdlX2F0GA8gASgJUg1sYXN0TWVzc2FnZUF0Eh8KC3Jlc29sdmVkX2F0GB'
    'AgASgJUgpyZXNvbHZlZEF0EhsKCWNsb3NlZF9hdBgRIAEoCVIIY2xvc2VkQXQSFgoGcmF0aW5n'
    'GBIgASgFUgZyYXRpbmcSJQoOcmF0aW5nX2NvbW1lbnQYEyABKAlSDXJhdGluZ0NvbW1lbnQSJQ'
    'oDc2xhGBQgASgLMhMuY29uZmlnLnN1cHBvcnQuU2xhUgNzbGESFgoGdW5yZWFkGBUgASgFUgZ1'
    'bnJlYWQSPwoMcGFydGljaXBhbnRzGBYgAygLMhsuY29uZmlnLnN1cHBvcnQuUGFydGljaXBhbn'
    'RSDHBhcnRpY2lwYW50cxIWCgZqb2luZWQYFyABKAhSBmpvaW5lZBIYCgdtZW1iZXJzGBggASgF'
    'UgdtZW1iZXJz');

@$core.Deprecated('Use channelListDescriptor instead')
const ChannelList$json = {
  '1': 'ChannelList',
  '2': [
    {
      '1': 'channels',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.support.Channel',
      '10': 'channels'
    },
  ],
};

/// Descriptor for `ChannelList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelListDescriptor = $convert.base64Decode(
    'CgtDaGFubmVsTGlzdBIzCghjaGFubmVscxgBIAMoCzIXLmNvbmZpZy5zdXBwb3J0LkNoYW5uZW'
    'xSCGNoYW5uZWxz');

@$core.Deprecated('Use channelsRequestDescriptor instead')
const ChannelsRequest$json = {
  '1': 'ChannelsRequest',
  '2': [
    {'1': 'search', '3': 1, '4': 1, '5': 9, '10': 'search'},
  ],
};

/// Descriptor for `ChannelsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelsRequestDescriptor = $convert
    .base64Decode('Cg9DaGFubmVsc1JlcXVlc3QSFgoGc2VhcmNoGAEgASgJUgZzZWFyY2g=');

@$core.Deprecated('Use claimRequestDescriptor instead')
const ClaimRequest$json = {
  '1': 'ClaimRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
  ],
};

/// Descriptor for `ClaimRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List claimRequestDescriptor = $convert.base64Decode(
    'CgxDbGFpbVJlcXVlc3QSGwoJdGlja2V0X2lkGAEgASgJUgh0aWNrZXRJZA==');

@$core.Deprecated('Use claimResultDescriptor instead')
const ClaimResult$json = {
  '1': 'ClaimResult',
  '2': [
    {'1': 'ticket', '3': 1, '4': 1, '5': 9, '10': 'ticket'},
    {
      '1': 'assignee',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.config.support.Account',
      '10': 'assignee'
    },
    {'1': 'changed', '3': 3, '4': 1, '5': 8, '10': 'changed'},
  ],
};

/// Descriptor for `ClaimResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List claimResultDescriptor = $convert.base64Decode(
    'CgtDbGFpbVJlc3VsdBIWCgZ0aWNrZXQYASABKAlSBnRpY2tldBIzCghhc3NpZ25lZRgCIAEoCz'
    'IXLmNvbmZpZy5zdXBwb3J0LkFjY291bnRSCGFzc2lnbmVlEhgKB2NoYW5nZWQYAyABKAhSB2No'
    'YW5nZWQ=');

@$core.Deprecated('Use countRequestDescriptor instead')
const CountRequest$json = {
  '1': 'CountRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'kind', '3': 2, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'priority', '3': 3, '4': 1, '5': 9, '10': 'priority'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    {'1': 'assignee', '3': 5, '4': 1, '5': 9, '10': 'assignee'},
    {'1': 'mine', '3': 6, '4': 1, '5': 8, '10': 'mine'},
    {'1': 'unassigned', '3': 7, '4': 1, '5': 8, '10': 'unassigned'},
    {'1': 'live', '3': 8, '4': 1, '5': 8, '9': 0, '10': 'live', '17': true},
    {'1': 'search', '3': 9, '4': 1, '5': 9, '10': 'search'},
  ],
  '8': [
    {'1': '_live'},
  ],
};

/// Descriptor for `CountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countRequestDescriptor = $convert.base64Decode(
    'CgxDb3VudFJlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSEgoEa2luZBgCIAEoCVIEa2'
    'luZBIaCghwcmlvcml0eRgDIAEoCVIIcHJpb3JpdHkSGgoIY2F0ZWdvcnkYBCABKAlSCGNhdGVn'
    'b3J5EhoKCGFzc2lnbmVlGAUgASgJUghhc3NpZ25lZRISCgRtaW5lGAYgASgIUgRtaW5lEh4KCn'
    'VuYXNzaWduZWQYByABKAhSCnVuYXNzaWduZWQSFwoEbGl2ZRgIIAEoCEgAUgRsaXZliAEBEhYK'
    'BnNlYXJjaBgJIAEoCVIGc2VhcmNoQgcKBV9saXZl');

@$core.Deprecated('Use countResultDescriptor instead')
const CountResult$json = {
  '1': 'CountResult',
  '2': [
    {'1': 'count', '3': 1, '4': 1, '5': 5, '10': 'count'},
  ],
};

/// Descriptor for `CountResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countResultDescriptor =
    $convert.base64Decode('CgtDb3VudFJlc3VsdBIUCgVjb3VudBgBIAEoBVIFY291bnQ=');

@$core.Deprecated('Use createChannelRequestDescriptor instead')
const CreateChannelRequest$json = {
  '1': 'CreateChannelRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'slug', '3': 2, '4': 1, '5': 9, '10': 'slug'},
    {'1': 'body', '3': 3, '4': 1, '5': 9, '10': 'body'},
  ],
};

/// Descriptor for `CreateChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createChannelRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVDaGFubmVsUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEhIKBHNsdWcYAiABKA'
    'lSBHNsdWcSEgoEYm9keRgDIAEoCVIEYm9keQ==');

@$core.Deprecated('Use createGroupRequestDescriptor instead')
const CreateGroupRequest$json = {
  '1': 'CreateGroupRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'members', '3': 2, '4': 3, '5': 9, '10': 'members'},
    {'1': 'body', '3': 3, '4': 1, '5': 9, '10': 'body'},
  ],
};

/// Descriptor for `CreateGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createGroupRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVHcm91cFJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRIYCgdtZW1iZXJzGAIgAy'
    'gJUgdtZW1iZXJzEhIKBGJvZHkYAyABKAlSBGJvZHk=');

@$core.Deprecated('Use deleteRequestDescriptor instead')
const DeleteRequest$json = {
  '1': 'DeleteRequest',
  '2': [
    {'1': 'message_id', '3': 1, '4': 1, '5': 9, '10': 'messageId'},
  ],
};

/// Descriptor for `DeleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteRequestDescriptor = $convert.base64Decode(
    'Cg1EZWxldGVSZXF1ZXN0Eh0KCm1lc3NhZ2VfaWQYASABKAlSCW1lc3NhZ2VJZA==');

@$core.Deprecated('Use deletedMessageDescriptor instead')
const DeletedMessage$json = {
  '1': 'DeletedMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'ticket', '3': 2, '4': 1, '5': 9, '10': 'ticket'},
    {
      '1': 'author',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.config.support.AccountResponse',
      '10': 'author'
    },
    {'1': 'kind', '3': 4, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'visibility', '3': 5, '4': 1, '5': 9, '10': 'visibility'},
    {'1': 'body', '3': 6, '4': 1, '5': 9, '10': 'body'},
    {'1': 'data_json', '3': 7, '4': 1, '5': 9, '10': 'dataJson'},
    {
      '1': 'attachments',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.config.support.AttachmentResponse',
      '10': 'attachments'
    },
    {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'edited_at', '3': 10, '4': 1, '5': 9, '10': 'editedAt'},
    {'1': 'deleted', '3': 11, '4': 1, '5': 8, '10': 'deleted'},
  ],
};

/// Descriptor for `DeletedMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deletedMessageDescriptor = $convert.base64Decode(
    'Cg5EZWxldGVkTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSFgoGdGlja2V0GAIgASgJUgZ0aWNrZX'
    'QSNwoGYXV0aG9yGAMgASgLMh8uY29uZmlnLnN1cHBvcnQuQWNjb3VudFJlc3BvbnNlUgZhdXRo'
    'b3ISEgoEa2luZBgEIAEoCVIEa2luZBIeCgp2aXNpYmlsaXR5GAUgASgJUgp2aXNpYmlsaXR5Eh'
    'IKBGJvZHkYBiABKAlSBGJvZHkSGwoJZGF0YV9qc29uGAcgASgJUghkYXRhSnNvbhJECgthdHRh'
    'Y2htZW50cxgIIAMoCzIiLmNvbmZpZy5zdXBwb3J0LkF0dGFjaG1lbnRSZXNwb25zZVILYXR0YW'
    'NobWVudHMSHQoKY3JlYXRlZF9hdBgJIAEoCVIJY3JlYXRlZEF0EhsKCWVkaXRlZF9hdBgKIAEo'
    'CVIIZWRpdGVkQXQSGAoHZGVsZXRlZBgLIAEoCFIHZGVsZXRlZA==');

@$core.Deprecated('Use directRequestDescriptor instead')
const DirectRequest$json = {
  '1': 'DirectRequest',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 9, '10': 'account'},
  ],
};

/// Descriptor for `DirectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List directRequestDescriptor = $convert
    .base64Decode('Cg1EaXJlY3RSZXF1ZXN0EhgKB2FjY291bnQYASABKAlSB2FjY291bnQ=');

@$core.Deprecated('Use editRequestDescriptor instead')
const EditRequest$json = {
  '1': 'EditRequest',
  '2': [
    {'1': 'message_id', '3': 1, '4': 1, '5': 9, '10': 'messageId'},
    {'1': 'body', '3': 2, '4': 1, '5': 9, '10': 'body'},
  ],
};

/// Descriptor for `EditRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List editRequestDescriptor = $convert.base64Decode(
    'CgtFZGl0UmVxdWVzdBIdCgptZXNzYWdlX2lkGAEgASgJUgltZXNzYWdlSWQSEgoEYm9keRgCIA'
    'EoCVIEYm9keQ==');

@$core.Deprecated('Use editedMessageDescriptor instead')
const EditedMessage$json = {
  '1': 'EditedMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'ticket', '3': 2, '4': 1, '5': 9, '10': 'ticket'},
    {
      '1': 'author',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.config.support.AccountResponse',
      '10': 'author'
    },
    {'1': 'kind', '3': 4, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'visibility', '3': 5, '4': 1, '5': 9, '10': 'visibility'},
    {'1': 'body', '3': 6, '4': 1, '5': 9, '10': 'body'},
    {'1': 'data_json', '3': 7, '4': 1, '5': 9, '10': 'dataJson'},
    {
      '1': 'attachments',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.config.support.AttachmentResponse',
      '10': 'attachments'
    },
    {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'edited_at', '3': 10, '4': 1, '5': 9, '10': 'editedAt'},
    {'1': 'deleted', '3': 11, '4': 1, '5': 8, '10': 'deleted'},
  ],
};

/// Descriptor for `EditedMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List editedMessageDescriptor = $convert.base64Decode(
    'Cg1FZGl0ZWRNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIWCgZ0aWNrZXQYAiABKAlSBnRpY2tldB'
    'I3CgZhdXRob3IYAyABKAsyHy5jb25maWcuc3VwcG9ydC5BY2NvdW50UmVzcG9uc2VSBmF1dGhv'
    'chISCgRraW5kGAQgASgJUgRraW5kEh4KCnZpc2liaWxpdHkYBSABKAlSCnZpc2liaWxpdHkSEg'
    'oEYm9keRgGIAEoCVIEYm9keRIbCglkYXRhX2pzb24YByABKAlSCGRhdGFKc29uEkQKC2F0dGFj'
    'aG1lbnRzGAggAygLMiIuY29uZmlnLnN1cHBvcnQuQXR0YWNobWVudFJlc3BvbnNlUgthdHRhY2'
    'htZW50cxIdCgpjcmVhdGVkX2F0GAkgASgJUgljcmVhdGVkQXQSGwoJZWRpdGVkX2F0GAogASgJ'
    'UghlZGl0ZWRBdBIYCgdkZWxldGVkGAsgASgIUgdkZWxldGVk');

@$core.Deprecated('Use getRequestDescriptor instead')
const GetRequest$json = {
  '1': 'GetRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
  ],
};

/// Descriptor for `GetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRequestDescriptor = $convert
    .base64Decode('CgpHZXRSZXF1ZXN0EhsKCXRpY2tldF9pZBgBIAEoCVIIdGlja2V0SWQ=');

@$core.Deprecated('Use inviteRequestDescriptor instead')
const InviteRequest$json = {
  '1': 'InviteRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'account', '3': 2, '4': 1, '5': 9, '10': 'account'},
    {'1': 'role', '3': 3, '4': 1, '5': 9, '10': 'role'},
  ],
};

/// Descriptor for `InviteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inviteRequestDescriptor = $convert.base64Decode(
    'Cg1JbnZpdGVSZXF1ZXN0EhsKCXRpY2tldF9pZBgBIAEoCVIIdGlja2V0SWQSGAoHYWNjb3VudB'
    'gCIAEoCVIHYWNjb3VudBISCgRyb2xlGAMgASgJUgRyb2xl');

@$core.Deprecated('Use invitedParticipantDescriptor instead')
const InvitedParticipant$json = {
  '1': 'InvitedParticipant',
  '2': [
    {
      '1': 'user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.config.support.AccountResponse',
      '10': 'user'
    },
    {'1': 'role', '3': 2, '4': 1, '5': 9, '10': 'role'},
    {'1': 'joined_at', '3': 3, '4': 1, '5': 9, '10': 'joinedAt'},
    {'1': 'last_read_at', '3': 4, '4': 1, '5': 9, '10': 'lastReadAt'},
    {'1': 'notify', '3': 5, '4': 1, '5': 8, '10': 'notify'},
  ],
};

/// Descriptor for `InvitedParticipant`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invitedParticipantDescriptor = $convert.base64Decode(
    'ChJJbnZpdGVkUGFydGljaXBhbnQSMwoEdXNlchgBIAEoCzIfLmNvbmZpZy5zdXBwb3J0LkFjY2'
    '91bnRSZXNwb25zZVIEdXNlchISCgRyb2xlGAIgASgJUgRyb2xlEhsKCWpvaW5lZF9hdBgDIAEo'
    'CVIIam9pbmVkQXQSIAoMbGFzdF9yZWFkX2F0GAQgASgJUgpsYXN0UmVhZEF0EhYKBm5vdGlmeR'
    'gFIAEoCFIGbm90aWZ5');

@$core.Deprecated('Use joinRequestDescriptor instead')
const JoinRequest$json = {
  '1': 'JoinRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
  ],
};

/// Descriptor for `JoinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinRequestDescriptor = $convert
    .base64Decode('CgtKb2luUmVxdWVzdBIbCgl0aWNrZXRfaWQYASABKAlSCHRpY2tldElk');

@$core.Deprecated('Use joinedParticipantDescriptor instead')
const JoinedParticipant$json = {
  '1': 'JoinedParticipant',
  '2': [
    {
      '1': 'user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.config.support.AccountResponse',
      '10': 'user'
    },
    {'1': 'role', '3': 2, '4': 1, '5': 9, '10': 'role'},
    {'1': 'joined_at', '3': 3, '4': 1, '5': 9, '10': 'joinedAt'},
    {'1': 'last_read_at', '3': 4, '4': 1, '5': 9, '10': 'lastReadAt'},
    {'1': 'notify', '3': 5, '4': 1, '5': 8, '10': 'notify'},
  ],
};

/// Descriptor for `JoinedParticipant`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinedParticipantDescriptor = $convert.base64Decode(
    'ChFKb2luZWRQYXJ0aWNpcGFudBIzCgR1c2VyGAEgASgLMh8uY29uZmlnLnN1cHBvcnQuQWNjb3'
    'VudFJlc3BvbnNlUgR1c2VyEhIKBHJvbGUYAiABKAlSBHJvbGUSGwoJam9pbmVkX2F0GAMgASgJ'
    'Ughqb2luZWRBdBIgCgxsYXN0X3JlYWRfYXQYBCABKAlSCmxhc3RSZWFkQXQSFgoGbm90aWZ5GA'
    'UgASgIUgZub3RpZnk=');

@$core.Deprecated('Use leaveRequestDescriptor instead')
const LeaveRequest$json = {
  '1': 'LeaveRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
  ],
};

/// Descriptor for `LeaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaveRequestDescriptor = $convert.base64Decode(
    'CgxMZWF2ZVJlcXVlc3QSGwoJdGlja2V0X2lkGAEgASgJUgh0aWNrZXRJZA==');

@$core.Deprecated('Use leaveResultDescriptor instead')
const LeaveResult$json = {
  '1': 'LeaveResult',
  '2': [
    {'1': 'ticket', '3': 1, '4': 1, '5': 9, '10': 'ticket'},
    {'1': 'left', '3': 2, '4': 1, '5': 8, '10': 'left'},
  ],
};

/// Descriptor for `LeaveResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaveResultDescriptor = $convert.base64Decode(
    'CgtMZWF2ZVJlc3VsdBIWCgZ0aWNrZXQYASABKAlSBnRpY2tldBISCgRsZWZ0GAIgASgIUgRsZW'
    'Z0');

@$core.Deprecated('Use listRequestDescriptor instead')
const ListRequest$json = {
  '1': 'ListRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'kind', '3': 2, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'priority', '3': 3, '4': 1, '5': 9, '10': 'priority'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    {'1': 'assignee', '3': 5, '4': 1, '5': 9, '10': 'assignee'},
    {'1': 'mine', '3': 6, '4': 1, '5': 8, '10': 'mine'},
    {'1': 'unassigned', '3': 7, '4': 1, '5': 8, '10': 'unassigned'},
    {'1': 'live', '3': 8, '4': 1, '5': 8, '9': 0, '10': 'live', '17': true},
    {'1': 'search', '3': 9, '4': 1, '5': 9, '10': 'search'},
    {
      '1': 'breached',
      '3': 10,
      '4': 1,
      '5': 8,
      '9': 1,
      '10': 'breached',
      '17': true
    },
    {'1': 'limit', '3': 11, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 12, '4': 1, '5': 5, '10': 'offset'},
  ],
  '8': [
    {'1': '_live'},
    {'1': '_breached'},
  ],
};

/// Descriptor for `ListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRequestDescriptor = $convert.base64Decode(
    'CgtMaXN0UmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxISCgRraW5kGAIgASgJUgRraW'
    '5kEhoKCHByaW9yaXR5GAMgASgJUghwcmlvcml0eRIaCghjYXRlZ29yeRgEIAEoCVIIY2F0ZWdv'
    'cnkSGgoIYXNzaWduZWUYBSABKAlSCGFzc2lnbmVlEhIKBG1pbmUYBiABKAhSBG1pbmUSHgoKdW'
    '5hc3NpZ25lZBgHIAEoCFIKdW5hc3NpZ25lZBIXCgRsaXZlGAggASgISABSBGxpdmWIAQESFgoG'
    'c2VhcmNoGAkgASgJUgZzZWFyY2gSHwoIYnJlYWNoZWQYCiABKAhIAVIIYnJlYWNoZWSIAQESFA'
    'oFbGltaXQYCyABKAVSBWxpbWl0EhYKBm9mZnNldBgMIAEoBVIGb2Zmc2V0QgcKBV9saXZlQgsK'
    'CV9icmVhY2hlZA==');

@$core.Deprecated('Use messageDescriptor instead')
const Message$json = {
  '1': 'Message',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'ticket', '3': 2, '4': 1, '5': 9, '10': 'ticket'},
    {
      '1': 'author',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.config.support.Account',
      '10': 'author'
    },
    {'1': 'kind', '3': 4, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'visibility', '3': 5, '4': 1, '5': 9, '10': 'visibility'},
    {'1': 'body', '3': 6, '4': 1, '5': 9, '10': 'body'},
    {'1': 'data_json', '3': 7, '4': 1, '5': 9, '10': 'dataJson'},
    {
      '1': 'attachments',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.config.support.Attachment',
      '10': 'attachments'
    },
    {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'edited_at', '3': 10, '4': 1, '5': 9, '10': 'editedAt'},
    {'1': 'deleted', '3': 11, '4': 1, '5': 8, '10': 'deleted'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode(
    'CgdNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIWCgZ0aWNrZXQYAiABKAlSBnRpY2tldBIvCgZhdX'
    'Rob3IYAyABKAsyFy5jb25maWcuc3VwcG9ydC5BY2NvdW50UgZhdXRob3ISEgoEa2luZBgEIAEo'
    'CVIEa2luZBIeCgp2aXNpYmlsaXR5GAUgASgJUgp2aXNpYmlsaXR5EhIKBGJvZHkYBiABKAlSBG'
    'JvZHkSGwoJZGF0YV9qc29uGAcgASgJUghkYXRhSnNvbhI8CgthdHRhY2htZW50cxgIIAMoCzIa'
    'LmNvbmZpZy5zdXBwb3J0LkF0dGFjaG1lbnRSC2F0dGFjaG1lbnRzEh0KCmNyZWF0ZWRfYXQYCS'
    'ABKAlSCWNyZWF0ZWRBdBIbCgllZGl0ZWRfYXQYCiABKAlSCGVkaXRlZEF0EhgKB2RlbGV0ZWQY'
    'CyABKAhSB2RlbGV0ZWQ=');

@$core.Deprecated('Use messageListDescriptor instead')
const MessageList$json = {
  '1': 'MessageList',
  '2': [
    {'1': 'ticket', '3': 1, '4': 1, '5': 9, '10': 'ticket'},
    {
      '1': 'messages',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.config.support.Message',
      '10': 'messages'
    },
    {'1': 'total', '3': 3, '4': 1, '5': 5, '10': 'total'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 5, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `MessageList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageListDescriptor = $convert.base64Decode(
    'CgtNZXNzYWdlTGlzdBIWCgZ0aWNrZXQYASABKAlSBnRpY2tldBIzCghtZXNzYWdlcxgCIAMoCz'
    'IXLmNvbmZpZy5zdXBwb3J0Lk1lc3NhZ2VSCG1lc3NhZ2VzEhQKBXRvdGFsGAMgASgFUgV0b3Rh'
    'bBIUCgVsaW1pdBgEIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAUgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use messagesRequestDescriptor instead')
const MessagesRequest$json = {
  '1': 'MessagesRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `MessagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messagesRequestDescriptor = $convert.base64Decode(
    'Cg9NZXNzYWdlc1JlcXVlc3QSGwoJdGlja2V0X2lkGAEgASgJUgh0aWNrZXRJZBIUCgVsaW1pdB'
    'gCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use openRequestDescriptor instead')
const OpenRequest$json = {
  '1': 'OpenRequest',
  '2': [
    {'1': 'subject', '3': 1, '4': 1, '5': 9, '10': 'subject'},
    {'1': 'body', '3': 2, '4': 1, '5': 9, '10': 'body'},
    {'1': 'kind', '3': 3, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    {'1': 'priority', '3': 5, '4': 1, '5': 9, '10': 'priority'},
    {'1': 'upload_ids', '3': 6, '4': 3, '5': 9, '10': 'uploadIds'},
    {'1': 'data_json', '3': 7, '4': 1, '5': 9, '10': 'dataJson'},
  ],
};

/// Descriptor for `OpenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openRequestDescriptor = $convert.base64Decode(
    'CgtPcGVuUmVxdWVzdBIYCgdzdWJqZWN0GAEgASgJUgdzdWJqZWN0EhIKBGJvZHkYAiABKAlSBG'
    'JvZHkSEgoEa2luZBgDIAEoCVIEa2luZBIaCghjYXRlZ29yeRgEIAEoCVIIY2F0ZWdvcnkSGgoI'
    'cHJpb3JpdHkYBSABKAlSCHByaW9yaXR5Eh0KCnVwbG9hZF9pZHMYBiADKAlSCXVwbG9hZElkcx'
    'IbCglkYXRhX2pzb24YByABKAlSCGRhdGFKc29u');

@$core.Deprecated('Use openedTicketDescriptor instead')
const OpenedTicket$json = {
  '1': 'OpenedTicket',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'kind', '3': 3, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'subject', '3': 4, '4': 1, '5': 9, '10': 'subject'},
    {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    {'1': 'priority', '3': 6, '4': 1, '5': 9, '10': 'priority'},
    {
      '1': 'client',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.config.support.AccountResponse',
      '10': 'client'
    },
    {
      '1': 'assignee',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.config.support.AccountResponse',
      '10': 'assignee'
    },
    {
      '1': 'category',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.config.support.CategoryRefResponse',
      '10': 'category'
    },
    {'1': 'tags', '3': 10, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'data_json', '3': 11, '4': 1, '5': 9, '10': 'dataJson'},
    {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 13, '4': 1, '5': 9, '10': 'updatedAt'},
    {'1': 'last_message_at', '3': 14, '4': 1, '5': 9, '10': 'lastMessageAt'},
    {'1': 'resolved_at', '3': 15, '4': 1, '5': 9, '10': 'resolvedAt'},
    {'1': 'closed_at', '3': 16, '4': 1, '5': 9, '10': 'closedAt'},
    {'1': 'rating', '3': 17, '4': 1, '5': 5, '10': 'rating'},
    {'1': 'rating_comment', '3': 18, '4': 1, '5': 9, '10': 'ratingComment'},
    {
      '1': 'sla',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.config.support.SlaResponse',
      '10': 'sla'
    },
    {'1': 'unread', '3': 20, '4': 1, '5': 5, '10': 'unread'},
    {
      '1': 'participants',
      '3': 21,
      '4': 3,
      '5': 11,
      '6': '.config.support.ParticipantResponse',
      '10': 'participants'
    },
    {'1': 'slug', '3': 22, '4': 1, '5': 9, '10': 'slug'},
  ],
};

/// Descriptor for `OpenedTicket`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openedTicketDescriptor = $convert.base64Decode(
    'CgxPcGVuZWRUaWNrZXQSDgoCaWQYASABKAlSAmlkEhwKCXJlZmVyZW5jZRgCIAEoCVIJcmVmZX'
    'JlbmNlEhIKBGtpbmQYAyABKAlSBGtpbmQSGAoHc3ViamVjdBgEIAEoCVIHc3ViamVjdBIWCgZz'
    'dGF0dXMYBSABKAlSBnN0YXR1cxIaCghwcmlvcml0eRgGIAEoCVIIcHJpb3JpdHkSNwoGY2xpZW'
    '50GAcgASgLMh8uY29uZmlnLnN1cHBvcnQuQWNjb3VudFJlc3BvbnNlUgZjbGllbnQSOwoIYXNz'
    'aWduZWUYCCABKAsyHy5jb25maWcuc3VwcG9ydC5BY2NvdW50UmVzcG9uc2VSCGFzc2lnbmVlEj'
    '8KCGNhdGVnb3J5GAkgASgLMiMuY29uZmlnLnN1cHBvcnQuQ2F0ZWdvcnlSZWZSZXNwb25zZVII'
    'Y2F0ZWdvcnkSEgoEdGFncxgKIAMoCVIEdGFncxIbCglkYXRhX2pzb24YCyABKAlSCGRhdGFKc2'
    '9uEh0KCmNyZWF0ZWRfYXQYDCABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GA0gASgJUgl1'
    'cGRhdGVkQXQSJgoPbGFzdF9tZXNzYWdlX2F0GA4gASgJUg1sYXN0TWVzc2FnZUF0Eh8KC3Jlc2'
    '9sdmVkX2F0GA8gASgJUgpyZXNvbHZlZEF0EhsKCWNsb3NlZF9hdBgQIAEoCVIIY2xvc2VkQXQS'
    'FgoGcmF0aW5nGBEgASgFUgZyYXRpbmcSJQoOcmF0aW5nX2NvbW1lbnQYEiABKAlSDXJhdGluZ0'
    'NvbW1lbnQSLQoDc2xhGBMgASgLMhsuY29uZmlnLnN1cHBvcnQuU2xhUmVzcG9uc2VSA3NsYRIW'
    'CgZ1bnJlYWQYFCABKAVSBnVucmVhZBJHCgxwYXJ0aWNpcGFudHMYFSADKAsyIy5jb25maWcuc3'
    'VwcG9ydC5QYXJ0aWNpcGFudFJlc3BvbnNlUgxwYXJ0aWNpcGFudHMSEgoEc2x1ZxgWIAEoCVIE'
    'c2x1Zw==');

@$core.Deprecated('Use participantDescriptor instead')
const Participant$json = {
  '1': 'Participant',
  '2': [
    {
      '1': 'user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.config.support.Account',
      '10': 'user'
    },
    {'1': 'role', '3': 2, '4': 1, '5': 9, '10': 'role'},
    {'1': 'joined_at', '3': 3, '4': 1, '5': 9, '10': 'joinedAt'},
    {'1': 'last_read_at', '3': 4, '4': 1, '5': 9, '10': 'lastReadAt'},
    {'1': 'notify', '3': 5, '4': 1, '5': 8, '10': 'notify'},
  ],
};

/// Descriptor for `Participant`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List participantDescriptor = $convert.base64Decode(
    'CgtQYXJ0aWNpcGFudBIrCgR1c2VyGAEgASgLMhcuY29uZmlnLnN1cHBvcnQuQWNjb3VudFIEdX'
    'NlchISCgRyb2xlGAIgASgJUgRyb2xlEhsKCWpvaW5lZF9hdBgDIAEoCVIIam9pbmVkQXQSIAoM'
    'bGFzdF9yZWFkX2F0GAQgASgJUgpsYXN0UmVhZEF0EhYKBm5vdGlmeRgFIAEoCFIGbm90aWZ5');

@$core.Deprecated('Use participantResponseDescriptor instead')
const ParticipantResponse$json = {
  '1': 'ParticipantResponse',
  '2': [
    {
      '1': 'user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.config.support.AccountResponse',
      '10': 'user'
    },
    {'1': 'role', '3': 2, '4': 1, '5': 9, '10': 'role'},
    {'1': 'joined_at', '3': 3, '4': 1, '5': 9, '10': 'joinedAt'},
    {'1': 'last_read_at', '3': 4, '4': 1, '5': 9, '10': 'lastReadAt'},
    {'1': 'notify', '3': 5, '4': 1, '5': 8, '10': 'notify'},
  ],
};

/// Descriptor for `ParticipantResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List participantResponseDescriptor = $convert.base64Decode(
    'ChNQYXJ0aWNpcGFudFJlc3BvbnNlEjMKBHVzZXIYASABKAsyHy5jb25maWcuc3VwcG9ydC5BY2'
    'NvdW50UmVzcG9uc2VSBHVzZXISEgoEcm9sZRgCIAEoCVIEcm9sZRIbCglqb2luZWRfYXQYAyAB'
    'KAlSCGpvaW5lZEF0EiAKDGxhc3RfcmVhZF9hdBgEIAEoCVIKbGFzdFJlYWRBdBIWCgZub3RpZn'
    'kYBSABKAhSBm5vdGlmeQ==');

@$core.Deprecated('Use priorityRequestDescriptor instead')
const PriorityRequest$json = {
  '1': 'PriorityRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'priority', '3': 2, '4': 1, '5': 9, '10': 'priority'},
  ],
};

/// Descriptor for `PriorityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List priorityRequestDescriptor = $convert.base64Decode(
    'Cg9Qcmlvcml0eVJlcXVlc3QSGwoJdGlja2V0X2lkGAEgASgJUgh0aWNrZXRJZBIaCghwcmlvcm'
    'l0eRgCIAEoCVIIcHJpb3JpdHk=');

@$core.Deprecated('Use priorityResultDescriptor instead')
const PriorityResult$json = {
  '1': 'PriorityResult',
  '2': [
    {'1': 'ticket', '3': 1, '4': 1, '5': 9, '10': 'ticket'},
    {'1': 'priority', '3': 2, '4': 1, '5': 9, '10': 'priority'},
    {'1': 'changed', '3': 3, '4': 1, '5': 8, '10': 'changed'},
  ],
};

/// Descriptor for `PriorityResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List priorityResultDescriptor = $convert.base64Decode(
    'Cg5Qcmlvcml0eVJlc3VsdBIWCgZ0aWNrZXQYASABKAlSBnRpY2tldBIaCghwcmlvcml0eRgCIA'
    'EoCVIIcHJpb3JpdHkSGAoHY2hhbmdlZBgDIAEoCFIHY2hhbmdlZA==');

@$core.Deprecated('Use rateRequestDescriptor instead')
const RateRequest$json = {
  '1': 'RateRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'score', '3': 2, '4': 1, '5': 5, '10': 'score'},
    {'1': 'comment', '3': 3, '4': 1, '5': 9, '10': 'comment'},
  ],
};

/// Descriptor for `RateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rateRequestDescriptor = $convert.base64Decode(
    'CgtSYXRlUmVxdWVzdBIbCgl0aWNrZXRfaWQYASABKAlSCHRpY2tldElkEhQKBXNjb3JlGAIgAS'
    'gFUgVzY29yZRIYCgdjb21tZW50GAMgASgJUgdjb21tZW50');

@$core.Deprecated('Use rateResultDescriptor instead')
const RateResult$json = {
  '1': 'RateResult',
  '2': [
    {'1': 'ticket', '3': 1, '4': 1, '5': 9, '10': 'ticket'},
    {'1': 'rating', '3': 2, '4': 1, '5': 5, '10': 'rating'},
    {'1': 'comment', '3': 3, '4': 1, '5': 9, '10': 'comment'},
  ],
};

/// Descriptor for `RateResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rateResultDescriptor = $convert.base64Decode(
    'CgpSYXRlUmVzdWx0EhYKBnRpY2tldBgBIAEoCVIGdGlja2V0EhYKBnJhdGluZxgCIAEoBVIGcm'
    'F0aW5nEhgKB2NvbW1lbnQYAyABKAlSB2NvbW1lbnQ=');

@$core.Deprecated('Use readRequestDescriptor instead')
const ReadRequest$json = {
  '1': 'ReadRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
  ],
};

/// Descriptor for `ReadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readRequestDescriptor = $convert
    .base64Decode('CgtSZWFkUmVxdWVzdBIbCgl0aWNrZXRfaWQYASABKAlSCHRpY2tldElk');

@$core.Deprecated('Use readResultDescriptor instead')
const ReadResult$json = {
  '1': 'ReadResult',
  '2': [
    {'1': 'ticket', '3': 1, '4': 1, '5': 9, '10': 'ticket'},
    {'1': 'changed', '3': 2, '4': 1, '5': 8, '10': 'changed'},
    {'1': 'unread', '3': 3, '4': 1, '5': 5, '10': 'unread'},
    {'1': 'last_read_at', '3': 4, '4': 1, '5': 9, '10': 'lastReadAt'},
  ],
};

/// Descriptor for `ReadResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readResultDescriptor = $convert.base64Decode(
    'CgpSZWFkUmVzdWx0EhYKBnRpY2tldBgBIAEoCVIGdGlja2V0EhgKB2NoYW5nZWQYAiABKAhSB2'
    'NoYW5nZWQSFgoGdW5yZWFkGAMgASgFUgZ1bnJlYWQSIAoMbGFzdF9yZWFkX2F0GAQgASgJUgps'
    'YXN0UmVhZEF0');

@$core.Deprecated('Use sendRequestDescriptor instead')
const SendRequest$json = {
  '1': 'SendRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'body', '3': 2, '4': 1, '5': 9, '10': 'body'},
    {'1': 'upload_ids', '3': 3, '4': 3, '5': 9, '10': 'uploadIds'},
    {'1': 'internal', '3': 4, '4': 1, '5': 8, '10': 'internal'},
    {'1': 'data_json', '3': 5, '4': 1, '5': 9, '10': 'dataJson'},
  ],
};

/// Descriptor for `SendRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendRequestDescriptor = $convert.base64Decode(
    'CgtTZW5kUmVxdWVzdBIbCgl0aWNrZXRfaWQYASABKAlSCHRpY2tldElkEhIKBGJvZHkYAiABKA'
    'lSBGJvZHkSHQoKdXBsb2FkX2lkcxgDIAMoCVIJdXBsb2FkSWRzEhoKCGludGVybmFsGAQgASgI'
    'UghpbnRlcm5hbBIbCglkYXRhX2pzb24YBSABKAlSCGRhdGFKc29u');

@$core.Deprecated('Use sentMessageDescriptor instead')
const SentMessage$json = {
  '1': 'SentMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'ticket', '3': 2, '4': 1, '5': 9, '10': 'ticket'},
    {
      '1': 'author',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.config.support.AccountResponse',
      '10': 'author'
    },
    {'1': 'kind', '3': 4, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'visibility', '3': 5, '4': 1, '5': 9, '10': 'visibility'},
    {'1': 'body', '3': 6, '4': 1, '5': 9, '10': 'body'},
    {'1': 'data_json', '3': 7, '4': 1, '5': 9, '10': 'dataJson'},
    {
      '1': 'attachments',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.config.support.AttachmentResponse',
      '10': 'attachments'
    },
    {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'edited_at', '3': 10, '4': 1, '5': 9, '10': 'editedAt'},
    {'1': 'deleted', '3': 11, '4': 1, '5': 8, '10': 'deleted'},
  ],
};

/// Descriptor for `SentMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sentMessageDescriptor = $convert.base64Decode(
    'CgtTZW50TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSFgoGdGlja2V0GAIgASgJUgZ0aWNrZXQSNw'
    'oGYXV0aG9yGAMgASgLMh8uY29uZmlnLnN1cHBvcnQuQWNjb3VudFJlc3BvbnNlUgZhdXRob3IS'
    'EgoEa2luZBgEIAEoCVIEa2luZBIeCgp2aXNpYmlsaXR5GAUgASgJUgp2aXNpYmlsaXR5EhIKBG'
    'JvZHkYBiABKAlSBGJvZHkSGwoJZGF0YV9qc29uGAcgASgJUghkYXRhSnNvbhJECgthdHRhY2ht'
    'ZW50cxgIIAMoCzIiLmNvbmZpZy5zdXBwb3J0LkF0dGFjaG1lbnRSZXNwb25zZVILYXR0YWNobW'
    'VudHMSHQoKY3JlYXRlZF9hdBgJIAEoCVIJY3JlYXRlZEF0EhsKCWVkaXRlZF9hdBgKIAEoCVII'
    'ZWRpdGVkQXQSGAoHZGVsZXRlZBgLIAEoCFIHZGVsZXRlZA==');

@$core.Deprecated('Use slaDescriptor instead')
const Sla$json = {
  '1': 'Sla',
  '2': [
    {
      '1': 'first_response_due_at',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'firstResponseDueAt'
    },
    {'1': 'resolution_due_at', '3': 2, '4': 1, '5': 9, '10': 'resolutionDueAt'},
    {'1': 'first_response_at', '3': 3, '4': 1, '5': 9, '10': 'firstResponseAt'},
    {
      '1': 'first_response_breached',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'firstResponseBreached'
    },
    {
      '1': 'resolution_breached',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'resolutionBreached'
    },
    {'1': 'breached', '3': 6, '4': 1, '5': 8, '10': 'breached'},
  ],
};

/// Descriptor for `Sla`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List slaDescriptor = $convert.base64Decode(
    'CgNTbGESMQoVZmlyc3RfcmVzcG9uc2VfZHVlX2F0GAEgASgJUhJmaXJzdFJlc3BvbnNlRHVlQX'
    'QSKgoRcmVzb2x1dGlvbl9kdWVfYXQYAiABKAlSD3Jlc29sdXRpb25EdWVBdBIqChFmaXJzdF9y'
    'ZXNwb25zZV9hdBgDIAEoCVIPZmlyc3RSZXNwb25zZUF0EjYKF2ZpcnN0X3Jlc3BvbnNlX2JyZW'
    'FjaGVkGAQgASgIUhVmaXJzdFJlc3BvbnNlQnJlYWNoZWQSLwoTcmVzb2x1dGlvbl9icmVhY2hl'
    'ZBgFIAEoCFIScmVzb2x1dGlvbkJyZWFjaGVkEhoKCGJyZWFjaGVkGAYgASgIUghicmVhY2hlZA'
    '==');

@$core.Deprecated('Use slaResponseDescriptor instead')
const SlaResponse$json = {
  '1': 'SlaResponse',
  '2': [
    {
      '1': 'first_response_due_at',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'firstResponseDueAt'
    },
    {'1': 'resolution_due_at', '3': 2, '4': 1, '5': 9, '10': 'resolutionDueAt'},
    {'1': 'first_response_at', '3': 3, '4': 1, '5': 9, '10': 'firstResponseAt'},
    {
      '1': 'first_response_breached',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'firstResponseBreached'
    },
    {
      '1': 'resolution_breached',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'resolutionBreached'
    },
    {'1': 'breached', '3': 6, '4': 1, '5': 8, '10': 'breached'},
  ],
};

/// Descriptor for `SlaResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List slaResponseDescriptor = $convert.base64Decode(
    'CgtTbGFSZXNwb25zZRIxChVmaXJzdF9yZXNwb25zZV9kdWVfYXQYASABKAlSEmZpcnN0UmVzcG'
    '9uc2VEdWVBdBIqChFyZXNvbHV0aW9uX2R1ZV9hdBgCIAEoCVIPcmVzb2x1dGlvbkR1ZUF0EioK'
    'EWZpcnN0X3Jlc3BvbnNlX2F0GAMgASgJUg9maXJzdFJlc3BvbnNlQXQSNgoXZmlyc3RfcmVzcG'
    '9uc2VfYnJlYWNoZWQYBCABKAhSFWZpcnN0UmVzcG9uc2VCcmVhY2hlZBIvChNyZXNvbHV0aW9u'
    'X2JyZWFjaGVkGAUgASgIUhJyZXNvbHV0aW9uQnJlYWNoZWQSGgoIYnJlYWNoZWQYBiABKAhSCG'
    'JyZWFjaGVk');

@$core.Deprecated('Use statsResultDescriptor instead')
const StatsResult$json = {
  '1': 'StatsResult',
  '2': [
    {'1': 'total', '3': 1, '4': 1, '5': 5, '10': 'total'},
    {'1': 'open', '3': 2, '4': 1, '5': 5, '10': 'open'},
    {'1': 'pending', '3': 3, '4': 1, '5': 5, '10': 'pending'},
    {'1': 'on_hold', '3': 4, '4': 1, '5': 5, '10': 'onHold'},
    {'1': 'resolved', '3': 5, '4': 1, '5': 5, '10': 'resolved'},
    {'1': 'closed', '3': 6, '4': 1, '5': 5, '10': 'closed'},
    {'1': 'unassigned', '3': 7, '4': 1, '5': 5, '10': 'unassigned'},
    {'1': 'chats', '3': 8, '4': 1, '5': 5, '10': 'chats'},
    {'1': 'rated', '3': 9, '4': 1, '5': 5, '10': 'rated'},
    {'1': 'breached', '3': 10, '4': 1, '5': 5, '10': 'breached'},
    {
      '1': 'awaiting_first_response',
      '3': 11,
      '4': 1,
      '5': 5,
      '10': 'awaitingFirstResponse'
    },
    {'1': 'satisfaction', '3': 12, '4': 1, '5': 2, '10': 'satisfaction'},
  ],
};

/// Descriptor for `StatsResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statsResultDescriptor = $convert.base64Decode(
    'CgtTdGF0c1Jlc3VsdBIUCgV0b3RhbBgBIAEoBVIFdG90YWwSEgoEb3BlbhgCIAEoBVIEb3Blbh'
    'IYCgdwZW5kaW5nGAMgASgFUgdwZW5kaW5nEhcKB29uX2hvbGQYBCABKAVSBm9uSG9sZBIaCghy'
    'ZXNvbHZlZBgFIAEoBVIIcmVzb2x2ZWQSFgoGY2xvc2VkGAYgASgFUgZjbG9zZWQSHgoKdW5hc3'
    'NpZ25lZBgHIAEoBVIKdW5hc3NpZ25lZBIUCgVjaGF0cxgIIAEoBVIFY2hhdHMSFAoFcmF0ZWQY'
    'CSABKAVSBXJhdGVkEhoKCGJyZWFjaGVkGAogASgFUghicmVhY2hlZBI2Chdhd2FpdGluZ19maX'
    'JzdF9yZXNwb25zZRgLIAEoBVIVYXdhaXRpbmdGaXJzdFJlc3BvbnNlEiIKDHNhdGlzZmFjdGlv'
    'bhgMIAEoAlIMc2F0aXNmYWN0aW9u');

@$core.Deprecated('Use statusRequestDescriptor instead')
const StatusRequest$json = {
  '1': 'StatusRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `StatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusRequestDescriptor = $convert.base64Decode(
    'Cg1TdGF0dXNSZXF1ZXN0EhsKCXRpY2tldF9pZBgBIAEoCVIIdGlja2V0SWQSFgoGc3RhdHVzGA'
    'IgASgJUgZzdGF0dXM=');

@$core.Deprecated('Use statusResultDescriptor instead')
const StatusResult$json = {
  '1': 'StatusResult',
  '2': [
    {'1': 'ticket', '3': 1, '4': 1, '5': 9, '10': 'ticket'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'changed', '3': 3, '4': 1, '5': 8, '10': 'changed'},
  ],
};

/// Descriptor for `StatusResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusResultDescriptor = $convert.base64Decode(
    'CgxTdGF0dXNSZXN1bHQSFgoGdGlja2V0GAEgASgJUgZ0aWNrZXQSFgoGc3RhdHVzGAIgASgJUg'
    'ZzdGF0dXMSGAoHY2hhbmdlZBgDIAEoCFIHY2hhbmdlZA==');

@$core.Deprecated('Use tagDescriptor instead')
const Tag$json = {
  '1': 'Tag',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'slug', '3': 3, '4': 1, '5': 9, '10': 'slug'},
    {'1': 'colour', '3': 4, '4': 1, '5': 9, '10': 'colour'},
  ],
};

/// Descriptor for `Tag`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagDescriptor = $convert.base64Decode(
    'CgNUYWcSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSEgoEc2x1ZxgDIAEoCV'
    'IEc2x1ZxIWCgZjb2xvdXIYBCABKAlSBmNvbG91cg==');

@$core.Deprecated('Use tagListDescriptor instead')
const TagList$json = {
  '1': 'TagList',
  '2': [
    {
      '1': 'tags',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.support.Tag',
      '10': 'tags'
    },
  ],
};

/// Descriptor for `TagList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagListDescriptor = $convert.base64Decode(
    'CgdUYWdMaXN0EicKBHRhZ3MYASADKAsyEy5jb25maWcuc3VwcG9ydC5UYWdSBHRhZ3M=');

@$core.Deprecated('Use tagRequestDescriptor instead')
const TagRequest$json = {
  '1': 'TagRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'tags', '3': 2, '4': 3, '5': 9, '10': 'tags'},
  ],
};

/// Descriptor for `TagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagRequestDescriptor = $convert.base64Decode(
    'CgpUYWdSZXF1ZXN0EhsKCXRpY2tldF9pZBgBIAEoCVIIdGlja2V0SWQSEgoEdGFncxgCIAMoCV'
    'IEdGFncw==');

@$core.Deprecated('Use tagResultDescriptor instead')
const TagResult$json = {
  '1': 'TagResult',
  '2': [
    {'1': 'ticket', '3': 1, '4': 1, '5': 9, '10': 'ticket'},
    {'1': 'tags', '3': 2, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'changed', '3': 3, '4': 1, '5': 8, '10': 'changed'},
  ],
};

/// Descriptor for `TagResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagResultDescriptor = $convert.base64Decode(
    'CglUYWdSZXN1bHQSFgoGdGlja2V0GAEgASgJUgZ0aWNrZXQSEgoEdGFncxgCIAMoCVIEdGFncx'
    'IYCgdjaGFuZ2VkGAMgASgIUgdjaGFuZ2Vk');

@$core.Deprecated('Use ticketDescriptor instead')
const Ticket$json = {
  '1': 'Ticket',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'kind', '3': 3, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'subject', '3': 4, '4': 1, '5': 9, '10': 'subject'},
    {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    {'1': 'priority', '3': 6, '4': 1, '5': 9, '10': 'priority'},
    {
      '1': 'client',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.config.support.AccountResponse',
      '10': 'client'
    },
    {
      '1': 'assignee',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.config.support.AccountResponse',
      '10': 'assignee'
    },
    {
      '1': 'category',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.config.support.CategoryRefResponse',
      '10': 'category'
    },
    {'1': 'tags', '3': 10, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'data_json', '3': 11, '4': 1, '5': 9, '10': 'dataJson'},
    {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 13, '4': 1, '5': 9, '10': 'updatedAt'},
    {'1': 'last_message_at', '3': 14, '4': 1, '5': 9, '10': 'lastMessageAt'},
    {'1': 'resolved_at', '3': 15, '4': 1, '5': 9, '10': 'resolvedAt'},
    {'1': 'closed_at', '3': 16, '4': 1, '5': 9, '10': 'closedAt'},
    {'1': 'rating', '3': 17, '4': 1, '5': 5, '10': 'rating'},
    {'1': 'rating_comment', '3': 18, '4': 1, '5': 9, '10': 'ratingComment'},
    {
      '1': 'sla',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.config.support.SlaResponse',
      '10': 'sla'
    },
    {'1': 'unread', '3': 20, '4': 1, '5': 5, '10': 'unread'},
    {
      '1': 'participants',
      '3': 21,
      '4': 3,
      '5': 11,
      '6': '.config.support.ParticipantResponse',
      '10': 'participants'
    },
    {'1': 'slug', '3': 22, '4': 1, '5': 9, '10': 'slug'},
  ],
};

/// Descriptor for `Ticket`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ticketDescriptor = $convert.base64Decode(
    'CgZUaWNrZXQSDgoCaWQYASABKAlSAmlkEhwKCXJlZmVyZW5jZRgCIAEoCVIJcmVmZXJlbmNlEh'
    'IKBGtpbmQYAyABKAlSBGtpbmQSGAoHc3ViamVjdBgEIAEoCVIHc3ViamVjdBIWCgZzdGF0dXMY'
    'BSABKAlSBnN0YXR1cxIaCghwcmlvcml0eRgGIAEoCVIIcHJpb3JpdHkSNwoGY2xpZW50GAcgAS'
    'gLMh8uY29uZmlnLnN1cHBvcnQuQWNjb3VudFJlc3BvbnNlUgZjbGllbnQSOwoIYXNzaWduZWUY'
    'CCABKAsyHy5jb25maWcuc3VwcG9ydC5BY2NvdW50UmVzcG9uc2VSCGFzc2lnbmVlEj8KCGNhdG'
    'Vnb3J5GAkgASgLMiMuY29uZmlnLnN1cHBvcnQuQ2F0ZWdvcnlSZWZSZXNwb25zZVIIY2F0ZWdv'
    'cnkSEgoEdGFncxgKIAMoCVIEdGFncxIbCglkYXRhX2pzb24YCyABKAlSCGRhdGFKc29uEh0KCm'
    'NyZWF0ZWRfYXQYDCABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GA0gASgJUgl1cGRhdGVk'
    'QXQSJgoPbGFzdF9tZXNzYWdlX2F0GA4gASgJUg1sYXN0TWVzc2FnZUF0Eh8KC3Jlc29sdmVkX2'
    'F0GA8gASgJUgpyZXNvbHZlZEF0EhsKCWNsb3NlZF9hdBgQIAEoCVIIY2xvc2VkQXQSFgoGcmF0'
    'aW5nGBEgASgFUgZyYXRpbmcSJQoOcmF0aW5nX2NvbW1lbnQYEiABKAlSDXJhdGluZ0NvbW1lbn'
    'QSLQoDc2xhGBMgASgLMhsuY29uZmlnLnN1cHBvcnQuU2xhUmVzcG9uc2VSA3NsYRIWCgZ1bnJl'
    'YWQYFCABKAVSBnVucmVhZBJHCgxwYXJ0aWNpcGFudHMYFSADKAsyIy5jb25maWcuc3VwcG9ydC'
    '5QYXJ0aWNpcGFudFJlc3BvbnNlUgxwYXJ0aWNpcGFudHMSEgoEc2x1ZxgWIAEoCVIEc2x1Zw==');

@$core.Deprecated('Use ticketListDescriptor instead')
const TicketList$json = {
  '1': 'TicketList',
  '2': [
    {
      '1': 'tickets',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.support.Ticket',
      '10': 'tickets'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `TicketList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ticketListDescriptor = $convert.base64Decode(
    'CgpUaWNrZXRMaXN0EjAKB3RpY2tldHMYASADKAsyFi5jb25maWcuc3VwcG9ydC5UaWNrZXRSB3'
    'RpY2tldHMSFAoFdG90YWwYAiABKAVSBXRvdGFsEhQKBWxpbWl0GAMgASgFUgVsaW1pdBIWCgZv'
    'ZmZzZXQYBCABKAVSBm9mZnNldA==');

@$core.Deprecated('Use typingRequestDescriptor instead')
const TypingRequest$json = {
  '1': 'TypingRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'typing', '3': 2, '4': 1, '5': 8, '10': 'typing'},
  ],
};

/// Descriptor for `TypingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List typingRequestDescriptor = $convert.base64Decode(
    'Cg1UeXBpbmdSZXF1ZXN0EhsKCXRpY2tldF9pZBgBIAEoCVIIdGlja2V0SWQSFgoGdHlwaW5nGA'
    'IgASgIUgZ0eXBpbmc=');

@$core.Deprecated('Use typingResultDescriptor instead')
const TypingResult$json = {
  '1': 'TypingResult',
  '2': [
    {'1': 'ticket', '3': 1, '4': 1, '5': 9, '10': 'ticket'},
    {'1': 'typing', '3': 2, '4': 1, '5': 8, '10': 'typing'},
  ],
};

/// Descriptor for `TypingResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List typingResultDescriptor = $convert.base64Decode(
    'CgxUeXBpbmdSZXN1bHQSFgoGdGlja2V0GAEgASgJUgZ0aWNrZXQSFgoGdHlwaW5nGAIgASgIUg'
    'Z0eXBpbmc=');

@$core.Deprecated('Use unreadResultDescriptor instead')
const UnreadResult$json = {
  '1': 'UnreadResult',
  '2': [
    {'1': 'messages', '3': 1, '4': 1, '5': 5, '10': 'messages'},
    {'1': 'tickets', '3': 2, '4': 1, '5': 5, '10': 'tickets'},
  ],
};

/// Descriptor for `UnreadResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unreadResultDescriptor = $convert.base64Decode(
    'CgxVbnJlYWRSZXN1bHQSGgoIbWVzc2FnZXMYASABKAVSCG1lc3NhZ2VzEhgKB3RpY2tldHMYAi'
    'ABKAVSB3RpY2tldHM=');

@$core.Deprecated('Use unreadTicketRequestDescriptor instead')
const UnreadTicketRequest$json = {
  '1': 'UnreadTicketRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
  ],
};

/// Descriptor for `UnreadTicketRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unreadTicketRequestDescriptor =
    $convert.base64Decode(
        'ChNVbnJlYWRUaWNrZXRSZXF1ZXN0EhsKCXRpY2tldF9pZBgBIAEoCVIIdGlja2V0SWQ=');

@$core.Deprecated('Use unreadTicketResultDescriptor instead')
const UnreadTicketResult$json = {
  '1': 'UnreadTicketResult',
  '2': [
    {'1': 'ticket', '3': 1, '4': 1, '5': 9, '10': 'ticket'},
    {'1': 'changed', '3': 2, '4': 1, '5': 8, '10': 'changed'},
    {'1': 'unread', '3': 3, '4': 1, '5': 5, '10': 'unread'},
    {'1': 'last_read_at', '3': 4, '4': 1, '5': 9, '10': 'lastReadAt'},
  ],
};

/// Descriptor for `UnreadTicketResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unreadTicketResultDescriptor = $convert.base64Decode(
    'ChJVbnJlYWRUaWNrZXRSZXN1bHQSFgoGdGlja2V0GAEgASgJUgZ0aWNrZXQSGAoHY2hhbmdlZB'
    'gCIAEoCFIHY2hhbmdlZBIWCgZ1bnJlYWQYAyABKAVSBnVucmVhZBIgCgxsYXN0X3JlYWRfYXQY'
    'BCABKAlSCmxhc3RSZWFkQXQ=');
