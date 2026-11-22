// This is a generated file - do not edit.
//
// Generated from infrastructure/auth/sms_code/grpc/auth_sms_code.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Challenge extends $pb.GeneratedMessage {
  factory Challenge({
    $core.String? ticket,
    $core.String? channel,
    $core.String? destination,
    $core.int? expiresIn,
  }) {
    final result = Challenge._();
    if (ticket != null) result.ticket = ticket;
    if (channel != null) result.channel = channel;
    if (destination != null) result.destination = destination;
    if (expiresIn != null) result.expiresIn = expiresIn;
    return result;
  }

  Challenge._();

  factory Challenge.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Challenge()..mergeFromBuffer(data, registry);
  factory Challenge.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Challenge()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Challenge',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'config.auth_sms_code'),
      createEmptyInstance: Challenge.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticket')
    ..aOS(2, _omitFieldNames ? '' : 'channel')
    ..aOS(3, _omitFieldNames ? '' : 'destination')
    ..aI(4, _omitFieldNames ? '' : 'expiresIn')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Challenge clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Challenge copyWith(void Function(Challenge) updates) =>
      super.copyWith((message) => updates(message as Challenge)) as Challenge;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Challenge() / Challenge.new instead')
  static Challenge create() => Challenge._();
  static $pb.GeneratedMessage $_createMessage() => Challenge._();
  @$core.override
  Challenge createEmptyInstance() => Challenge._();
  @$core.pragma('dart2js:noInline')
  static Challenge getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Challenge>(Challenge.$_createMessage);
  static Challenge? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticket => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticket($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicket() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicket() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get channel => $_getSZ(1);
  @$pb.TagNumber(2)
  set channel($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChannel() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannel() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get destination => $_getSZ(2);
  @$pb.TagNumber(3)
  set destination($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDestination() => $_has(2);
  @$pb.TagNumber(3)
  void clearDestination() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get expiresIn => $_getIZ(3);
  @$pb.TagNumber(4)
  set expiresIn($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExpiresIn() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresIn() => $_clearField(4);
}

class Credentials extends $pb.GeneratedMessage {
  factory Credentials({
    $core.String? tokenType,
    $core.String? accessToken,
    $core.String? refreshToken,
    $core.int? expiresIn,
    $core.String? sessionId,
  }) {
    final result = Credentials._();
    if (tokenType != null) result.tokenType = tokenType;
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (expiresIn != null) result.expiresIn = expiresIn;
    if (sessionId != null) result.sessionId = sessionId;
    return result;
  }

  Credentials._();

  factory Credentials.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Credentials()..mergeFromBuffer(data, registry);
  factory Credentials.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Credentials()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Credentials',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'config.auth_sms_code'),
      createEmptyInstance: Credentials.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'tokenType')
    ..aOS(2, _omitFieldNames ? '' : 'accessToken')
    ..aOS(3, _omitFieldNames ? '' : 'refreshToken')
    ..aI(4, _omitFieldNames ? '' : 'expiresIn')
    ..aOS(5, _omitFieldNames ? '' : 'sessionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Credentials clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Credentials copyWith(void Function(Credentials) updates) =>
      super.copyWith((message) => updates(message as Credentials))
          as Credentials;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Credentials() / Credentials.new instead')
  static Credentials create() => Credentials._();
  static $pb.GeneratedMessage $_createMessage() => Credentials._();
  @$core.override
  Credentials createEmptyInstance() => Credentials._();
  @$core.pragma('dart2js:noInline')
  static Credentials getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Credentials>(
          Credentials.$_createMessage);
  static Credentials? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tokenType => $_getSZ(0);
  @$pb.TagNumber(1)
  set tokenType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTokenType() => $_has(0);
  @$pb.TagNumber(1)
  void clearTokenType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accessToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set accessToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccessToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccessToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get refreshToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set refreshToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRefreshToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearRefreshToken() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get expiresIn => $_getIZ(3);
  @$pb.TagNumber(4)
  set expiresIn($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExpiresIn() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresIn() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get sessionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set sessionId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSessionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearSessionId() => $_clearField(5);
}

class LoginResult extends $pb.GeneratedMessage {
  factory LoginResult({
    $core.bool? requiresSecondFactor,
    Credentials? credentials,
    $core.String? loginTicket,
    $core.Iterable<$core.String>? methods,
  }) {
    final result = LoginResult._();
    if (requiresSecondFactor != null)
      result.requiresSecondFactor = requiresSecondFactor;
    if (credentials != null) result.credentials = credentials;
    if (loginTicket != null) result.loginTicket = loginTicket;
    if (methods != null) result.methods.addAll(methods);
    return result;
  }

  LoginResult._();

  factory LoginResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LoginResult()..mergeFromBuffer(data, registry);
  factory LoginResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LoginResult()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginResult',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'config.auth_sms_code'),
      createEmptyInstance: LoginResult.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'requiresSecondFactor')
    ..aOM<Credentials>(2, _omitFieldNames ? '' : 'credentials',
        subBuilder: Credentials.$_createMessage)
    ..aOS(3, _omitFieldNames ? '' : 'loginTicket')
    ..pPS(4, _omitFieldNames ? '' : 'methods')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginResult copyWith(void Function(LoginResult) updates) =>
      super.copyWith((message) => updates(message as LoginResult))
          as LoginResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use LoginResult() / LoginResult.new instead')
  static LoginResult create() => LoginResult._();
  static $pb.GeneratedMessage $_createMessage() => LoginResult._();
  @$core.override
  LoginResult createEmptyInstance() => LoginResult._();
  @$core.pragma('dart2js:noInline')
  static LoginResult getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginResult>(
          LoginResult.$_createMessage);
  static LoginResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get requiresSecondFactor => $_getBF(0);
  @$pb.TagNumber(1)
  set requiresSecondFactor($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRequiresSecondFactor() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequiresSecondFactor() => $_clearField(1);

  @$pb.TagNumber(2)
  Credentials get credentials => $_getN(1);
  @$pb.TagNumber(2)
  set credentials(Credentials value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCredentials() => $_has(1);
  @$pb.TagNumber(2)
  void clearCredentials() => $_clearField(2);
  @$pb.TagNumber(2)
  Credentials ensureCredentials() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get loginTicket => $_getSZ(2);
  @$pb.TagNumber(3)
  set loginTicket($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLoginTicket() => $_has(2);
  @$pb.TagNumber(3)
  void clearLoginTicket() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get methods => $_getList(3);
}

class LoginStartRequest extends $pb.GeneratedMessage {
  factory LoginStartRequest({
    $core.String? phone,
  }) {
    final result = LoginStartRequest._();
    if (phone != null) result.phone = phone;
    return result;
  }

  LoginStartRequest._();

  factory LoginStartRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LoginStartRequest()..mergeFromBuffer(data, registry);
  factory LoginStartRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LoginStartRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginStartRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'config.auth_sms_code'),
      createEmptyInstance: LoginStartRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'phone')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginStartRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginStartRequest copyWith(void Function(LoginStartRequest) updates) =>
      super.copyWith((message) => updates(message as LoginStartRequest))
          as LoginStartRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use LoginStartRequest() / LoginStartRequest.new instead')
  static LoginStartRequest create() => LoginStartRequest._();
  static $pb.GeneratedMessage $_createMessage() => LoginStartRequest._();
  @$core.override
  LoginStartRequest createEmptyInstance() => LoginStartRequest._();
  @$core.pragma('dart2js:noInline')
  static LoginStartRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginStartRequest>(
          LoginStartRequest.$_createMessage);
  static LoginStartRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => $_clearField(1);
}

class LoginVerifyRequest extends $pb.GeneratedMessage {
  factory LoginVerifyRequest({
    $core.String? ticket,
    $core.String? code,
  }) {
    final result = LoginVerifyRequest._();
    if (ticket != null) result.ticket = ticket;
    if (code != null) result.code = code;
    return result;
  }

  LoginVerifyRequest._();

  factory LoginVerifyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LoginVerifyRequest()..mergeFromBuffer(data, registry);
  factory LoginVerifyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LoginVerifyRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginVerifyRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'config.auth_sms_code'),
      createEmptyInstance: LoginVerifyRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticket')
    ..aOS(2, _omitFieldNames ? '' : 'code')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginVerifyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginVerifyRequest copyWith(void Function(LoginVerifyRequest) updates) =>
      super.copyWith((message) => updates(message as LoginVerifyRequest))
          as LoginVerifyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use LoginVerifyRequest() / LoginVerifyRequest.new instead')
  static LoginVerifyRequest create() => LoginVerifyRequest._();
  static $pb.GeneratedMessage $_createMessage() => LoginVerifyRequest._();
  @$core.override
  LoginVerifyRequest createEmptyInstance() => LoginVerifyRequest._();
  @$core.pragma('dart2js:noInline')
  static LoginVerifyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginVerifyRequest>(
          LoginVerifyRequest.$_createMessage);
  static LoginVerifyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticket => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticket($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicket() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicket() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => $_clearField(2);
}

class LogoutRequest extends $pb.GeneratedMessage {
  factory LogoutRequest({
    $core.String? token,
  }) {
    final result = LogoutRequest._();
    if (token != null) result.token = token;
    return result;
  }

  LogoutRequest._();

  factory LogoutRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LogoutRequest()..mergeFromBuffer(data, registry);
  factory LogoutRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LogoutRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogoutRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'config.auth_sms_code'),
      createEmptyInstance: LogoutRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutRequest copyWith(void Function(LogoutRequest) updates) =>
      super.copyWith((message) => updates(message as LogoutRequest))
          as LogoutRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use LogoutRequest() / LogoutRequest.new instead')
  static LogoutRequest create() => LogoutRequest._();
  static $pb.GeneratedMessage $_createMessage() => LogoutRequest._();
  @$core.override
  LogoutRequest createEmptyInstance() => LogoutRequest._();
  @$core.pragma('dart2js:noInline')
  static LogoutRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogoutRequest>(
          LogoutRequest.$_createMessage);
  static LogoutRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);
}

class Message extends $pb.GeneratedMessage {
  factory Message({
    $core.String? detail,
  }) {
    final result = Message._();
    if (detail != null) result.detail = detail;
    return result;
  }

  Message._();

  factory Message.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Message()..mergeFromBuffer(data, registry);
  factory Message.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Message()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Message',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'config.auth_sms_code'),
      createEmptyInstance: Message.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'detail')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Message clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Message copyWith(void Function(Message) updates) =>
      super.copyWith((message) => updates(message as Message)) as Message;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Message() / Message.new instead')
  static Message create() => Message._();
  static $pb.GeneratedMessage $_createMessage() => Message._();
  @$core.override
  Message createEmptyInstance() => Message._();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Message>(Message.$_createMessage);
  static Message? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get detail => $_getSZ(0);
  @$pb.TagNumber(1)
  set detail($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDetail() => $_has(0);
  @$pb.TagNumber(1)
  void clearDetail() => $_clearField(1);
}

class SignupStartRequest extends $pb.GeneratedMessage {
  factory SignupStartRequest({
    $core.String? phone,
  }) {
    final result = SignupStartRequest._();
    if (phone != null) result.phone = phone;
    return result;
  }

  SignupStartRequest._();

  factory SignupStartRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SignupStartRequest()..mergeFromBuffer(data, registry);
  factory SignupStartRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SignupStartRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignupStartRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'config.auth_sms_code'),
      createEmptyInstance: SignupStartRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'phone')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignupStartRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignupStartRequest copyWith(void Function(SignupStartRequest) updates) =>
      super.copyWith((message) => updates(message as SignupStartRequest))
          as SignupStartRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SignupStartRequest() / SignupStartRequest.new instead')
  static SignupStartRequest create() => SignupStartRequest._();
  static $pb.GeneratedMessage $_createMessage() => SignupStartRequest._();
  @$core.override
  SignupStartRequest createEmptyInstance() => SignupStartRequest._();
  @$core.pragma('dart2js:noInline')
  static SignupStartRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignupStartRequest>(
          SignupStartRequest.$_createMessage);
  static SignupStartRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => $_clearField(1);
}

