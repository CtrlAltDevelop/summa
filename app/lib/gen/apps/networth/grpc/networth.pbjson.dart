// This is a generated file - do not edit.
//
// Generated from apps/networth/grpc/networth.proto.

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

@$core.Deprecated('Use basketCreateDescriptor instead')
const BasketCreate$json = {
  '1': 'BasketCreate',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'target_minor', '3': 2, '4': 1, '5': 3, '10': 'targetMinor'},
    {
      '1': 'items',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.config.networth.BasketItemRefMsg',
      '10': 'items'
    },
    {
      '1': 'client_mutation_id',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'clientMutationId'
    },
  ],
};

/// Descriptor for `BasketCreate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List basketCreateDescriptor = $convert.base64Decode(
    'CgxCYXNrZXRDcmVhdGUSEgoEbmFtZRgBIAEoCVIEbmFtZRIhCgx0YXJnZXRfbWlub3IYAiABKA'
    'NSC3RhcmdldE1pbm9yEjcKBWl0ZW1zGAMgAygLMiEuY29uZmlnLm5ldHdvcnRoLkJhc2tldEl0'
    'ZW1SZWZNc2dSBWl0ZW1zEiwKEmNsaWVudF9tdXRhdGlvbl9pZBgEIAEoCVIQY2xpZW50TXV0YX'
    'Rpb25JZA==');

@$core.Deprecated('Use basketItemMsgDescriptor instead')
const BasketItemMsg$json = {
  '1': 'BasketItemMsg',
  '2': [
    {'1': 'kind', '3': 1, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'ref_id', '3': 2, '4': 1, '5': 9, '10': 'refId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'value_minor', '3': 4, '4': 1, '5': 3, '10': 'valueMinor'},
  ],
};

/// Descriptor for `BasketItemMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List basketItemMsgDescriptor = $convert.base64Decode(
    'Cg1CYXNrZXRJdGVtTXNnEhIKBGtpbmQYASABKAlSBGtpbmQSFQoGcmVmX2lkGAIgASgJUgVyZW'
    'ZJZBISCgRuYW1lGAMgASgJUgRuYW1lEh8KC3ZhbHVlX21pbm9yGAQgASgDUgp2YWx1ZU1pbm9y');

@$core.Deprecated('Use basketItemRefMsgDescriptor instead')
const BasketItemRefMsg$json = {
  '1': 'BasketItemRefMsg',
  '2': [
    {'1': 'kind', '3': 1, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'ref_id', '3': 2, '4': 1, '5': 9, '10': 'refId'},
  ],
};

/// Descriptor for `BasketItemRefMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List basketItemRefMsgDescriptor = $convert.base64Decode(
    'ChBCYXNrZXRJdGVtUmVmTXNnEhIKBGtpbmQYASABKAlSBGtpbmQSFQoGcmVmX2lkGAIgASgJUg'
    'VyZWZJZA==');

@$core.Deprecated('Use basketListReplyDescriptor instead')
const BasketListReply$json = {
  '1': 'BasketListReply',
  '2': [
    {
      '1': 'baskets',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.networth.BasketMsg',
      '10': 'baskets'
    },
  ],
};

/// Descriptor for `BasketListReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List basketListReplyDescriptor = $convert.base64Decode(
    'Cg9CYXNrZXRMaXN0UmVwbHkSNAoHYmFza2V0cxgBIAMoCzIaLmNvbmZpZy5uZXR3b3J0aC5CYX'
    'NrZXRNc2dSB2Jhc2tldHM=');

@$core.Deprecated('Use basketMsgDescriptor instead')
const BasketMsg$json = {
  '1': 'BasketMsg',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'target_minor', '3': 3, '4': 1, '5': 3, '10': 'targetMinor'},
    {'1': 'value_minor', '3': 4, '4': 1, '5': 3, '10': 'valueMinor'},
    {'1': 'percent', '3': 5, '4': 1, '5': 3, '10': 'percent'},
    {
      '1': 'items',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.config.networth.BasketItemMsg',
      '10': 'items'
    },
  ],
};

/// Descriptor for `BasketMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List basketMsgDescriptor = $convert.base64Decode(
    'CglCYXNrZXRNc2cSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSIQoMdGFyZ2'
    'V0X21pbm9yGAMgASgDUgt0YXJnZXRNaW5vchIfCgt2YWx1ZV9taW5vchgEIAEoA1IKdmFsdWVN'
    'aW5vchIYCgdwZXJjZW50GAUgASgDUgdwZXJjZW50EjQKBWl0ZW1zGAYgAygLMh4uY29uZmlnLm'
    '5ldHdvcnRoLkJhc2tldEl0ZW1Nc2dSBWl0ZW1z');

@$core.Deprecated('Use basketRefDescriptor instead')
const BasketRef$json = {
  '1': 'BasketRef',
  '2': [
    {'1': 'basket_id', '3': 1, '4': 1, '5': 9, '10': 'basketId'},
  ],
};

