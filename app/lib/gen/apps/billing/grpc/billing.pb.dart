// This is a generated file - do not edit.
//
// Generated from apps/billing/grpc/billing.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class CheckoutReply extends $pb.GeneratedMessage {
  factory CheckoutReply({
    $core.String? paymentId,
    $core.String? reference,
    $core.String? payUrl,
  }) {
    final result = CheckoutReply._();
    if (paymentId != null) result.paymentId = paymentId;
    if (reference != null) result.reference = reference;
    if (payUrl != null) result.payUrl = payUrl;
    return result;
  }

  CheckoutReply._();

  factory CheckoutReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckoutReply()..mergeFromBuffer(data, registry);
  factory CheckoutReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckoutReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckoutReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.billing'),
      createEmptyInstance: CheckoutReply.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..aOS(2, _omitFieldNames ? '' : 'reference')
    ..aOS(3, _omitFieldNames ? '' : 'payUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckoutReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckoutReply copyWith(void Function(CheckoutReply) updates) =>
      super.copyWith((message) => updates(message as CheckoutReply))
          as CheckoutReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CheckoutReply() / CheckoutReply.new instead')
  static CheckoutReply create() => CheckoutReply._();
  static $pb.GeneratedMessage $_createMessage() => CheckoutReply._();
  @$core.override
  CheckoutReply createEmptyInstance() => CheckoutReply._();
  @$core.pragma('dart2js:noInline')
  static CheckoutReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckoutReply>(
          CheckoutReply.$_createMessage);
  static CheckoutReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get payUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set payUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPayUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayUrl() => $_clearField(3);
}

class CheckoutRequest extends $pb.GeneratedMessage {
  factory CheckoutRequest({
    $core.String? planCode,
  }) {
    final result = CheckoutRequest._();
    if (planCode != null) result.planCode = planCode;
    return result;
  }

  CheckoutRequest._();

  factory CheckoutRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckoutRequest()..mergeFromBuffer(data, registry);
  factory CheckoutRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckoutRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckoutRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.billing'),
      createEmptyInstance: CheckoutRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'planCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckoutRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckoutRequest copyWith(void Function(CheckoutRequest) updates) =>
      super.copyWith((message) => updates(message as CheckoutRequest))
          as CheckoutRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CheckoutRequest() / CheckoutRequest.new instead')
  static CheckoutRequest create() => CheckoutRequest._();
  static $pb.GeneratedMessage $_createMessage() => CheckoutRequest._();
  @$core.override
  CheckoutRequest createEmptyInstance() => CheckoutRequest._();
  @$core.pragma('dart2js:noInline')
  static CheckoutRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckoutRequest>(
          CheckoutRequest.$_createMessage);
  static CheckoutRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get planCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set planCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPlanCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlanCode() => $_clearField(1);
}

class PlanListReply extends $pb.GeneratedMessage {
  factory PlanListReply({
    $core.Iterable<PlanMsg>? plans,
  }) {
    final result = PlanListReply._();
    if (plans != null) result.plans.addAll(plans);
    return result;
  }

  PlanListReply._();

  factory PlanListReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PlanListReply()..mergeFromBuffer(data, registry);
  factory PlanListReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PlanListReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlanListReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.billing'),
      createEmptyInstance: PlanListReply.$_createMessage)
    ..pPM<PlanMsg>(1, _omitFieldNames ? '' : 'plans',
        subBuilder: PlanMsg.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlanListReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlanListReply copyWith(void Function(PlanListReply) updates) =>
      super.copyWith((message) => updates(message as PlanListReply))
          as PlanListReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PlanListReply() / PlanListReply.new instead')
  static PlanListReply create() => PlanListReply._();
  static $pb.GeneratedMessage $_createMessage() => PlanListReply._();
  @$core.override
  PlanListReply createEmptyInstance() => PlanListReply._();
  @$core.pragma('dart2js:noInline')
  static PlanListReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlanListReply>(
          PlanListReply.$_createMessage);
  static PlanListReply? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PlanMsg> get plans => $_getList(0);
}

class PlanMsg extends $pb.GeneratedMessage {
  factory PlanMsg({
    $core.String? code,
    $core.String? name,
    $core.String? description,
    $fixnum.Int64? priceMinor,
    $core.int? periodDays,
  }) {
    final result = PlanMsg._();
    if (code != null) result.code = code;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (priceMinor != null) result.priceMinor = priceMinor;
    if (periodDays != null) result.periodDays = periodDays;
    return result;
  }

  PlanMsg._();

