// This is a generated file - do not edit.
//
// Generated from apps/assets/grpc/assets.proto.

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

@$core.Deprecated('Use assetCreateDescriptor instead')
const AssetCreate$json = {
  '1': 'AssetCreate',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'quantity', '3': 3, '4': 1, '5': 9, '10': 'quantity'},
    {'1': 'unit_price_minor', '3': 4, '4': 1, '5': 3, '10': 'unitPriceMinor'},
    {
      '1': 'manual_price_minor',
      '3': 5,
      '4': 1,
      '5': 3,
      '10': 'manualPriceMinor'
    },
    {'1': 'bought_on', '3': 6, '4': 1, '5': 9, '10': 'boughtOn'},
    {
      '1': 'client_mutation_id',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'clientMutationId'
    },
  ],
};

/// Descriptor for `AssetCreate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assetCreateDescriptor = $convert.base64Decode(
    'CgtBc3NldENyZWF0ZRIWCgZzeW1ib2wYASABKAlSBnN5bWJvbBISCgRuYW1lGAIgASgJUgRuYW'
    '1lEhoKCHF1YW50aXR5GAMgASgJUghxdWFudGl0eRIoChB1bml0X3ByaWNlX21pbm9yGAQgASgD'
    'Ug51bml0UHJpY2VNaW5vchIsChJtYW51YWxfcHJpY2VfbWlub3IYBSABKANSEG1hbnVhbFByaW'
    'NlTWlub3ISGwoJYm91Z2h0X29uGAYgASgJUghib3VnaHRPbhIsChJjbGllbnRfbXV0YXRpb25f'
    'aWQYByABKAlSEGNsaWVudE11dGF0aW9uSWQ=');

@$core.Deprecated('Use assetListReplyDescriptor instead')
const AssetListReply$json = {
  '1': 'AssetListReply',
  '2': [
    {
      '1': 'assets',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.assets.AssetMsg',
      '10': 'assets'
    },
    {'1': 'value_minor', '3': 2, '4': 1, '5': 3, '10': 'valueMinor'},
    {'1': 'cost_minor', '3': 3, '4': 1, '5': 3, '10': 'costMinor'},
    {'1': 'profit_minor', '3': 4, '4': 1, '5': 3, '10': 'profitMinor'},
    {'1': 'realized_minor', '3': 5, '4': 1, '5': 3, '10': 'realizedMinor'},
  ],
};

/// Descriptor for `AssetListReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assetListReplyDescriptor = $convert.base64Decode(
    'Cg5Bc3NldExpc3RSZXBseRIvCgZhc3NldHMYASADKAsyFy5jb25maWcuYXNzZXRzLkFzc2V0TX'
    'NnUgZhc3NldHMSHwoLdmFsdWVfbWlub3IYAiABKANSCnZhbHVlTWlub3ISHQoKY29zdF9taW5v'
    'chgDIAEoA1IJY29zdE1pbm9yEiEKDHByb2ZpdF9taW5vchgEIAEoA1ILcHJvZml0TWlub3ISJQ'
    'oOcmVhbGl6ZWRfbWlub3IYBSABKANSDXJlYWxpemVkTWlub3I=');

@$core.Deprecated('Use assetMsgDescriptor instead')
const AssetMsg$json = {
  '1': 'AssetMsg',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'unit', '3': 4, '4': 1, '5': 9, '10': 'unit'},
    {'1': 'quantity', '3': 5, '4': 1, '5': 9, '10': 'quantity'},
    {'1': 'cost_minor', '3': 6, '4': 1, '5': 3, '10': 'costMinor'},
    {'1': 'value_minor', '3': 7, '4': 1, '5': 3, '10': 'valueMinor'},
    {'1': 'profit_minor', '3': 8, '4': 1, '5': 3, '10': 'profitMinor'},
    {'1': 'realized_minor', '3': 9, '4': 1, '5': 3, '10': 'realizedMinor'},
    {'1': 'price', '3': 10, '4': 1, '5': 9, '10': 'price'},
    {'1': 'price_known', '3': 11, '4': 1, '5': 8, '10': 'priceKnown'},
    {'1': 'stale', '3': 12, '4': 1, '5': 8, '10': 'stale'},
  ],
};