class SignupVerifyRequest extends $pb.GeneratedMessage {
  factory SignupVerifyRequest({
    $core.String? ticket,
    $core.String? code,
  }) {
    final result = SignupVerifyRequest._();
    if (ticket != null) result.ticket = ticket;
    if (code != null) result.code = code;
    return result;
  }

  SignupVerifyRequest._();

  factory SignupVerifyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SignupVerifyRequest()..mergeFromBuffer(data, registry);
  factory SignupVerifyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SignupVerifyRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignupVerifyRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'config.auth_sms_code'),
      createEmptyInstance: SignupVerifyRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticket')
    ..aOS(2, _omitFieldNames ? '' : 'code')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignupVerifyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignupVerifyRequest copyWith(void Function(SignupVerifyRequest) updates) =>
      super.copyWith((message) => updates(message as SignupVerifyRequest))
          as SignupVerifyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use SignupVerifyRequest() / SignupVerifyRequest.new instead')
  static SignupVerifyRequest create() => SignupVerifyRequest._();
  static $pb.GeneratedMessage $_createMessage() => SignupVerifyRequest._();
  @$core.override
  SignupVerifyRequest createEmptyInstance() => SignupVerifyRequest._();
  @$core.pragma('dart2js:noInline')
  static SignupVerifyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignupVerifyRequest>(
          SignupVerifyRequest.$_createMessage);
  static SignupVerifyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticket => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticket($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicket() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicket() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
