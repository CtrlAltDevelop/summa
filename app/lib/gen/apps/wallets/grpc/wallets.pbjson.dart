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

@$core.Deprecated('Use budgetRowDescriptor instead')
const BudgetRow$json = {
  '1': 'BudgetRow',
  '2': [
    {'1': 'category_id', '3': 1, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'category_name', '3': 2, '4': 1, '5': 9, '10': 'categoryName'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'limit_minor', '3': 4, '4': 1, '5': 3, '10': 'limitMinor'},
    {'1': 'spent_minor', '3': 5, '4': 1, '5': 3, '10': 'spentMinor'},
  ],
};

/// Descriptor for `BudgetRow`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List budgetRowDescriptor = $convert.base64Decode(
    'CglCdWRnZXRSb3cSHwoLY2F0ZWdvcnlfaWQYASABKAlSCmNhdGVnb3J5SWQSIwoNY2F0ZWdvcn'
    'lfbmFtZRgCIAEoCVIMY2F0ZWdvcnlOYW1lEhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIf'
    'CgtsaW1pdF9taW5vchgEIAEoA1IKbGltaXRNaW5vchIfCgtzcGVudF9taW5vchgFIAEoA1IKc3'
    'BlbnRNaW5vcg==');

@$core.Deprecated('Use budgetSetDescriptor instead')
const BudgetSet$json = {
  '1': 'BudgetSet',
  '2': [
    {'1': 'category_id', '3': 1, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'limit_minor', '3': 3, '4': 1, '5': 3, '10': 'limitMinor'},
  ],
};

/// Descriptor for `BudgetSet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List budgetSetDescriptor = $convert.base64Decode(
    'CglCdWRnZXRTZXQSHwoLY2F0ZWdvcnlfaWQYASABKAlSCmNhdGVnb3J5SWQSGgoIY3VycmVuY3'
    'kYAiABKAlSCGN1cnJlbmN5Eh8KC2xpbWl0X21pbm9yGAMgASgDUgpsaW1pdE1pbm9y');

@$core.Deprecated('Use budgetStatusReplyDescriptor instead')
const BudgetStatusReply$json = {
  '1': 'BudgetStatusReply',
  '2': [
    {
      '1': 'budgets',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.wallets.BudgetRow',
      '10': 'budgets'
    },
  ],
};

/// Descriptor for `BudgetStatusReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List budgetStatusReplyDescriptor = $convert.base64Decode(
    'ChFCdWRnZXRTdGF0dXNSZXBseRIzCgdidWRnZXRzGAEgAygLMhkuY29uZmlnLndhbGxldHMuQn'
    'VkZ2V0Um93UgdidWRnZXRz');

@$core.Deprecated('Use budgetWindowDescriptor instead')
const BudgetWindow$json = {
  '1': 'BudgetWindow',
  '2': [
    {'1': 'starts_at', '3': 1, '4': 1, '5': 9, '10': 'startsAt'},
    {'1': 'ends_at', '3': 2, '4': 1, '5': 9, '10': 'endsAt'},
  ],
};

/// Descriptor for `BudgetWindow`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List budgetWindowDescriptor = $convert.base64Decode(
    'CgxCdWRnZXRXaW5kb3cSGwoJc3RhcnRzX2F0GAEgASgJUghzdGFydHNBdBIXCgdlbmRzX2F0GA'
    'IgASgJUgZlbmRzQXQ=');

@$core.Deprecated('Use categoryDescriptor instead')
const Category$json = {
  '1': 'Category',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'kind', '3': 3, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'is_other', '3': 4, '4': 1, '5': 8, '10': 'isOther'},
  ],
};

/// Descriptor for `Category`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryDescriptor = $convert.base64Decode(
    'CghDYXRlZ29yeRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRISCgRraW5kGA'
    'MgASgJUgRraW5kEhkKCGlzX290aGVyGAQgASgIUgdpc090aGVy');

@$core.Deprecated('Use categoryCreateDescriptor instead')
const CategoryCreate$json = {
  '1': 'CategoryCreate',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'kind', '3': 2, '4': 1, '5': 9, '10': 'kind'},
  ],
};

/// Descriptor for `CategoryCreate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryCreateDescriptor = $convert.base64Decode(
    'Cg5DYXRlZ29yeUNyZWF0ZRISCgRuYW1lGAEgASgJUgRuYW1lEhIKBGtpbmQYAiABKAlSBGtpbm'
    'Q=');

@$core.Deprecated('Use categoryListReplyDescriptor instead')
const CategoryListReply$json = {
  '1': 'CategoryListReply',
  '2': [
    {
      '1': 'categories',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.wallets.Category',
      '10': 'categories'
    },
  ],
};

/// Descriptor for `CategoryListReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryListReplyDescriptor = $convert.base64Decode(
    'ChFDYXRlZ29yeUxpc3RSZXBseRI4CgpjYXRlZ29yaWVzGAEgAygLMhguY29uZmlnLndhbGxldH'
    'MuQ2F0ZWdvcnlSCmNhdGVnb3JpZXM=');

@$core.Deprecated('Use categoryRefDescriptor instead')
const CategoryRef$json = {
  '1': 'CategoryRef',
  '2': [
    {'1': 'category_id', '3': 1, '4': 1, '5': 9, '10': 'categoryId'},
  ],
};

/// Descriptor for `CategoryRef`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryRefDescriptor = $convert.base64Decode(
    'CgtDYXRlZ29yeVJlZhIfCgtjYXRlZ29yeV9pZBgBIAEoCVIKY2F0ZWdvcnlJZA==');

