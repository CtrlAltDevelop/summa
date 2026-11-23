// This is a generated file - do not edit.
//
// Generated from apps/privacy/grpc/privacy.proto.

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

@$core.Deprecated('Use chatRetentionDescriptor instead')
const ChatRetention$json = {
  '1': 'ChatRetention',
  '2': [
    {'1': 'days', '3': 1, '4': 1, '5': 5, '10': 'days'},
  ],
};

/// Descriptor for `ChatRetention`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatRetentionDescriptor =
    $convert.base64Decode('Cg1DaGF0UmV0ZW50aW9uEhIKBGRheXMYASABKAVSBGRheXM=');

@$core.Deprecated('Use deleteConfirmationDescriptor instead')
const DeleteConfirmation$json = {
  '1': 'DeleteConfirmation',
  '2': [
    {'1': 'confirmation', '3': 1, '4': 1, '5': 9, '10': 'confirmation'},
  ],
};

/// Descriptor for `DeleteConfirmation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteConfirmationDescriptor = $convert.base64Decode(
    'ChJEZWxldGVDb25maXJtYXRpb24SIgoMY29uZmlybWF0aW9uGAEgASgJUgxjb25maXJtYXRpb2'
    '4=');

@$core.Deprecated('Use privacySettingsDescriptor instead')
const PrivacySettings$json = {
  '1': 'PrivacySettings',
  '2': [
    {
      '1': 'chat_retention_days',
      '3': 1,
      '4': 1,
      '5': 5,
      '10': 'chatRetentionDays'
    },
  ],
};

/// Descriptor for `PrivacySettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List privacySettingsDescriptor = $convert.base64Decode(
    'Cg9Qcml2YWN5U2V0dGluZ3MSLgoTY2hhdF9yZXRlbnRpb25fZGF5cxgBIAEoBVIRY2hhdFJldG'
    'VudGlvbkRheXM=');