/// Descriptor for `BasketRef`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List basketRefDescriptor = $convert
    .base64Decode('CglCYXNrZXRSZWYSGwoJYmFza2V0X2lkGAEgASgJUghiYXNrZXRJZA==');

@$core.Deprecated('Use basketReplyDescriptor instead')
const BasketReply$json = {
  '1': 'BasketReply',
  '2': [
    {
      '1': 'basket',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.config.networth.BasketMsg',
      '10': 'basket'
    },
  ],
};

/// Descriptor for `BasketReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List basketReplyDescriptor = $convert.base64Decode(
    'CgtCYXNrZXRSZXBseRIyCgZiYXNrZXQYASABKAsyGi5jb25maWcubmV0d29ydGguQmFza2V0TX'
    'NnUgZiYXNrZXQ=');

@$core.Deprecated('Use historyPointMsgDescriptor instead')
const HistoryPointMsg$json = {
  '1': 'HistoryPointMsg',
  '2': [
    {'1': 'date', '3': 1, '4': 1, '5': 9, '10': 'date'},
    {'1': 'total_minor', '3': 2, '4': 1, '5': 3, '10': 'totalMinor'},
  ],
};

/// Descriptor for `HistoryPointMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List historyPointMsgDescriptor = $convert.base64Decode(
    'Cg9IaXN0b3J5UG9pbnRNc2cSEgoEZGF0ZRgBIAEoCVIEZGF0ZRIfCgt0b3RhbF9taW5vchgCIA'
    'EoA1IKdG90YWxNaW5vcg==');

@$core.Deprecated('Use historyReplyDescriptor instead')
const HistoryReply$json = {
  '1': 'HistoryReply',
  '2': [
    {
      '1': 'points',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.networth.HistoryPointMsg',
      '10': 'points'
    },
  ],
};

/// Descriptor for `HistoryReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List historyReplyDescriptor = $convert.base64Decode(
    'CgxIaXN0b3J5UmVwbHkSOAoGcG9pbnRzGAEgAygLMiAuY29uZmlnLm5ldHdvcnRoLkhpc3Rvcn'
    'lQb2ludE1zZ1IGcG9pbnRz');

@$core.Deprecated('Use historyRequestDescriptor instead')
const HistoryRequest$json = {
  '1': 'HistoryRequest',
  '2': [
    {'1': 'days', '3': 1, '4': 1, '5': 5, '10': 'days'},
  ],
};

/// Descriptor for `HistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List historyRequestDescriptor =
    $convert.base64Decode('Cg5IaXN0b3J5UmVxdWVzdBISCgRkYXlzGAEgASgFUgRkYXlz');

@$core.Deprecated('Use netWorthReplyDescriptor instead')
const NetWorthReply$json = {
  '1': 'NetWorthReply',
  '2': [
    {'1': 'total_minor', '3': 1, '4': 1, '5': 3, '10': 'totalMinor'},
    {'1': 'wallets_minor', '3': 2, '4': 1, '5': 3, '10': 'walletsMinor'},
    {'1': 'assets_minor', '3': 3, '4': 1, '5': 3, '10': 'assetsMinor'},
    {'1': 'debts_minor', '3': 4, '4': 1, '5': 3, '10': 'debtsMinor'},
    {'1': 'usd_present', '3': 5, '4': 1, '5': 8, '10': 'usdPresent'},
    {'1': 'usd_minor', '3': 6, '4': 1, '5': 3, '10': 'usdMinor'},
    {'1': 'gold_grams', '3': 7, '4': 1, '5': 9, '10': 'goldGrams'},
    {'1': 'stale', '3': 8, '4': 1, '5': 8, '10': 'stale'},
    {'1': 'unconverted', '3': 9, '4': 3, '5': 9, '10': 'unconverted'},
    {'1': 'unpriced_assets', '3': 10, '4': 1, '5': 5, '10': 'unpricedAssets'},
  ],
};

/// Descriptor for `NetWorthReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List netWorthReplyDescriptor = $convert.base64Decode(
    'Cg1OZXRXb3J0aFJlcGx5Eh8KC3RvdGFsX21pbm9yGAEgASgDUgp0b3RhbE1pbm9yEiMKDXdhbG'
    'xldHNfbWlub3IYAiABKANSDHdhbGxldHNNaW5vchIhCgxhc3NldHNfbWlub3IYAyABKANSC2Fz'
    'c2V0c01pbm9yEh8KC2RlYnRzX21pbm9yGAQgASgDUgpkZWJ0c01pbm9yEh8KC3VzZF9wcmVzZW'
    '50GAUgASgIUgp1c2RQcmVzZW50EhsKCXVzZF9taW5vchgGIAEoA1IIdXNkTWlub3ISHQoKZ29s'
    'ZF9ncmFtcxgHIAEoCVIJZ29sZEdyYW1zEhQKBXN0YWxlGAggASgIUgVzdGFsZRIgCgt1bmNvbn'
    'ZlcnRlZBgJIAMoCVILdW5jb252ZXJ0ZWQSJwoPdW5wcmljZWRfYXNzZXRzGAogASgFUg51bnBy'
    'aWNlZEFzc2V0cw==');