  factory PlanMsg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PlanMsg()..mergeFromBuffer(data, registry);
  factory PlanMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PlanMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlanMsg',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.billing'),
      createEmptyInstance: PlanMsg.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aInt64(4, _omitFieldNames ? '' : 'priceMinor')
    ..aI(5, _omitFieldNames ? '' : 'periodDays')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlanMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlanMsg copyWith(void Function(PlanMsg) updates) =>
      super.copyWith((message) => updates(message as PlanMsg)) as PlanMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PlanMsg() / PlanMsg.new instead')
  static PlanMsg create() => PlanMsg._();
  static $pb.GeneratedMessage $_createMessage() => PlanMsg._();
  @$core.override
  PlanMsg createEmptyInstance() => PlanMsg._();
  @$core.pragma('dart2js:noInline')
  static PlanMsg getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlanMsg>(PlanMsg.$_createMessage);
  static PlanMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get priceMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set priceMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPriceMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearPriceMinor() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get periodDays => $_getIZ(4);
  @$pb.TagNumber(5)
  set periodDays($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPeriodDays() => $_has(4);
  @$pb.TagNumber(5)
  void clearPeriodDays() => $_clearField(5);
}

class StatusReply extends $pb.GeneratedMessage {
  factory StatusReply({
    $core.String? status,
    $core.String? endsAt,
    $core.int? daysLeft,
    $core.String? planCode,
    $core.bool? canWrite,
    $core.bool? trialAvailable,
  }) {
    final result = StatusReply._();
    if (status != null) result.status = status;
    if (endsAt != null) result.endsAt = endsAt;
    if (daysLeft != null) result.daysLeft = daysLeft;
    if (planCode != null) result.planCode = planCode;
    if (canWrite != null) result.canWrite = canWrite;
    if (trialAvailable != null) result.trialAvailable = trialAvailable;
    return result;
  }

  StatusReply._();

  factory StatusReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StatusReply()..mergeFromBuffer(data, registry);
  factory StatusReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StatusReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StatusReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.billing'),
      createEmptyInstance: StatusReply.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOS(2, _omitFieldNames ? '' : 'endsAt')
    ..aI(3, _omitFieldNames ? '' : 'daysLeft')
    ..aOS(4, _omitFieldNames ? '' : 'planCode')
    ..aOB(5, _omitFieldNames ? '' : 'canWrite')
    ..aOB(6, _omitFieldNames ? '' : 'trialAvailable')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatusReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatusReply copyWith(void Function(StatusReply) updates) =>
      super.copyWith((message) => updates(message as StatusReply))
          as StatusReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use StatusReply() / StatusReply.new instead')
  static StatusReply create() => StatusReply._();
  static $pb.GeneratedMessage $_createMessage() => StatusReply._();
  @$core.override
  StatusReply createEmptyInstance() => StatusReply._();
  @$core.pragma('dart2js:noInline')
  static StatusReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StatusReply>(
          StatusReply.$_createMessage);
  static StatusReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get endsAt => $_getSZ(1);
  @$pb.TagNumber(2)
  set endsAt($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEndsAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndsAt() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get daysLeft => $_getIZ(2);
  @$pb.TagNumber(3)
  set daysLeft($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDaysLeft() => $_has(2);
  @$pb.TagNumber(3)
  void clearDaysLeft() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get planCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set planCode($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPlanCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearPlanCode() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get canWrite => $_getBF(4);
  @$pb.TagNumber(5)
  set canWrite($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCanWrite() => $_has(4);
  @$pb.TagNumber(5)
  void clearCanWrite() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get trialAvailable => $_getBF(5);
  @$pb.TagNumber(6)
  set trialAvailable($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTrialAvailable() => $_has(5);
  @$pb.TagNumber(6)
  void clearTrialAvailable() => $_clearField(6);
}

class VerifyRequest extends $pb.GeneratedMessage {
  factory VerifyRequest({
    $core.String? reference,
  }) {
    final result = VerifyRequest._();
    if (reference != null) result.reference = reference;
    return result;
  }

  VerifyRequest._();

  factory VerifyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      VerifyRequest()..mergeFromBuffer(data, registry);
  factory VerifyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      VerifyRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.billing'),
      createEmptyInstance: VerifyRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'reference')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyRequest copyWith(void Function(VerifyRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyRequest))
          as VerifyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use VerifyRequest() / VerifyRequest.new instead')
  static VerifyRequest create() => VerifyRequest._();
  static $pb.GeneratedMessage $_createMessage() => VerifyRequest._();
  @$core.override
  VerifyRequest createEmptyInstance() => VerifyRequest._();
  @$core.pragma('dart2js:noInline')
  static VerifyRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyRequest>(
          VerifyRequest.$_createMessage);
  static VerifyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reference => $_getSZ(0);
  @$pb.TagNumber(1)
  set reference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
