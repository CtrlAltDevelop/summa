// This is a generated file - do not edit.
//
// Generated from apps/sync/grpc/sync.proto.

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

@$core.Deprecated('Use changesReplyDescriptor instead')
const ChangesReply$json = {
  '1': 'ChangesReply',
  '2': [
    {
      '1': 'wallets',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.sync.SyncWalletMsg',
      '10': 'wallets'
    },
    {
      '1': 'categories',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.config.sync.SyncCategoryMsg',
      '10': 'categories'
    },
    {
      '1': 'entries',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.config.sync.SyncEntryMsg',
      '10': 'entries'
    },
    {'1': 'wallets_cursor', '3': 4, '4': 1, '5': 9, '10': 'walletsCursor'},
    {
      '1': 'categories_cursor',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'categoriesCursor'
    },
    {'1': 'events_cursor', '3': 6, '4': 1, '5': 9, '10': 'eventsCursor'},
    {'1': 'has_more', '3': 7, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `ChangesReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changesReplyDescriptor = $convert.base64Decode(
    'CgxDaGFuZ2VzUmVwbHkSNAoHd2FsbGV0cxgBIAMoCzIaLmNvbmZpZy5zeW5jLlN5bmNXYWxsZX'
    'RNc2dSB3dhbGxldHMSPAoKY2F0ZWdvcmllcxgCIAMoCzIcLmNvbmZpZy5zeW5jLlN5bmNDYXRl'
    'Z29yeU1zZ1IKY2F0ZWdvcmllcxIzCgdlbnRyaWVzGAMgAygLMhkuY29uZmlnLnN5bmMuU3luY0'
    'VudHJ5TXNnUgdlbnRyaWVzEiUKDndhbGxldHNfY3Vyc29yGAQgASgJUg13YWxsZXRzQ3Vyc29y'
    'EisKEWNhdGVnb3JpZXNfY3Vyc29yGAUgASgJUhBjYXRlZ29yaWVzQ3Vyc29yEiMKDWV2ZW50c1'
    '9jdXJzb3IYBiABKAlSDGV2ZW50c0N1cnNvchIZCghoYXNfbW9yZRgHIAEoCFIHaGFzTW9yZQ==');

@$core.Deprecated('Use changesRequestDescriptor instead')
const ChangesRequest$json = {
  '1': 'ChangesRequest',
  '2': [
    {'1': 'wallets_cursor', '3': 1, '4': 1, '5': 9, '10': 'walletsCursor'},
    {
      '1': 'categories_cursor',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'categoriesCursor'
    },
    {'1': 'events_cursor', '3': 3, '4': 1, '5': 9, '10': 'eventsCursor'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `ChangesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changesRequestDescriptor = $convert.base64Decode(
    'Cg5DaGFuZ2VzUmVxdWVzdBIlCg53YWxsZXRzX2N1cnNvchgBIAEoCVINd2FsbGV0c0N1cnNvch'
    'IrChFjYXRlZ29yaWVzX2N1cnNvchgCIAEoCVIQY2F0ZWdvcmllc0N1cnNvchIjCg1ldmVudHNf'
    'Y3Vyc29yGAMgASgJUgxldmVudHNDdXJzb3ISFAoFbGltaXQYBCABKAVSBWxpbWl0');

@$core.Deprecated('Use syncCategoryMsgDescriptor instead')
const SyncCategoryMsg$json = {
  '1': 'SyncCategoryMsg',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'kind', '3': 3, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'is_other', '3': 4, '4': 1, '5': 8, '10': 'isOther'},
  ],
};

/// Descriptor for `SyncCategoryMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncCategoryMsgDescriptor = $convert.base64Decode(
    'Cg9TeW5jQ2F0ZWdvcnlNc2cSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSEg'
    'oEa2luZBgDIAEoCVIEa2luZBIZCghpc19vdGhlchgEIAEoCFIHaXNPdGhlcg==');

@$core.Deprecated('Use syncEntryMsgDescriptor instead')
const SyncEntryMsg$json = {
  '1': 'SyncEntryMsg',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'wallet_id', '3': 2, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'kind', '3': 3, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'direction', '3': 4, '4': 1, '5': 9, '10': 'direction'},
    {'1': 'amount_minor', '3': 5, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'occurred_at', '3': 6, '4': 1, '5': 9, '10': 'occurredAt'},
    {'1': 'note', '3': 7, '4': 1, '5': 9, '10': 'note'},
    {'1': 'category_id', '3': 8, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'outside_totals', '3': 9, '4': 1, '5': 8, '10': 'outsideTotals'},
    {'1': 'split_id', '3': 10, '4': 1, '5': 9, '10': 'splitId'},
    {'1': 'transfer_id', '3': 11, '4': 1, '5': 9, '10': 'transferId'},
    {'1': 'refund_of', '3': 12, '4': 1, '5': 9, '10': 'refundOf'},
    {'1': 'voided', '3': 13, '4': 1, '5': 8, '10': 'voided'},
  ],
};

/// Descriptor for `SyncEntryMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncEntryMsgDescriptor = $convert.base64Decode(
    'CgxTeW5jRW50cnlNc2cSDgoCaWQYASABKAlSAmlkEhsKCXdhbGxldF9pZBgCIAEoCVIId2FsbG'
    'V0SWQSEgoEa2luZBgDIAEoCVIEa2luZBIcCglkaXJlY3Rpb24YBCABKAlSCWRpcmVjdGlvbhIh'
    'CgxhbW91bnRfbWlub3IYBSABKANSC2Ftb3VudE1pbm9yEh8KC29jY3VycmVkX2F0GAYgASgJUg'
    'pvY2N1cnJlZEF0EhIKBG5vdGUYByABKAlSBG5vdGUSHwoLY2F0ZWdvcnlfaWQYCCABKAlSCmNh'
    'dGVnb3J5SWQSJQoOb3V0c2lkZV90b3RhbHMYCSABKAhSDW91dHNpZGVUb3RhbHMSGQoIc3BsaX'
    'RfaWQYCiABKAlSB3NwbGl0SWQSHwoLdHJhbnNmZXJfaWQYCyABKAlSCnRyYW5zZmVySWQSGwoJ'
    'cmVmdW5kX29mGAwgASgJUghyZWZ1bmRPZhIWCgZ2b2lkZWQYDSABKAhSBnZvaWRlZA==');

@$core.Deprecated('Use syncWalletMsgDescriptor instead')
const SyncWalletMsg$json = {
  '1': 'SyncWalletMsg',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'kind', '3': 3, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'bank', '3': 5, '4': 1, '5': 9, '10': 'bank'},
    {'1': 'archived', '3': 6, '4': 1, '5': 8, '10': 'archived'},
  ],
};

/// Descriptor for `SyncWalletMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncWalletMsgDescriptor = $convert.base64Decode(
    'Cg1TeW5jV2FsbGV0TXNnEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhIKBG'
    'tpbmQYAyABKAlSBGtpbmQSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5EhIKBGJhbmsYBSAB'
    'KAlSBGJhbmsSGgoIYXJjaGl2ZWQYBiABKAhSCGFyY2hpdmVk');
