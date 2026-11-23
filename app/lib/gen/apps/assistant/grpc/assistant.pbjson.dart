// This is a generated file - do not edit.
//
// Generated from apps/assistant/grpc/assistant.proto.

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

@$core.Deprecated('Use cardDescriptor instead')
const Card$json = {
  '1': 'Card',
  '2': [
    {'1': 'kind', '3': 1, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'amount_minor', '3': 2, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'wallet_id', '3': 4, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'to_wallet_id', '3': 5, '4': 1, '5': 9, '10': 'toWalletId'},
    {'1': 'category_id', '3': 6, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'note', '3': 7, '4': 1, '5': 9, '10': 'note'},
    {'1': 'occurred_at', '3': 8, '4': 1, '5': 9, '10': 'occurredAt'},
  ],
};

/// Descriptor for `Card`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cardDescriptor = $convert.base64Decode(
    'CgRDYXJkEhIKBGtpbmQYASABKAlSBGtpbmQSIQoMYW1vdW50X21pbm9yGAIgASgDUgthbW91bn'
    'RNaW5vchIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSGwoJd2FsbGV0X2lkGAQgASgJUgh3'
    'YWxsZXRJZBIgCgx0b193YWxsZXRfaWQYBSABKAlSCnRvV2FsbGV0SWQSHwoLY2F0ZWdvcnlfaW'
    'QYBiABKAlSCmNhdGVnb3J5SWQSEgoEbm90ZRgHIAEoCVIEbm90ZRIfCgtvY2N1cnJlZF9hdBgI'
    'IAEoCVIKb2NjdXJyZWRBdA==');

@$core.Deprecated('Use cardLinkDescriptor instead')
const CardLink$json = {
  '1': 'CardLink',
  '2': [
    {'1': 'last4', '3': 1, '4': 1, '5': 9, '10': 'last4'},
    {'1': 'wallet_id', '3': 2, '4': 1, '5': 9, '10': 'walletId'},
  ],
};

/// Descriptor for `CardLink`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cardLinkDescriptor = $convert.base64Decode(
    'CghDYXJkTGluaxIUCgVsYXN0NBgBIAEoCVIFbGFzdDQSGwoJd2FsbGV0X2lkGAIgASgJUgh3YW'
    'xsZXRJZA==');

@$core.Deprecated('Use chatReplyDescriptor instead')
const ChatReply$json = {
  '1': 'ChatReply',
  '2': [
    {
      '1': 'messages',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.assistant.Message',
      '10': 'messages'
    },
  ],
};

/// Descriptor for `ChatReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatReplyDescriptor = $convert.base64Decode(
    'CglDaGF0UmVwbHkSNQoIbWVzc2FnZXMYASADKAsyGS5jb25maWcuYXNzaXN0YW50Lk1lc3NhZ2'
    'VSCG1lc3NhZ2Vz');

@$core.Deprecated('Use historyQueryDescriptor instead')
const HistoryQuery$json = {
  '1': 'HistoryQuery',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `HistoryQuery`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List historyQueryDescriptor =
    $convert.base64Decode('CgxIaXN0b3J5UXVlcnkSFAoFbGltaXQYASABKAVSBWxpbWl0');

@$core.Deprecated('Use messageDescriptor instead')
const Message$json = {
  '1': 'Message',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'role', '3': 2, '4': 1, '5': 9, '10': 'role'},
    {'1': 'text', '3': 3, '4': 1, '5': 9, '10': 'text'},
    {'1': 'created_at', '3': 4, '4': 1, '5': 9, '10': 'createdAt'},
    {
      '1': 'card',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.config.assistant.Card',
      '10': 'card'
    },
    {'1': 'card_present', '3': 7, '4': 1, '5': 8, '10': 'cardPresent'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode(
    'CgdNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBISCgRyb2xlGAIgASgJUgRyb2xlEhIKBHRleHQYAy'
    'ABKAlSBHRleHQSHQoKY3JlYXRlZF9hdBgEIAEoCVIJY3JlYXRlZEF0EioKBGNhcmQYBiABKAsy'
    'Fi5jb25maWcuYXNzaXN0YW50LkNhcmRSBGNhcmQSIQoMY2FyZF9wcmVzZW50GAcgASgIUgtjYX'
    'JkUHJlc2VudA==');

@$core.Deprecated('Use messageSendDescriptor instead')
const MessageSend$json = {
  '1': 'MessageSend',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    {
      '1': 'client_mutation_id',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'clientMutationId'
    },
  ],
};

/// Descriptor for `MessageSend`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageSendDescriptor = $convert.base64Decode(
    'CgtNZXNzYWdlU2VuZBISCgR0ZXh0GAEgASgJUgR0ZXh0EiwKEmNsaWVudF9tdXRhdGlvbl9pZB'
    'gCIAEoCVIQY2xpZW50TXV0YXRpb25JZA==');

