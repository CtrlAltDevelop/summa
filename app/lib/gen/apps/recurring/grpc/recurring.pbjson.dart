// This is a generated file - do not edit.
//
// Generated from apps/recurring/grpc/recurring.proto.

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

@$core.Deprecated('Use occurrenceAnswerDescriptor instead')
const OccurrenceAnswer$json = {
  '1': 'OccurrenceAnswer',
  '2': [
    {'1': 'occurrence_id', '3': 1, '4': 1, '5': 9, '10': 'occurrenceId'},
    {'1': 'action', '3': 2, '4': 1, '5': 9, '10': 'action'},
    {'1': 'wallet_id', '3': 3, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'amount_minor', '3': 4, '4': 1, '5': 3, '10': 'amountMinor'},
  ],
};

/// Descriptor for `OccurrenceAnswer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List occurrenceAnswerDescriptor = $convert.base64Decode(
    'ChBPY2N1cnJlbmNlQW5zd2VyEiMKDW9jY3VycmVuY2VfaWQYASABKAlSDG9jY3VycmVuY2VJZB'
    'IWCgZhY3Rpb24YAiABKAlSBmFjdGlvbhIbCgl3YWxsZXRfaWQYAyABKAlSCHdhbGxldElkEiEK'
    'DGFtb3VudF9taW5vchgEIAEoA1ILYW1vdW50TWlub3I=');

@$core.Deprecated('Use occurrenceMsgDescriptor instead')
const OccurrenceMsg$json = {
  '1': 'OccurrenceMsg',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'recurring_id', '3': 2, '4': 1, '5': 9, '10': 'recurringId'},
    {'1': 'wallet_id', '3': 3, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'kind', '3': 4, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'amount_minor', '3': 5, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'note', '3': 7, '4': 1, '5': 9, '10': 'note'},
    {'1': 'due_date', '3': 8, '4': 1, '5': 9, '10': 'dueDate'},
    {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    {'1': 'low_balance', '3': 10, '4': 1, '5': 8, '10': 'lowBalance'},
  ],
};

/// Descriptor for `OccurrenceMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List occurrenceMsgDescriptor = $convert.base64Decode(
    'Cg1PY2N1cnJlbmNlTXNnEg4KAmlkGAEgASgJUgJpZBIhCgxyZWN1cnJpbmdfaWQYAiABKAlSC3'
    'JlY3VycmluZ0lkEhsKCXdhbGxldF9pZBgDIAEoCVIId2FsbGV0SWQSEgoEa2luZBgEIAEoCVIE'
    'a2luZBIhCgxhbW91bnRfbWlub3IYBSABKANSC2Ftb3VudE1pbm9yEhoKCGN1cnJlbmN5GAYgAS'
    'gJUghjdXJyZW5jeRISCgRub3RlGAcgASgJUgRub3RlEhkKCGR1ZV9kYXRlGAggASgJUgdkdWVE'
    'YXRlEhYKBnN0YXR1cxgJIAEoCVIGc3RhdHVzEh8KC2xvd19iYWxhbmNlGAogASgIUgpsb3dCYW'
    'xhbmNl');

@$core.Deprecated('Use recurringActiveDescriptor instead')
const RecurringActive$json = {
  '1': 'RecurringActive',
  '2': [
    {'1': 'recurring_id', '3': 1, '4': 1, '5': 9, '10': 'recurringId'},
    {'1': 'active', '3': 2, '4': 1, '5': 8, '10': 'active'},
  ],
};

/// Descriptor for `RecurringActive`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recurringActiveDescriptor = $convert.base64Decode(
    'Cg9SZWN1cnJpbmdBY3RpdmUSIQoMcmVjdXJyaW5nX2lkGAEgASgJUgtyZWN1cnJpbmdJZBIWCg'
    'ZhY3RpdmUYAiABKAhSBmFjdGl2ZQ==');

@$core.Deprecated('Use recurringCreateDescriptor instead')
const RecurringCreate$json = {
  '1': 'RecurringCreate',
  '2': [
    {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'kind', '3': 2, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'amount_minor', '3': 3, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'category_id', '3': 4, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'note', '3': 5, '4': 1, '5': 9, '10': 'note'},
    {'1': 'period', '3': 6, '4': 1, '5': 9, '10': 'period'},
    {'1': 'day', '3': 7, '4': 1, '5': 5, '10': 'day'},
    {'1': 'auto_confirm', '3': 8, '4': 1, '5': 8, '10': 'autoConfirm'},
    {
      '1': 'client_mutation_id',
      '3': 9,
      '4': 1,
      '5': 9,
      '10': 'clientMutationId'
    },
  ],
};

/// Descriptor for `RecurringCreate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recurringCreateDescriptor = $convert.base64Decode(
    'Cg9SZWN1cnJpbmdDcmVhdGUSGwoJd2FsbGV0X2lkGAEgASgJUgh3YWxsZXRJZBISCgRraW5kGA'
    'IgASgJUgRraW5kEiEKDGFtb3VudF9taW5vchgDIAEoA1ILYW1vdW50TWlub3ISHwoLY2F0ZWdv'
    'cnlfaWQYBCABKAlSCmNhdGVnb3J5SWQSEgoEbm90ZRgFIAEoCVIEbm90ZRIWCgZwZXJpb2QYBi'
    'ABKAlSBnBlcmlvZBIQCgNkYXkYByABKAVSA2RheRIhCgxhdXRvX2NvbmZpcm0YCCABKAhSC2F1'
    'dG9Db25maXJtEiwKEmNsaWVudF9tdXRhdGlvbl9pZBgJIAEoCVIQY2xpZW50TXV0YXRpb25JZA'
    '==');