/// Descriptor for `AssetMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assetMsgDescriptor = $convert.base64Decode(
    'CghBc3NldE1zZxIOCgJpZBgBIAEoCVICaWQSFgoGc3ltYm9sGAIgASgJUgZzeW1ib2wSEgoEbm'
    'FtZRgDIAEoCVIEbmFtZRISCgR1bml0GAQgASgJUgR1bml0EhoKCHF1YW50aXR5GAUgASgJUghx'
    'dWFudGl0eRIdCgpjb3N0X21pbm9yGAYgASgDUgljb3N0TWlub3ISHwoLdmFsdWVfbWlub3IYBy'
    'ABKANSCnZhbHVlTWlub3ISIQoMcHJvZml0X21pbm9yGAggASgDUgtwcm9maXRNaW5vchIlCg5y'
    'ZWFsaXplZF9taW5vchgJIAEoA1INcmVhbGl6ZWRNaW5vchIUCgVwcmljZRgKIAEoCVIFcHJpY2'
    'USHwoLcHJpY2Vfa25vd24YCyABKAhSCnByaWNlS25vd24SFAoFc3RhbGUYDCABKAhSBXN0YWxl');

@$core.Deprecated('Use assetRefDescriptor instead')
const AssetRef$json = {
  '1': 'AssetRef',
  '2': [
    {'1': 'asset_id', '3': 1, '4': 1, '5': 9, '10': 'assetId'},
  ],
};

/// Descriptor for `AssetRef`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assetRefDescriptor = $convert
    .base64Decode('CghBc3NldFJlZhIZCghhc3NldF9pZBgBIAEoCVIHYXNzZXRJZA==');

@$core.Deprecated('Use assetReplyDescriptor instead')
const AssetReply$json = {
  '1': 'AssetReply',
  '2': [
    {
      '1': 'asset',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.config.assets.AssetMsg',
      '10': 'asset'
    },
  ],
};

/// Descriptor for `AssetReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assetReplyDescriptor = $convert.base64Decode(
    'CgpBc3NldFJlcGx5Ei0KBWFzc2V0GAEgASgLMhcuY29uZmlnLmFzc2V0cy5Bc3NldE1zZ1IFYX'
    'NzZXQ=');

@$core.Deprecated('Use assetSellDescriptor instead')
const AssetSell$json = {
  '1': 'AssetSell',
  '2': [
    {'1': 'asset_id', '3': 1, '4': 1, '5': 9, '10': 'assetId'},
    {'1': 'quantity', '3': 2, '4': 1, '5': 9, '10': 'quantity'},
    {'1': 'unit_price_minor', '3': 3, '4': 1, '5': 3, '10': 'unitPriceMinor'},
  ],
};

/// Descriptor for `AssetSell`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assetSellDescriptor = $convert.base64Decode(
    'CglBc3NldFNlbGwSGQoIYXNzZXRfaWQYASABKAlSB2Fzc2V0SWQSGgoIcXVhbnRpdHkYAiABKA'
    'lSCHF1YW50aXR5EigKEHVuaXRfcHJpY2VfbWlub3IYAyABKANSDnVuaXRQcmljZU1pbm9y');

@$core.Deprecated('Use convertReplyDescriptor instead')
const ConvertReply$json = {
  '1': 'ConvertReply',
  '2': [
    {'1': 'amount_minor', '3': 1, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'stale', '3': 2, '4': 1, '5': 8, '10': 'stale'},
  ],
};

/// Descriptor for `ConvertReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertReplyDescriptor = $convert.base64Decode(
    'CgxDb252ZXJ0UmVwbHkSIQoMYW1vdW50X21pbm9yGAEgASgDUgthbW91bnRNaW5vchIUCgVzdG'
    'FsZRgCIAEoCFIFc3RhbGU=');

@$core.Deprecated('Use convertRequestDescriptor instead')
const ConvertRequest$json = {
  '1': 'ConvertRequest',
  '2': [
    {'1': 'amount_minor', '3': 1, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'from_currency', '3': 2, '4': 1, '5': 9, '10': 'fromCurrency'},
    {'1': 'to_currency', '3': 3, '4': 1, '5': 9, '10': 'toCurrency'},
  ],
};

