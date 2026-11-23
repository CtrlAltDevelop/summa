// This is a generated file - do not edit.
//
// Generated from apps/reports/grpc/reports.proto.

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

@$core.Deprecated('Use categoryTotalMsgDescriptor instead')
const CategoryTotalMsg$json = {
  '1': 'CategoryTotalMsg',
  '2': [
    {'1': 'category_id', '3': 1, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'kind', '3': 3, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'total_minor', '3': 4, '4': 1, '5': 3, '10': 'totalMinor'},
  ],
};

/// Descriptor for `CategoryTotalMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryTotalMsgDescriptor = $convert.base64Decode(
    'ChBDYXRlZ29yeVRvdGFsTXNnEh8KC2NhdGVnb3J5X2lkGAEgASgJUgpjYXRlZ29yeUlkEhIKBG'
    '5hbWUYAiABKAlSBG5hbWUSEgoEa2luZBgDIAEoCVIEa2luZBIfCgt0b3RhbF9taW5vchgEIAEo'
    'A1IKdG90YWxNaW5vcg==');

@$core.Deprecated('Use dayTotalMsgDescriptor instead')
const DayTotalMsg$json = {
  '1': 'DayTotalMsg',
  '2': [
    {'1': 'day', '3': 1, '4': 1, '5': 9, '10': 'day'},
    {'1': 'income_minor', '3': 2, '4': 1, '5': 3, '10': 'incomeMinor'},
    {'1': 'expense_minor', '3': 3, '4': 1, '5': 3, '10': 'expenseMinor'},
  ],
};

/// Descriptor for `DayTotalMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dayTotalMsgDescriptor = $convert.base64Decode(
    'CgtEYXlUb3RhbE1zZxIQCgNkYXkYASABKAlSA2RheRIhCgxpbmNvbWVfbWlub3IYAiABKANSC2'
    'luY29tZU1pbm9yEiMKDWV4cGVuc2VfbWlub3IYAyABKANSDGV4cGVuc2VNaW5vcg==');

@$core.Deprecated('Use exportReplyDescriptor instead')
const ExportReply$json = {
  '1': 'ExportReply',
  '2': [
    {'1': 'filename', '3': 1, '4': 1, '5': 9, '10': 'filename'},
    {'1': 'content', '3': 2, '4': 1, '5': 12, '10': 'content'},
  ],
};

/// Descriptor for `ExportReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportReplyDescriptor = $convert.base64Decode(
    'CgtFeHBvcnRSZXBseRIaCghmaWxlbmFtZRgBIAEoCVIIZmlsZW5hbWUSGAoHY29udGVudBgCIA'
    'EoDFIHY29udGVudA==');

@$core.Deprecated('Use exportRequestDescriptor instead')
const ExportRequest$json = {
  '1': 'ExportRequest',
  '2': [
    {'1': 'starts_at', '3': 1, '4': 1, '5': 9, '10': 'startsAt'},
    {'1': 'ends_at', '3': 2, '4': 1, '5': 9, '10': 'endsAt'},
  ],
};

/// Descriptor for `ExportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportRequestDescriptor = $convert.base64Decode(
    'Cg1FeHBvcnRSZXF1ZXN0EhsKCXN0YXJ0c19hdBgBIAEoCVIIc3RhcnRzQXQSFwoHZW5kc19hdB'
    'gCIAEoCVIGZW5kc0F0');

@$core.Deprecated('Use reportReplyDescriptor instead')
const ReportReply$json = {
  '1': 'ReportReply',
  '2': [
    {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'income_minor', '3': 2, '4': 1, '5': 3, '10': 'incomeMinor'},
    {'1': 'expense_minor', '3': 3, '4': 1, '5': 3, '10': 'expenseMinor'},
    {'1': 'net_minor', '3': 4, '4': 1, '5': 3, '10': 'netMinor'},
    {'1': 'entries', '3': 5, '4': 1, '5': 5, '10': 'entries'},
    {
      '1': 'by_category',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.config.reports.CategoryTotalMsg',
      '10': 'byCategory'
    },
    {
      '1': 'daily',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.config.reports.DayTotalMsg',
      '10': 'daily'
    },
    {
      '1': 'top_expense_category',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'topExpenseCategory'
    },
    {'1': 'currencies', '3': 9, '4': 3, '5': 9, '10': 'currencies'},
  ],
};

/// Descriptor for `ReportReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reportReplyDescriptor = $convert.base64Decode(
    'CgtSZXBvcnRSZXBseRIaCghjdXJyZW5jeRgBIAEoCVIIY3VycmVuY3kSIQoMaW5jb21lX21pbm'
    '9yGAIgASgDUgtpbmNvbWVNaW5vchIjCg1leHBlbnNlX21pbm9yGAMgASgDUgxleHBlbnNlTWlu'
    'b3ISGwoJbmV0X21pbm9yGAQgASgDUghuZXRNaW5vchIYCgdlbnRyaWVzGAUgASgFUgdlbnRyaW'
    'VzEkEKC2J5X2NhdGVnb3J5GAYgAygLMiAuY29uZmlnLnJlcG9ydHMuQ2F0ZWdvcnlUb3RhbE1z'
    'Z1IKYnlDYXRlZ29yeRIxCgVkYWlseRgHIAMoCzIbLmNvbmZpZy5yZXBvcnRzLkRheVRvdGFsTX'
    'NnUgVkYWlseRIwChR0b3BfZXhwZW5zZV9jYXRlZ29yeRgIIAEoCVISdG9wRXhwZW5zZUNhdGVn'
    'b3J5Eh4KCmN1cnJlbmNpZXMYCSADKAlSCmN1cnJlbmNpZXM=');

@$core.Deprecated('Use reportRequestDescriptor instead')
const ReportRequest$json = {
  '1': 'ReportRequest',
  '2': [
    {'1': 'starts_at', '3': 1, '4': 1, '5': 9, '10': 'startsAt'},
    {'1': 'ends_at', '3': 2, '4': 1, '5': 9, '10': 'endsAt'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `ReportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reportRequestDescriptor = $convert.base64Decode(
    'Cg1SZXBvcnRSZXF1ZXN0EhsKCXN0YXJ0c19hdBgBIAEoCVIIc3RhcnRzQXQSFwoHZW5kc19hdB'
    'gCIAEoCVIGZW5kc0F0EhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeQ==');