@$core.Deprecated('Use smsCardDescriptor instead')
const SmsCard$json = {
  '1': 'SmsCard',
  '2': [
    {'1': 'ignored', '3': 1, '4': 1, '5': 9, '10': 'ignored'},
    {'1': 'kind', '3': 2, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'amount_minor', '3': 3, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'wallet_id', '3': 5, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'confidence', '3': 6, '4': 1, '5': 9, '10': 'confidence'},
    {'1': 'occurred_at', '3': 7, '4': 1, '5': 9, '10': 'occurredAt'},
    {'1': 'balance_present', '3': 8, '4': 1, '5': 8, '10': 'balancePresent'},
    {'1': 'balance_minor', '3': 9, '4': 1, '5': 3, '10': 'balanceMinor'},
    {'1': 'last4', '3': 10, '4': 1, '5': 9, '10': 'last4'},
    {'1': 'category_id', '3': 11, '4': 1, '5': 9, '10': 'categoryId'},
    {
      '1': 'suggested_category_ids',
      '3': 12,
      '4': 3,
      '5': 9,
      '10': 'suggestedCategoryIds'
    },
    {
      '1': 'duplicate_entry_id',
      '3': 13,
      '4': 1,
      '5': 9,
      '10': 'duplicateEntryId'
    },
  ],
};

/// Descriptor for `SmsCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsCardDescriptor = $convert.base64Decode(
    'CgdTbXNDYXJkEhgKB2lnbm9yZWQYASABKAlSB2lnbm9yZWQSEgoEa2luZBgCIAEoCVIEa2luZB'
    'IhCgxhbW91bnRfbWlub3IYAyABKANSC2Ftb3VudE1pbm9yEhoKCGN1cnJlbmN5GAQgASgJUghj'
    'dXJyZW5jeRIbCgl3YWxsZXRfaWQYBSABKAlSCHdhbGxldElkEh4KCmNvbmZpZGVuY2UYBiABKA'
    'lSCmNvbmZpZGVuY2USHwoLb2NjdXJyZWRfYXQYByABKAlSCm9jY3VycmVkQXQSJwoPYmFsYW5j'
    'ZV9wcmVzZW50GAggASgIUg5iYWxhbmNlUHJlc2VudBIjCg1iYWxhbmNlX21pbm9yGAkgASgDUg'
    'xiYWxhbmNlTWlub3ISFAoFbGFzdDQYCiABKAlSBWxhc3Q0Eh8KC2NhdGVnb3J5X2lkGAsgASgJ'
    'UgpjYXRlZ29yeUlkEjQKFnN1Z2dlc3RlZF9jYXRlZ29yeV9pZHMYDCADKAlSFHN1Z2dlc3RlZE'
    'NhdGVnb3J5SWRzEiwKEmR1cGxpY2F0ZV9lbnRyeV9pZBgNIAEoCVIQZHVwbGljYXRlRW50cnlJ'
    'ZA==');

@$core.Deprecated('Use smsTextDescriptor instead')
const SmsText$json = {
  '1': 'SmsText',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
  ],
};

/// Descriptor for `SmsText`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsTextDescriptor =
    $convert.base64Decode('CgdTbXNUZXh0EhIKBHRleHQYASABKAlSBHRleHQ=');