/// Descriptor for `ConvertRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertRequestDescriptor = $convert.base64Decode(
    'Cg5Db252ZXJ0UmVxdWVzdBIhCgxhbW91bnRfbWlub3IYASABKANSC2Ftb3VudE1pbm9yEiMKDW'
    'Zyb21fY3VycmVuY3kYAiABKAlSDGZyb21DdXJyZW5jeRIfCgt0b19jdXJyZW5jeRgDIAEoCVIK'
    'dG9DdXJyZW5jeQ==');

@$core.Deprecated('Use lotAddDescriptor instead')
const LotAdd$json = {
  '1': 'LotAdd',
  '2': [
    {'1': 'asset_id', '3': 1, '4': 1, '5': 9, '10': 'assetId'},
    {'1': 'quantity', '3': 2, '4': 1, '5': 9, '10': 'quantity'},
    {'1': 'unit_price_minor', '3': 3, '4': 1, '5': 3, '10': 'unitPriceMinor'},
    {'1': 'bought_on', '3': 4, '4': 1, '5': 9, '10': 'boughtOn'},
  ],
};

/// Descriptor for `LotAdd`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lotAddDescriptor = $convert.base64Decode(
    'CgZMb3RBZGQSGQoIYXNzZXRfaWQYASABKAlSB2Fzc2V0SWQSGgoIcXVhbnRpdHkYAiABKAlSCH'
    'F1YW50aXR5EigKEHVuaXRfcHJpY2VfbWlub3IYAyABKANSDnVuaXRQcmljZU1pbm9yEhsKCWJv'
    'dWdodF9vbhgEIAEoCVIIYm91Z2h0T24=');

@$core.Deprecated('Use rateListReplyDescriptor instead')
const RateListReply$json = {
  '1': 'RateListReply',
  '2': [
    {
      '1': 'rates',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.assets.RateMsg',
      '10': 'rates'
    },
  ],
};

/// Descriptor for `RateListReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rateListReplyDescriptor = $convert.base64Decode(
    'Cg1SYXRlTGlzdFJlcGx5EiwKBXJhdGVzGAEgAygLMhYuY29uZmlnLmFzc2V0cy5SYXRlTXNnUg'
    'VyYXRlcw==');

@$core.Deprecated('Use rateMsgDescriptor instead')
const RateMsg$json = {
  '1': 'RateMsg',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'unit', '3': 3, '4': 1, '5': 9, '10': 'unit'},
    {'1': 'group', '3': 4, '4': 1, '5': 9, '10': 'group'},
    {'1': 'price', '3': 5, '4': 1, '5': 9, '10': 'price'},
    {'1': 'known', '3': 6, '4': 1, '5': 8, '10': 'known'},
    {'1': 'source', '3': 7, '4': 1, '5': 9, '10': 'source'},
    {'1': 'fetched_at', '3': 8, '4': 1, '5': 9, '10': 'fetchedAt'},
    {'1': 'age_seconds', '3': 9, '4': 1, '5': 3, '10': 'ageSeconds'},
    {'1': 'stale', '3': 10, '4': 1, '5': 8, '10': 'stale'},
  ],
};

/// Descriptor for `RateMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rateMsgDescriptor = $convert.base64Decode(
    'CgdSYXRlTXNnEhYKBnN5bWJvbBgBIAEoCVIGc3ltYm9sEhIKBG5hbWUYAiABKAlSBG5hbWUSEg'
    'oEdW5pdBgDIAEoCVIEdW5pdBIUCgVncm91cBgEIAEoCVIFZ3JvdXASFAoFcHJpY2UYBSABKAlS'
    'BXByaWNlEhQKBWtub3duGAYgASgIUgVrbm93bhIWCgZzb3VyY2UYByABKAlSBnNvdXJjZRIdCg'
    'pmZXRjaGVkX2F0GAggASgJUglmZXRjaGVkQXQSHwoLYWdlX3NlY29uZHMYCSABKANSCmFnZVNl'
    'Y29uZHMSFAoFc3RhbGUYCiABKAhSBXN0YWxl');
