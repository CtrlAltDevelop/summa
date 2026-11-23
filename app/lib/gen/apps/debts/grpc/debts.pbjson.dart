// This is a generated file - do not edit.
//
// Generated from apps/debts/grpc/debts.proto.

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

@$core.Deprecated('Use debtCreateDescriptor instead')
const DebtCreate$json = {
  '1': 'DebtCreate',
  '2': [
    {'1': 'kind', '3': 1, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {
      '1': 'installment_minor',
      '3': 4,
      '4': 1,
      '5': 3,
      '10': 'installmentMinor'
    },
    {'1': 'count', '3': 5, '4': 1, '5': 5, '10': 'count'},
    {'1': 'first_due', '3': 6, '4': 1, '5': 9, '10': 'firstDue'},
    {'1': 'principal_minor', '3': 7, '4': 1, '5': 3, '10': 'principalMinor'},
    {'1': 'wallet_id', '3': 8, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'category_id', '3': 9, '4': 1, '5': 9, '10': 'categoryId'},
    {
      '1': 'client_mutation_id',
      '3': 10,
      '4': 1,
      '5': 9,
      '10': 'clientMutationId'
    },
  ],
};

/// Descriptor for `DebtCreate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List debtCreateDescriptor = $convert.base64Decode(
    'CgpEZWJ0Q3JlYXRlEhIKBGtpbmQYASABKAlSBGtpbmQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEh'
    'oKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIrChFpbnN0YWxsbWVudF9taW5vchgEIAEoA1IQ'
    'aW5zdGFsbG1lbnRNaW5vchIUCgVjb3VudBgFIAEoBVIFY291bnQSGwoJZmlyc3RfZHVlGAYgAS'
    'gJUghmaXJzdER1ZRInCg9wcmluY2lwYWxfbWlub3IYByABKANSDnByaW5jaXBhbE1pbm9yEhsK'
    'CXdhbGxldF9pZBgIIAEoCVIId2FsbGV0SWQSHwoLY2F0ZWdvcnlfaWQYCSABKAlSCmNhdGVnb3'
    'J5SWQSLAoSY2xpZW50X211dGF0aW9uX2lkGAogASgJUhBjbGllbnRNdXRhdGlvbklk');

@$core.Deprecated('Use debtListReplyDescriptor instead')
const DebtListReply$json = {
  '1': 'DebtListReply',
  '2': [
    {
      '1': 'debts',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.debts.DebtMsg',
      '10': 'debts'
    },
  ],
};

/// Descriptor for `DebtListReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List debtListReplyDescriptor = $convert.base64Decode(
    'Cg1EZWJ0TGlzdFJlcGx5EisKBWRlYnRzGAEgAygLMhUuY29uZmlnLmRlYnRzLkRlYnRNc2dSBW'
    'RlYnRz');

@$core.Deprecated('Use debtMsgDescriptor instead')
const DebtMsg$json = {
  '1': 'DebtMsg',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'kind', '3': 2, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {
      '1': 'installment_minor',
      '3': 5,
      '4': 1,
      '5': 3,
      '10': 'installmentMinor'
    },
    {'1': 'count', '3': 6, '4': 1, '5': 5, '10': 'count'},
    {'1': 'principal_minor', '3': 7, '4': 1, '5': 3, '10': 'principalMinor'},
    {'1': 'wallet_id', '3': 8, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'category_id', '3': 9, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'paid_count', '3': 10, '4': 1, '5': 5, '10': 'paidCount'},
    {'1': 'remaining_minor', '3': 11, '4': 1, '5': 3, '10': 'remainingMinor'},
    {'1': 'next_due', '3': 12, '4': 1, '5': 9, '10': 'nextDue'},
    {'1': 'closed', '3': 13, '4': 1, '5': 8, '10': 'closed'},
    {
      '1': 'installments',
      '3': 14,
      '4': 3,
      '5': 11,
      '6': '.config.debts.InstallmentMsg',
      '10': 'installments'
    },
  ],
};