@$core.Deprecated('Use categoryReplyDescriptor instead')
const CategoryReply$json = {
  '1': 'CategoryReply',
  '2': [
    {
      '1': 'category',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.config.wallets.Category',
      '10': 'category'
    },
  ],
};

/// Descriptor for `CategoryReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryReplyDescriptor = $convert.base64Decode(
    'Cg1DYXRlZ29yeVJlcGx5EjQKCGNhdGVnb3J5GAEgASgLMhguY29uZmlnLndhbGxldHMuQ2F0ZW'
    'dvcnlSCGNhdGVnb3J5');

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
    {'1': 'category_id', '3': 8, '4': 1, '5': 9, '10': 'categoryId'},
  ],
};

/// Descriptor for `Entry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List entryDescriptor = $convert.base64Decode(
    'CgVFbnRyeRIOCgJpZBgBIAEoCVICaWQSGwoJd2FsbGV0X2lkGAIgASgJUgh3YWxsZXRJZBISCg'
    'RraW5kGAMgASgJUgRraW5kEiEKDGFtb3VudF9taW5vchgEIAEoA1ILYW1vdW50TWlub3ISGgoI'
    'Y3VycmVuY3kYBSABKAlSCGN1cnJlbmN5Eh8KC29jY3VycmVkX2F0GAYgASgJUgpvY2N1cnJlZE'
    'F0EhIKBG5vdGUYByABKAlSBG5vdGUSHwoLY2F0ZWdvcnlfaWQYCCABKAlSCmNhdGVnb3J5SWQ=');

@$core.Deprecated('Use entryEditDescriptor instead')
const EntryEdit$json = {
  '1': 'EntryEdit',
  '2': [
    {'1': 'entry_id', '3': 1, '4': 1, '5': 9, '10': 'entryId'},
    {'1': 'amount_minor', '3': 2, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'occurred_at', '3': 3, '4': 1, '5': 9, '10': 'occurredAt'},
    {'1': 'note', '3': 4, '4': 1, '5': 9, '10': 'note'},
    {'1': 'category_id', '3': 5, '4': 1, '5': 9, '10': 'categoryId'},
  ],
};

/// Descriptor for `EntryEdit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List entryEditDescriptor = $convert.base64Decode(
    'CglFbnRyeUVkaXQSGQoIZW50cnlfaWQYASABKAlSB2VudHJ5SWQSIQoMYW1vdW50X21pbm9yGA'
    'IgASgDUgthbW91bnRNaW5vchIfCgtvY2N1cnJlZF9hdBgDIAEoCVIKb2NjdXJyZWRBdBISCgRu'
    'b3RlGAQgASgJUgRub3RlEh8KC2NhdGVnb3J5X2lkGAUgASgJUgpjYXRlZ29yeUlk');

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
    {'1': 'category_id', '3': 7, '4': 1, '5': 9, '10': 'categoryId'},
  ],
};

/// Descriptor for `EntryRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List entryRecordDescriptor = $convert.base64Decode(
    'CgtFbnRyeVJlY29yZBIbCgl3YWxsZXRfaWQYASABKAlSCHdhbGxldElkEhIKBGtpbmQYAiABKA'
    'lSBGtpbmQSIQoMYW1vdW50X21pbm9yGAMgASgDUgthbW91bnRNaW5vchIfCgtvY2N1cnJlZF9h'
    'dBgEIAEoCVIKb2NjdXJyZWRBdBISCgRub3RlGAUgASgJUgRub3RlEiwKEmNsaWVudF9tdXRhdG'
    'lvbl9pZBgGIAEoCVIQY2xpZW50TXV0YXRpb25JZBIfCgtjYXRlZ29yeV9pZBgHIAEoCVIKY2F0'
    'ZWdvcnlJZA==');

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

@$core.Deprecated('Use transferRequestDescriptor instead')
const TransferRequest$json = {
  '1': 'TransferRequest',
  '2': [
    {'1': 'from_wallet_id', '3': 1, '4': 1, '5': 9, '10': 'fromWalletId'},
    {'1': 'to_wallet_id', '3': 2, '4': 1, '5': 9, '10': 'toWalletId'},
    {'1': 'amount_minor', '3': 3, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'rate', '3': 4, '4': 1, '5': 9, '10': 'rate'},
    {'1': 'fee_minor', '3': 5, '4': 1, '5': 3, '10': 'feeMinor'},
    {'1': 'occurred_at', '3': 6, '4': 1, '5': 9, '10': 'occurredAt'},
    {'1': 'note', '3': 7, '4': 1, '5': 9, '10': 'note'},
    {
      '1': 'client_mutation_id',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'clientMutationId'
    },
  ],
};

/// Descriptor for `TransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferRequestDescriptor = $convert.base64Decode(
    'Cg9UcmFuc2ZlclJlcXVlc3QSJAoOZnJvbV93YWxsZXRfaWQYASABKAlSDGZyb21XYWxsZXRJZB'
    'IgCgx0b193YWxsZXRfaWQYAiABKAlSCnRvV2FsbGV0SWQSIQoMYW1vdW50X21pbm9yGAMgASgD'
    'UgthbW91bnRNaW5vchISCgRyYXRlGAQgASgJUgRyYXRlEhsKCWZlZV9taW5vchgFIAEoA1IIZm'
    'VlTWlub3ISHwoLb2NjdXJyZWRfYXQYBiABKAlSCm9jY3VycmVkQXQSEgoEbm90ZRgHIAEoCVIE'
    'bm90ZRIsChJjbGllbnRfbXV0YXRpb25faWQYCCABKAlSEGNsaWVudE11dGF0aW9uSWQ=');

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
