// This is a generated file - do not edit.
//
// Generated from apps/billing/grpc/billing.proto.

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

@$core.Deprecated('Use checkoutReplyDescriptor instead')
const CheckoutReply$json = {
  '1': 'CheckoutReply',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'pay_url', '3': 3, '4': 1, '5': 9, '10': 'payUrl'},
  ],
};

/// Descriptor for `CheckoutReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkoutReplyDescriptor = $convert.base64Decode(
    'Cg1DaGVja291dFJlcGx5Eh0KCnBheW1lbnRfaWQYASABKAlSCXBheW1lbnRJZBIcCglyZWZlcm'
    'VuY2UYAiABKAlSCXJlZmVyZW5jZRIXCgdwYXlfdXJsGAMgASgJUgZwYXlVcmw=');

@$core.Deprecated('Use checkoutRequestDescriptor instead')
const CheckoutRequest$json = {
  '1': 'CheckoutRequest',
  '2': [
    {'1': 'plan_code', '3': 1, '4': 1, '5': 9, '10': 'planCode'},
  ],
};

/// Descriptor for `CheckoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkoutRequestDescriptor = $convert.base64Decode(
    'Cg9DaGVja291dFJlcXVlc3QSGwoJcGxhbl9jb2RlGAEgASgJUghwbGFuQ29kZQ==');

@$core.Deprecated('Use planListReplyDescriptor instead')
const PlanListReply$json = {
  '1': 'PlanListReply',
  '2': [
    {
      '1': 'plans',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.config.billing.PlanMsg',
      '10': 'plans'
    },
  ],
};

/// Descriptor for `PlanListReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List planListReplyDescriptor = $convert.base64Decode(
    'Cg1QbGFuTGlzdFJlcGx5Ei0KBXBsYW5zGAEgAygLMhcuY29uZmlnLmJpbGxpbmcuUGxhbk1zZ1'
    'IFcGxhbnM=');

@$core.Deprecated('Use planMsgDescriptor instead')
const PlanMsg$json = {
  '1': 'PlanMsg',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'price_minor', '3': 4, '4': 1, '5': 3, '10': 'priceMinor'},
    {'1': 'period_days', '3': 5, '4': 1, '5': 5, '10': 'periodDays'},
  ],
};

/// Descriptor for `PlanMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List planMsgDescriptor = $convert.base64Decode(
    'CgdQbGFuTXNnEhIKBGNvZGUYASABKAlSBGNvZGUSEgoEbmFtZRgCIAEoCVIEbmFtZRIgCgtkZX'
    'NjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SHwoLcHJpY2VfbWlub3IYBCABKANSCnByaWNl'
    'TWlub3ISHwoLcGVyaW9kX2RheXMYBSABKAVSCnBlcmlvZERheXM=');

@$core.Deprecated('Use statusReplyDescriptor instead')
const StatusReply$json = {
  '1': 'StatusReply',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'ends_at', '3': 2, '4': 1, '5': 9, '10': 'endsAt'},
    {'1': 'days_left', '3': 3, '4': 1, '5': 5, '10': 'daysLeft'},
    {'1': 'plan_code', '3': 4, '4': 1, '5': 9, '10': 'planCode'},
    {'1': 'can_write', '3': 5, '4': 1, '5': 8, '10': 'canWrite'},
    {'1': 'trial_available', '3': 6, '4': 1, '5': 8, '10': 'trialAvailable'},
  ],
};

/// Descriptor for `StatusReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusReplyDescriptor = $convert.base64Decode(
    'CgtTdGF0dXNSZXBseRIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIXCgdlbmRzX2F0GAIgASgJUg'
    'ZlbmRzQXQSGwoJZGF5c19sZWZ0GAMgASgFUghkYXlzTGVmdBIbCglwbGFuX2NvZGUYBCABKAlS'
    'CHBsYW5Db2RlEhsKCWNhbl93cml0ZRgFIAEoCFIIY2FuV3JpdGUSJwoPdHJpYWxfYXZhaWxhYm'
    'xlGAYgASgIUg50cmlhbEF2YWlsYWJsZQ==');

@$core.Deprecated('Use verifyRequestDescriptor instead')
const VerifyRequest$json = {
  '1': 'VerifyRequest',
  '2': [
    {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `VerifyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyRequestDescriptor = $convert.base64Decode(
    'Cg1WZXJpZnlSZXF1ZXN0EhwKCXJlZmVyZW5jZRgBIAEoCVIJcmVmZXJlbmNl');
