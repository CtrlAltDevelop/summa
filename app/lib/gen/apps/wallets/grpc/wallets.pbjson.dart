// This is a generated file - do not edit.
//
// Generated from apps/wallets/grpc/wallets.proto.

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

@$core.Deprecated('Use currencyTotalDescriptor instead')
const CurrencyTotal$json = {
  '1': 'CurrencyTotal',
  '2': [
    {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'balance_minor', '3': 2, '4': 1, '5': 3, '10': 'balanceMinor'},
  ],
};

/// Descriptor for `CurrencyTotal`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List currencyTotalDescriptor = $convert.base64Decode(
    'Cg1DdXJyZW5jeVRvdGFsEhoKCGN1cnJlbmN5GAEgASgJUghjdXJyZW5jeRIjCg1iYWxhbmNlX2'
    '1pbm9yGAIgASgDUgxiYWxhbmNlTWlub3I=');

@$core.Deprecated('Use entryDescriptor instead')
const Entry$json = {
  '1': 'Entry',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'wallet_id', '3': 2, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'kind', '3': 3, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'amount_minor', '3': 4, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'occurred_at', '3': 6, '4': 1, '5': 9, '10': 'occurredAt'},
    {'1': 'note', '3': 7, '4': 1, '5': 9, '10': 'note'},
  ],
};

/// Descriptor for `Entry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List entryDescriptor = $convert.base64Decode(
    'CgVFbnRyeRIOCgJpZBgBIAEoCVICaWQSGwoJd2FsbGV0X2lkGAIgASgJUgh3YWxsZXRJZBISCg'
    'RraW5kGAMgASgJUgRraW5kEiEKDGFtb3VudF9taW5vchgEIAEoA1ILYW1vdW50TWlub3ISGgoI'
    'Y3VycmVuY3kYBSABKAlSCGN1cnJlbmN5Eh8KC29jY3VycmVkX2F0GAYgASgJUgpvY2N1cnJlZE'
    'F0EhIKBG5vdGUYByABKAlSBG5vdGU=');

@$core.Deprecated('Use entryEditDescriptor instead')
const EntryEdit$json = {
  '1': 'EntryEdit',
  '2': [
    {'1': 'entry_id', '3': 1, '4': 1, '5': 9, '10': 'entryId'},
    {'1': 'amount_minor', '3': 2, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'occurred_at', '3': 3, '4': 1, '5': 9, '10': 'occurredAt'},
    {'1': 'note', '3': 4, '4': 1, '5': 9, '10': 'note'},
  ],
};

/// Descriptor for `EntryEdit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List entryEditDescriptor = $convert.base64Decode(
    'CglFbnRyeUVkaXQSGQoIZW50cnlfaWQYASABKAlSB2VudHJ5SWQSIQoMYW1vdW50X21pbm9yGA'
    'IgASgDUgthbW91bnRNaW5vchIfCgtvY2N1cnJlZF9hdBgDIAEoCVIKb2NjdXJyZWRBdBISCgRu'
    'b3RlGAQgASgJUgRub3Rl');

@$core.Deprecated('Use entryListReplyDescriptor instead')
const EntryListReply$json = {
  '1': 'EntryListReply',
  '2': [
    {
      '1': 'entries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.wallets.Entry',
      '10': 'entries'
    },
  ],
};

/// Descriptor for `EntryListReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List entryListReplyDescriptor = $convert.base64Decode(
    'Cg5FbnRyeUxpc3RSZXBseRIvCgdlbnRyaWVzGAEgAygLMhUuY29uZmlnLndhbGxldHMuRW50cn'
    'lSB2VudHJpZXM=');

@$core.Deprecated('Use entryQueryDescriptor instead')
const EntryQuery$json = {
  '1': 'EntryQuery',
  '2': [
    {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `EntryQuery`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List entryQueryDescriptor = $convert.base64Decode(
    'CgpFbnRyeVF1ZXJ5EhsKCXdhbGxldF9pZBgBIAEoCVIId2FsbGV0SWQSFAoFbGltaXQYAiABKA'
    'VSBWxpbWl0');

@$core.Deprecated('Use entryRecordDescriptor instead')
const EntryRecord$json = {
  '1': 'EntryRecord',
  '2': [
    {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'kind', '3': 2, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'amount_minor', '3': 3, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'occurred_at', '3': 4, '4': 1, '5': 9, '10': 'occurredAt'},
    {'1': 'note', '3': 5, '4': 1, '5': 9, '10': 'note'},
    {
      '1': 'client_mutation_id',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'clientMutationId'
    },
  ],
};

/// Descriptor for `EntryRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List entryRecordDescriptor = $convert.base64Decode(
    'CgtFbnRyeVJlY29yZBIbCgl3YWxsZXRfaWQYASABKAlSCHdhbGxldElkEhIKBGtpbmQYAiABKA'
    'lSBGtpbmQSIQoMYW1vdW50X21pbm9yGAMgASgDUgthbW91bnRNaW5vchIfCgtvY2N1cnJlZF9h'
    'dBgEIAEoCVIKb2NjdXJyZWRBdBISCgRub3RlGAUgASgJUgRub3RlEiwKEmNsaWVudF9tdXRhdG'
    'lvbl9pZBgGIAEoCVIQY2xpZW50TXV0YXRpb25JZA==');

@$core.Deprecated('Use entryRefDescriptor instead')
const EntryRef$json = {
  '1': 'EntryRef',
  '2': [
    {'1': 'entry_id', '3': 1, '4': 1, '5': 9, '10': 'entryId'},
  ],
};

/// Descriptor for `EntryRef`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List entryRefDescriptor = $convert
    .base64Decode('CghFbnRyeVJlZhIZCghlbnRyeV9pZBgBIAEoCVIHZW50cnlJZA==');

@$core.Deprecated('Use entryReplyDescriptor instead')
const EntryReply$json = {
  '1': 'EntryReply',
  '2': [
    {
      '1': 'entry',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.config.wallets.Entry',
      '10': 'entry'
    },
  ],
};

/// Descriptor for `EntryReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List entryReplyDescriptor = $convert.base64Decode(
    'CgpFbnRyeVJlcGx5EisKBWVudHJ5GAEgASgLMhUuY29uZmlnLndhbGxldHMuRW50cnlSBWVudH'
    'J5');

@$core.Deprecated('Use walletDescriptor instead')
const Wallet$json = {
  '1': 'Wallet',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'kind', '3': 3, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'bank', '3': 5, '4': 1, '5': 9, '10': 'bank'},
    {'1': 'archived', '3': 6, '4': 1, '5': 8, '10': 'archived'},
    {'1': 'balance_minor', '3': 7, '4': 1, '5': 3, '10': 'balanceMinor'},
  ],
};