/// Descriptor for `DebtMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List debtMsgDescriptor = $convert.base64Decode(
    'CgdEZWJ0TXNnEg4KAmlkGAEgASgJUgJpZBISCgRraW5kGAIgASgJUgRraW5kEhQKBXRpdGxlGA'
    'MgASgJUgV0aXRsZRIaCghjdXJyZW5jeRgEIAEoCVIIY3VycmVuY3kSKwoRaW5zdGFsbG1lbnRf'
    'bWlub3IYBSABKANSEGluc3RhbGxtZW50TWlub3ISFAoFY291bnQYBiABKAVSBWNvdW50EicKD3'
    'ByaW5jaXBhbF9taW5vchgHIAEoA1IOcHJpbmNpcGFsTWlub3ISGwoJd2FsbGV0X2lkGAggASgJ'
    'Ugh3YWxsZXRJZBIfCgtjYXRlZ29yeV9pZBgJIAEoCVIKY2F0ZWdvcnlJZBIdCgpwYWlkX2NvdW'
    '50GAogASgFUglwYWlkQ291bnQSJwoPcmVtYWluaW5nX21pbm9yGAsgASgDUg5yZW1haW5pbmdN'
    'aW5vchIZCghuZXh0X2R1ZRgMIAEoCVIHbmV4dER1ZRIWCgZjbG9zZWQYDSABKAhSBmNsb3NlZB'
    'JACgxpbnN0YWxsbWVudHMYDiADKAsyHC5jb25maWcuZGVidHMuSW5zdGFsbG1lbnRNc2dSDGlu'
    'c3RhbGxtZW50cw==');

@$core.Deprecated('Use debtRefDescriptor instead')
const DebtRef$json = {
  '1': 'DebtRef',
  '2': [
    {'1': 'debt_id', '3': 1, '4': 1, '5': 9, '10': 'debtId'},
  ],
};

/// Descriptor for `DebtRef`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List debtRefDescriptor =
    $convert.base64Decode('CgdEZWJ0UmVmEhcKB2RlYnRfaWQYASABKAlSBmRlYnRJZA==');

@$core.Deprecated('Use debtReplyDescriptor instead')
const DebtReply$json = {
  '1': 'DebtReply',
  '2': [
    {
      '1': 'debt',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.config.debts.DebtMsg',
      '10': 'debt'
    },
  ],
};

/// Descriptor for `DebtReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List debtReplyDescriptor = $convert.base64Decode(
    'CglEZWJ0UmVwbHkSKQoEZGVidBgBIAEoCzIVLmNvbmZpZy5kZWJ0cy5EZWJ0TXNnUgRkZWJ0');

@$core.Deprecated('Use installmentMsgDescriptor instead')
const InstallmentMsg$json = {
  '1': 'InstallmentMsg',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'number', '3': 2, '4': 1, '5': 5, '10': 'number'},
    {'1': 'due_date', '3': 3, '4': 1, '5': 9, '10': 'dueDate'},
    {'1': 'amount_minor', '3': 4, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'paid', '3': 5, '4': 1, '5': 8, '10': 'paid'},
    {'1': 'overdue', '3': 6, '4': 1, '5': 8, '10': 'overdue'},
  ],
};

/// Descriptor for `InstallmentMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List installmentMsgDescriptor = $convert.base64Decode(
    'Cg5JbnN0YWxsbWVudE1zZxIOCgJpZBgBIAEoCVICaWQSFgoGbnVtYmVyGAIgASgFUgZudW1iZX'
    'ISGQoIZHVlX2RhdGUYAyABKAlSB2R1ZURhdGUSIQoMYW1vdW50X21pbm9yGAQgASgDUgthbW91'
    'bnRNaW5vchISCgRwYWlkGAUgASgIUgRwYWlkEhgKB292ZXJkdWUYBiABKAhSB292ZXJkdWU=');

@$core.Deprecated('Use installmentPayDescriptor instead')
const InstallmentPay$json = {
  '1': 'InstallmentPay',
  '2': [
    {'1': 'installment_id', '3': 1, '4': 1, '5': 9, '10': 'installmentId'},
    {'1': 'wallet_id', '3': 2, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'amount_minor', '3': 3, '4': 1, '5': 3, '10': 'amountMinor'},
  ],
};

/// Descriptor for `InstallmentPay`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List installmentPayDescriptor = $convert.base64Decode(
    'Cg5JbnN0YWxsbWVudFBheRIlCg5pbnN0YWxsbWVudF9pZBgBIAEoCVINaW5zdGFsbG1lbnRJZB'
    'IbCgl3YWxsZXRfaWQYAiABKAlSCHdhbGxldElkEiEKDGFtb3VudF9taW5vchgDIAEoA1ILYW1v'
    'dW50TWlub3I=');

@$core.Deprecated('Use installmentRefDescriptor instead')
const InstallmentRef$json = {
  '1': 'InstallmentRef',
  '2': [
    {'1': 'installment_id', '3': 1, '4': 1, '5': 9, '10': 'installmentId'},
  ],
};

/// Descriptor for `InstallmentRef`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List installmentRefDescriptor = $convert.base64Decode(
    'Cg5JbnN0YWxsbWVudFJlZhIlCg5pbnN0YWxsbWVudF9pZBgBIAEoCVINaW5zdGFsbG1lbnRJZA'
    '==');
