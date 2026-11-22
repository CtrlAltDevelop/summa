// This is a generated file - do not edit.
//
// Generated from infrastructure/auth/sms_code/grpc/auth_sms_code.proto.

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

@$core.Deprecated('Use challengeDescriptor instead')
const Challenge$json = {
  '1': 'Challenge',
  '2': [
    {'1': 'ticket', '3': 1, '4': 1, '5': 9, '10': 'ticket'},
    {'1': 'channel', '3': 2, '4': 1, '5': 9, '10': 'channel'},
    {'1': 'destination', '3': 3, '4': 1, '5': 9, '10': 'destination'},
    {'1': 'expires_in', '3': 4, '4': 1, '5': 5, '10': 'expiresIn'},
  ],
};

/// Descriptor for `Challenge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List challengeDescriptor = $convert.base64Decode(
    'CglDaGFsbGVuZ2USFgoGdGlja2V0GAEgASgJUgZ0aWNrZXQSGAoHY2hhbm5lbBgCIAEoCVIHY2'
    'hhbm5lbBIgCgtkZXN0aW5hdGlvbhgDIAEoCVILZGVzdGluYXRpb24SHQoKZXhwaXJlc19pbhgE'
    'IAEoBVIJZXhwaXJlc0lu');

@$core.Deprecated('Use credentialsDescriptor instead')
const Credentials$json = {
  '1': 'Credentials',
  '2': [
    {'1': 'token_type', '3': 1, '4': 1, '5': 9, '10': 'tokenType'},
    {'1': 'access_token', '3': 2, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 3, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_in', '3': 4, '4': 1, '5': 5, '10': 'expiresIn'},
    {'1': 'session_id', '3': 5, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `Credentials`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List credentialsDescriptor = $convert.base64Decode(
    'CgtDcmVkZW50aWFscxIdCgp0b2tlbl90eXBlGAEgASgJUgl0b2tlblR5cGUSIQoMYWNjZXNzX3'
    'Rva2VuGAIgASgJUgthY2Nlc3NUb2tlbhIjCg1yZWZyZXNoX3Rva2VuGAMgASgJUgxyZWZyZXNo'
    'VG9rZW4SHQoKZXhwaXJlc19pbhgEIAEoBVIJZXhwaXJlc0luEh0KCnNlc3Npb25faWQYBSABKA'
    'lSCXNlc3Npb25JZA==');

@$core.Deprecated('Use loginResultDescriptor instead')
const LoginResult$json = {
  '1': 'LoginResult',
  '2': [
    {
      '1': 'requires_second_factor',
      '3': 1,
      '4': 1,
      '5': 8,
      '10': 'requiresSecondFactor'
    },
    {
      '1': 'credentials',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.config.auth_sms_code.Credentials',
      '10': 'credentials'
    },
    {'1': 'login_ticket', '3': 3, '4': 1, '5': 9, '10': 'loginTicket'},
    {'1': 'methods', '3': 4, '4': 3, '5': 9, '10': 'methods'},
  ],
};

/// Descriptor for `LoginResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResultDescriptor = $convert.base64Decode(
    'CgtMb2dpblJlc3VsdBI0ChZyZXF1aXJlc19zZWNvbmRfZmFjdG9yGAEgASgIUhRyZXF1aXJlc1'
    'NlY29uZEZhY3RvchJDCgtjcmVkZW50aWFscxgCIAEoCzIhLmNvbmZpZy5hdXRoX3Ntc19jb2Rl'
    'LkNyZWRlbnRpYWxzUgtjcmVkZW50aWFscxIhCgxsb2dpbl90aWNrZXQYAyABKAlSC2xvZ2luVG'
    'lja2V0EhgKB21ldGhvZHMYBCADKAlSB21ldGhvZHM=');

@$core.Deprecated('Use loginStartRequestDescriptor instead')
const LoginStartRequest$json = {
  '1': 'LoginStartRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
  ],
};

/// Descriptor for `LoginStartRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginStartRequestDescriptor = $convert
    .base64Decode('ChFMb2dpblN0YXJ0UmVxdWVzdBIUCgVwaG9uZRgBIAEoCVIFcGhvbmU=');

@$core.Deprecated('Use loginVerifyRequestDescriptor instead')
const LoginVerifyRequest$json = {
  '1': 'LoginVerifyRequest',
  '2': [
    {'1': 'ticket', '3': 1, '4': 1, '5': 9, '10': 'ticket'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `LoginVerifyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginVerifyRequestDescriptor = $convert.base64Decode(
    'ChJMb2dpblZlcmlmeVJlcXVlc3QSFgoGdGlja2V0GAEgASgJUgZ0aWNrZXQSEgoEY29kZRgCIA'
    'EoCVIEY29kZQ==');

@$core.Deprecated('Use logoutRequestDescriptor instead')
const LogoutRequest$json = {
  '1': 'LogoutRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `LogoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutRequestDescriptor = $convert
    .base64Decode('Cg1Mb2dvdXRSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbg==');

@$core.Deprecated('Use messageDescriptor instead')
const Message$json = {
  '1': 'Message',
  '2': [
    {'1': 'detail', '3': 1, '4': 1, '5': 9, '10': 'detail'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor =
    $convert.base64Decode('CgdNZXNzYWdlEhYKBmRldGFpbBgBIAEoCVIGZGV0YWls');

@$core.Deprecated('Use signupStartRequestDescriptor instead')
const SignupStartRequest$json = {
  '1': 'SignupStartRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
  ],
};

/// Descriptor for `SignupStartRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupStartRequestDescriptor = $convert
    .base64Decode('ChJTaWdudXBTdGFydFJlcXVlc3QSFAoFcGhvbmUYASABKAlSBXBob25l');

@$core.Deprecated('Use signupVerifyRequestDescriptor instead')
const SignupVerifyRequest$json = {
  '1': 'SignupVerifyRequest',
  '2': [
    {'1': 'ticket', '3': 1, '4': 1, '5': 9, '10': 'ticket'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `SignupVerifyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupVerifyRequestDescriptor = $convert.base64Decode(
    'ChNTaWdudXBWZXJpZnlSZXF1ZXN0EhYKBnRpY2tldBgBIAEoCVIGdGlja2V0EhIKBGNvZGUYAi'
    'ABKAlSBGNvZGU=');