@$core.Deprecated('Use recurringListReplyDescriptor instead')
const RecurringListReply$json = {
  '1': 'RecurringListReply',
  '2': [
    {
      '1': 'recurrings',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.recurring.RecurringMsg',
      '10': 'recurrings'
    },
    {
      '1': 'occurrences',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.config.recurring.OccurrenceMsg',
      '10': 'occurrences'
    },
  ],
};

/// Descriptor for `RecurringListReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recurringListReplyDescriptor = $convert.base64Decode(
    'ChJSZWN1cnJpbmdMaXN0UmVwbHkSPgoKcmVjdXJyaW5ncxgBIAMoCzIeLmNvbmZpZy5yZWN1cn'
    'JpbmcuUmVjdXJyaW5nTXNnUgpyZWN1cnJpbmdzEkEKC29jY3VycmVuY2VzGAIgAygLMh8uY29u'
    'ZmlnLnJlY3VycmluZy5PY2N1cnJlbmNlTXNnUgtvY2N1cnJlbmNlcw==');

@$core.Deprecated('Use recurringMsgDescriptor instead')
const RecurringMsg$json = {
  '1': 'RecurringMsg',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'wallet_id', '3': 2, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'kind', '3': 3, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'amount_minor', '3': 4, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'category_id', '3': 6, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'note', '3': 7, '4': 1, '5': 9, '10': 'note'},
    {'1': 'period', '3': 8, '4': 1, '5': 9, '10': 'period'},
    {'1': 'day', '3': 9, '4': 1, '5': 5, '10': 'day'},
    {'1': 'auto_confirm', '3': 10, '4': 1, '5': 8, '10': 'autoConfirm'},
    {'1': 'active', '3': 11, '4': 1, '5': 8, '10': 'active'},
    {'1': 'next_due', '3': 12, '4': 1, '5': 9, '10': 'nextDue'},
  ],
};

/// Descriptor for `RecurringMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recurringMsgDescriptor = $convert.base64Decode(
    'CgxSZWN1cnJpbmdNc2cSDgoCaWQYASABKAlSAmlkEhsKCXdhbGxldF9pZBgCIAEoCVIId2FsbG'
    'V0SWQSEgoEa2luZBgDIAEoCVIEa2luZBIhCgxhbW91bnRfbWlub3IYBCABKANSC2Ftb3VudE1p'
    'bm9yEhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRIfCgtjYXRlZ29yeV9pZBgGIAEoCVIKY2'
    'F0ZWdvcnlJZBISCgRub3RlGAcgASgJUgRub3RlEhYKBnBlcmlvZBgIIAEoCVIGcGVyaW9kEhAK'
    'A2RheRgJIAEoBVIDZGF5EiEKDGF1dG9fY29uZmlybRgKIAEoCFILYXV0b0NvbmZpcm0SFgoGYW'
    'N0aXZlGAsgASgIUgZhY3RpdmUSGQoIbmV4dF9kdWUYDCABKAlSB25leHREdWU=');

@$core.Deprecated('Use recurringRefDescriptor instead')
const RecurringRef$json = {
  '1': 'RecurringRef',
  '2': [
    {'1': 'recurring_id', '3': 1, '4': 1, '5': 9, '10': 'recurringId'},
  ],
};

/// Descriptor for `RecurringRef`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recurringRefDescriptor = $convert.base64Decode(
    'CgxSZWN1cnJpbmdSZWYSIQoMcmVjdXJyaW5nX2lkGAEgASgJUgtyZWN1cnJpbmdJZA==');

@$core.Deprecated('Use recurringReplyDescriptor instead')
const RecurringReply$json = {
  '1': 'RecurringReply',
  '2': [
    {
      '1': 'recurring',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.config.recurring.RecurringMsg',
      '10': 'recurring'
    },
  ],
};

/// Descriptor for `RecurringReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recurringReplyDescriptor = $convert.base64Decode(
    'Cg5SZWN1cnJpbmdSZXBseRI8CglyZWN1cnJpbmcYASABKAsyHi5jb25maWcucmVjdXJyaW5nLl'
    'JlY3VycmluZ01zZ1IJcmVjdXJyaW5n');

@$core.Deprecated('Use settleRequestDescriptor instead')
const SettleRequest$json = {
  '1': 'SettleRequest',
  '2': [
    {'1': 'recurring_id', '3': 1, '4': 1, '5': 9, '10': 'recurringId'},
    {'1': 'amount_minor', '3': 2, '4': 1, '5': 3, '10': 'amountMinor'},
  ],
};

/// Descriptor for `SettleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settleRequestDescriptor = $convert.base64Decode(
    'Cg1TZXR0bGVSZXF1ZXN0EiEKDHJlY3VycmluZ19pZBgBIAEoCVILcmVjdXJyaW5nSWQSIQoMYW'
    '1vdW50X21pbm9yGAIgASgDUgthbW91bnRNaW5vcg==');