/// Descriptor for `Wallet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List walletDescriptor = $convert.base64Decode(
    'CgZXYWxsZXQSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSEgoEa2luZBgDIA'
    'EoCVIEa2luZBIaCghjdXJyZW5jeRgEIAEoCVIIY3VycmVuY3kSEgoEYmFuaxgFIAEoCVIEYmFu'
    'axIaCghhcmNoaXZlZBgGIAEoCFIIYXJjaGl2ZWQSIwoNYmFsYW5jZV9taW5vchgHIAEoA1IMYm'
    'FsYW5jZU1pbm9y');

@$core.Deprecated('Use walletCreateDescriptor instead')
const WalletCreate$json = {
  '1': 'WalletCreate',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'kind', '3': 2, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'bank', '3': 4, '4': 1, '5': 9, '10': 'bank'},
    {
      '1': 'opening_balance_minor',
      '3': 5,
      '4': 1,
      '5': 3,
      '10': 'openingBalanceMinor'
    },
    {
      '1': 'client_mutation_id',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'clientMutationId'
    },
  ],
};

/// Descriptor for `WalletCreate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List walletCreateDescriptor = $convert.base64Decode(
    'CgxXYWxsZXRDcmVhdGUSEgoEbmFtZRgBIAEoCVIEbmFtZRISCgRraW5kGAIgASgJUgRraW5kEh'
    'oKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRISCgRiYW5rGAQgASgJUgRiYW5rEjIKFW9wZW5p'
    'bmdfYmFsYW5jZV9taW5vchgFIAEoA1ITb3BlbmluZ0JhbGFuY2VNaW5vchIsChJjbGllbnRfbX'
    'V0YXRpb25faWQYBiABKAlSEGNsaWVudE11dGF0aW9uSWQ=');

@$core.Deprecated('Use walletListReplyDescriptor instead')
const WalletListReply$json = {
  '1': 'WalletListReply',
  '2': [
    {
      '1': 'wallets',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.wallets.Wallet',
      '10': 'wallets'
    },
    {
      '1': 'totals',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.config.wallets.CurrencyTotal',
      '10': 'totals'
    },
  ],
};

/// Descriptor for `WalletListReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List walletListReplyDescriptor = $convert.base64Decode(
    'Cg9XYWxsZXRMaXN0UmVwbHkSMAoHd2FsbGV0cxgBIAMoCzIWLmNvbmZpZy53YWxsZXRzLldhbG'
    'xldFIHd2FsbGV0cxI1CgZ0b3RhbHMYAiADKAsyHS5jb25maWcud2FsbGV0cy5DdXJyZW5jeVRv'
    'dGFsUgZ0b3RhbHM=');

@$core.Deprecated('Use walletRefDescriptor instead')
const WalletRef$json = {
  '1': 'WalletRef',
  '2': [
    {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
  ],
};

/// Descriptor for `WalletRef`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List walletRefDescriptor = $convert
    .base64Decode('CglXYWxsZXRSZWYSGwoJd2FsbGV0X2lkGAEgASgJUgh3YWxsZXRJZA==');

@$core.Deprecated('Use walletReplyDescriptor instead')
const WalletReply$json = {
  '1': 'WalletReply',
  '2': [
    {
      '1': 'wallet',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.config.wallets.Wallet',
      '10': 'wallet'
    },
  ],
};

/// Descriptor for `WalletReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List walletReplyDescriptor = $convert.base64Decode(
    'CgtXYWxsZXRSZXBseRIuCgZ3YWxsZXQYASABKAsyFi5jb25maWcud2FsbGV0cy5XYWxsZXRSBn'
    'dhbGxldA==');
