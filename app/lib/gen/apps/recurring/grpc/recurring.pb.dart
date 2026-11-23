// This is a generated file - do not edit.
//
// Generated from apps/recurring/grpc/recurring.proto.

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

class OccurrenceAnswer extends $pb.GeneratedMessage {
  factory OccurrenceAnswer({
    $core.String? occurrenceId,
    $core.String? action,
    $core.String? walletId,
    $fixnum.Int64? amountMinor,
  }) {
    final result = OccurrenceAnswer._();
    if (occurrenceId != null) result.occurrenceId = occurrenceId;
    if (action != null) result.action = action;
    if (walletId != null) result.walletId = walletId;
    if (amountMinor != null) result.amountMinor = amountMinor;
    return result;
  }

  OccurrenceAnswer._();

  factory OccurrenceAnswer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OccurrenceAnswer()..mergeFromBuffer(data, registry);
  factory OccurrenceAnswer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OccurrenceAnswer()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OccurrenceAnswer',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.recurring'),
      createEmptyInstance: OccurrenceAnswer.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'occurrenceId')
    ..aOS(2, _omitFieldNames ? '' : 'action')
    ..aOS(3, _omitFieldNames ? '' : 'walletId')
    ..aInt64(4, _omitFieldNames ? '' : 'amountMinor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OccurrenceAnswer clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OccurrenceAnswer copyWith(void Function(OccurrenceAnswer) updates) =>
      super.copyWith((message) => updates(message as OccurrenceAnswer))
          as OccurrenceAnswer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use OccurrenceAnswer() / OccurrenceAnswer.new instead')
  static OccurrenceAnswer create() => OccurrenceAnswer._();
  static $pb.GeneratedMessage $_createMessage() => OccurrenceAnswer._();
  @$core.override
  OccurrenceAnswer createEmptyInstance() => OccurrenceAnswer._();
  @$core.pragma('dart2js:noInline')
  static OccurrenceAnswer getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OccurrenceAnswer>(
          OccurrenceAnswer.$_createMessage);
  static OccurrenceAnswer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get occurrenceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set occurrenceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOccurrenceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOccurrenceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get action => $_getSZ(1);
  @$pb.TagNumber(2)
  set action($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearAction() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get walletId => $_getSZ(2);
  @$pb.TagNumber(3)
  set walletId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasWalletId() => $_has(2);
  @$pb.TagNumber(3)
  void clearWalletId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amountMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set amountMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmountMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountMinor() => $_clearField(4);
}

class OccurrenceMsg extends $pb.GeneratedMessage {
  factory OccurrenceMsg({
    $core.String? id,
    $core.String? recurringId,
    $core.String? walletId,
    $core.String? kind,
    $fixnum.Int64? amountMinor,
    $core.String? currency,
    $core.String? note,
    $core.String? dueDate,
    $core.String? status,
    $core.bool? lowBalance,
  }) {
    final result = OccurrenceMsg._();
    if (id != null) result.id = id;
    if (recurringId != null) result.recurringId = recurringId;
    if (walletId != null) result.walletId = walletId;
    if (kind != null) result.kind = kind;
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (currency != null) result.currency = currency;
    if (note != null) result.note = note;
    if (dueDate != null) result.dueDate = dueDate;
    if (status != null) result.status = status;
    if (lowBalance != null) result.lowBalance = lowBalance;
    return result;
  }

  OccurrenceMsg._();

  factory OccurrenceMsg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OccurrenceMsg()..mergeFromBuffer(data, registry);
  factory OccurrenceMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OccurrenceMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OccurrenceMsg',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.recurring'),
      createEmptyInstance: OccurrenceMsg.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'recurringId')
    ..aOS(3, _omitFieldNames ? '' : 'walletId')
    ..aOS(4, _omitFieldNames ? '' : 'kind')
    ..aInt64(5, _omitFieldNames ? '' : 'amountMinor')
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOS(7, _omitFieldNames ? '' : 'note')
    ..aOS(8, _omitFieldNames ? '' : 'dueDate')
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..aOB(10, _omitFieldNames ? '' : 'lowBalance')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OccurrenceMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OccurrenceMsg copyWith(void Function(OccurrenceMsg) updates) =>
      super.copyWith((message) => updates(message as OccurrenceMsg))
          as OccurrenceMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use OccurrenceMsg() / OccurrenceMsg.new instead')
  static OccurrenceMsg create() => OccurrenceMsg._();
  static $pb.GeneratedMessage $_createMessage() => OccurrenceMsg._();
  @$core.override
  OccurrenceMsg createEmptyInstance() => OccurrenceMsg._();
  @$core.pragma('dart2js:noInline')
  static OccurrenceMsg getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OccurrenceMsg>(
          OccurrenceMsg.$_createMessage);
  static OccurrenceMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get recurringId => $_getSZ(1);
  @$pb.TagNumber(2)
  set recurringId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRecurringId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecurringId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get walletId => $_getSZ(2);
  @$pb.TagNumber(3)
  set walletId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasWalletId() => $_has(2);
  @$pb.TagNumber(3)
  void clearWalletId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get kind => $_getSZ(3);
  @$pb.TagNumber(4)
  set kind($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasKind() => $_has(3);
  @$pb.TagNumber(4)
  void clearKind() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get amountMinor => $_getI64(4);
  @$pb.TagNumber(5)
  set amountMinor($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmountMinor() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountMinor() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get note => $_getSZ(6);
  @$pb.TagNumber(7)
  set note($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNote() => $_has(6);
  @$pb.TagNumber(7)
  void clearNote() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get dueDate => $_getSZ(7);
  @$pb.TagNumber(8)
  set dueDate($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDueDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearDueDate() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get lowBalance => $_getBF(9);
  @$pb.TagNumber(10)
  set lowBalance($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasLowBalance() => $_has(9);
  @$pb.TagNumber(10)
  void clearLowBalance() => $_clearField(10);
}

class RecurringActive extends $pb.GeneratedMessage {
  factory RecurringActive({
    $core.String? recurringId,
    $core.bool? active,
  }) {
    final result = RecurringActive._();
    if (recurringId != null) result.recurringId = recurringId;
    if (active != null) result.active = active;
    return result;
  }

  RecurringActive._();

  factory RecurringActive.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RecurringActive()..mergeFromBuffer(data, registry);
  factory RecurringActive.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RecurringActive()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecurringActive',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.recurring'),
      createEmptyInstance: RecurringActive.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'recurringId')
    ..aOB(2, _omitFieldNames ? '' : 'active')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringActive clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringActive copyWith(void Function(RecurringActive) updates) =>
      super.copyWith((message) => updates(message as RecurringActive))
          as RecurringActive;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RecurringActive() / RecurringActive.new instead')
  static RecurringActive create() => RecurringActive._();
  static $pb.GeneratedMessage $_createMessage() => RecurringActive._();
  @$core.override
  RecurringActive createEmptyInstance() => RecurringActive._();
  @$core.pragma('dart2js:noInline')
  static RecurringActive getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecurringActive>(
          RecurringActive.$_createMessage);
  static RecurringActive? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recurringId => $_getSZ(0);
  @$pb.TagNumber(1)
  set recurringId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecurringId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecurringId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get active => $_getBF(1);
  @$pb.TagNumber(2)
  set active($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActive() => $_has(1);
  @$pb.TagNumber(2)
  void clearActive() => $_clearField(2);
}

class RecurringCreate extends $pb.GeneratedMessage {
  factory RecurringCreate({
    $core.String? walletId,
    $core.String? kind,
    $fixnum.Int64? amountMinor,
    $core.String? categoryId,
    $core.String? note,
    $core.String? period,
    $core.int? day,
    $core.bool? autoConfirm,
    $core.String? clientMutationId,
  }) {
    final result = RecurringCreate._();
    if (walletId != null) result.walletId = walletId;
    if (kind != null) result.kind = kind;
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (categoryId != null) result.categoryId = categoryId;
    if (note != null) result.note = note;
    if (period != null) result.period = period;
    if (day != null) result.day = day;
    if (autoConfirm != null) result.autoConfirm = autoConfirm;
    if (clientMutationId != null) result.clientMutationId = clientMutationId;
    return result;
  }

  RecurringCreate._();

  factory RecurringCreate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RecurringCreate()..mergeFromBuffer(data, registry);
  factory RecurringCreate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RecurringCreate()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecurringCreate',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.recurring'),
      createEmptyInstance: RecurringCreate.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'walletId')
    ..aOS(2, _omitFieldNames ? '' : 'kind')
    ..aInt64(3, _omitFieldNames ? '' : 'amountMinor')
    ..aOS(4, _omitFieldNames ? '' : 'categoryId')
    ..aOS(5, _omitFieldNames ? '' : 'note')
    ..aOS(6, _omitFieldNames ? '' : 'period')
    ..aI(7, _omitFieldNames ? '' : 'day')
    ..aOB(8, _omitFieldNames ? '' : 'autoConfirm')
    ..aOS(9, _omitFieldNames ? '' : 'clientMutationId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringCreate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringCreate copyWith(void Function(RecurringCreate) updates) =>
      super.copyWith((message) => updates(message as RecurringCreate))
          as RecurringCreate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RecurringCreate() / RecurringCreate.new instead')
  static RecurringCreate create() => RecurringCreate._();
  static $pb.GeneratedMessage $_createMessage() => RecurringCreate._();
  @$core.override
  RecurringCreate createEmptyInstance() => RecurringCreate._();
  @$core.pragma('dart2js:noInline')
  static RecurringCreate getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecurringCreate>(
          RecurringCreate.$_createMessage);
  static RecurringCreate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletId => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWalletId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get kind => $_getSZ(1);
  @$pb.TagNumber(2)
  set kind($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amountMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set amountMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmountMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountMinor() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get categoryId => $_getSZ(3);
  @$pb.TagNumber(4)
  set categoryId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategoryId() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategoryId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get note => $_getSZ(4);
  @$pb.TagNumber(5)
  set note($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNote() => $_has(4);
  @$pb.TagNumber(5)
  void clearNote() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get period => $_getSZ(5);
  @$pb.TagNumber(6)
  set period($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPeriod() => $_has(5);
  @$pb.TagNumber(6)
  void clearPeriod() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get day => $_getIZ(6);
  @$pb.TagNumber(7)
  set day($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDay() => $_has(6);
  @$pb.TagNumber(7)
  void clearDay() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get autoConfirm => $_getBF(7);
  @$pb.TagNumber(8)
  set autoConfirm($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAutoConfirm() => $_has(7);
  @$pb.TagNumber(8)
  void clearAutoConfirm() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get clientMutationId => $_getSZ(8);
  @$pb.TagNumber(9)
  set clientMutationId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasClientMutationId() => $_has(8);
  @$pb.TagNumber(9)
  void clearClientMutationId() => $_clearField(9);
}

class RecurringListReply extends $pb.GeneratedMessage {
  factory RecurringListReply({
    $core.Iterable<RecurringMsg>? recurrings,
    $core.Iterable<OccurrenceMsg>? occurrences,
  }) {
    final result = RecurringListReply._();
    if (recurrings != null) result.recurrings.addAll(recurrings);
    if (occurrences != null) result.occurrences.addAll(occurrences);
    return result;
  }

  RecurringListReply._();

  factory RecurringListReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RecurringListReply()..mergeFromBuffer(data, registry);
  factory RecurringListReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RecurringListReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecurringListReply',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.recurring'),
      createEmptyInstance: RecurringListReply.$_createMessage)
    ..pPM<RecurringMsg>(1, _omitFieldNames ? '' : 'recurrings',
        subBuilder: RecurringMsg.$_createMessage)
    ..pPM<OccurrenceMsg>(2, _omitFieldNames ? '' : 'occurrences',
        subBuilder: OccurrenceMsg.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringListReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringListReply copyWith(void Function(RecurringListReply) updates) =>
      super.copyWith((message) => updates(message as RecurringListReply))
          as RecurringListReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RecurringListReply() / RecurringListReply.new instead')
  static RecurringListReply create() => RecurringListReply._();
  static $pb.GeneratedMessage $_createMessage() => RecurringListReply._();
  @$core.override
  RecurringListReply createEmptyInstance() => RecurringListReply._();
  @$core.pragma('dart2js:noInline')
  static RecurringListReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecurringListReply>(
          RecurringListReply.$_createMessage);
  static RecurringListReply? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RecurringMsg> get recurrings => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<OccurrenceMsg> get occurrences => $_getList(1);
}

class RecurringMsg extends $pb.GeneratedMessage {
  factory RecurringMsg({
    $core.String? id,
    $core.String? walletId,
    $core.String? kind,
    $fixnum.Int64? amountMinor,
    $core.String? currency,
    $core.String? categoryId,
    $core.String? note,
    $core.String? period,
    $core.int? day,
    $core.bool? autoConfirm,
    $core.bool? active,
    $core.String? nextDue,
  }) {
    final result = RecurringMsg._();
    if (id != null) result.id = id;
    if (walletId != null) result.walletId = walletId;
    if (kind != null) result.kind = kind;
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (currency != null) result.currency = currency;
    if (categoryId != null) result.categoryId = categoryId;
    if (note != null) result.note = note;
    if (period != null) result.period = period;
    if (day != null) result.day = day;
    if (autoConfirm != null) result.autoConfirm = autoConfirm;
    if (active != null) result.active = active;
    if (nextDue != null) result.nextDue = nextDue;
    return result;
  }

  RecurringMsg._();

  factory RecurringMsg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RecurringMsg()..mergeFromBuffer(data, registry);
  factory RecurringMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RecurringMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecurringMsg',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.recurring'),
      createEmptyInstance: RecurringMsg.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'walletId')
    ..aOS(3, _omitFieldNames ? '' : 'kind')
    ..aInt64(4, _omitFieldNames ? '' : 'amountMinor')
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'categoryId')
    ..aOS(7, _omitFieldNames ? '' : 'note')
    ..aOS(8, _omitFieldNames ? '' : 'period')
    ..aI(9, _omitFieldNames ? '' : 'day')
    ..aOB(10, _omitFieldNames ? '' : 'autoConfirm')
    ..aOB(11, _omitFieldNames ? '' : 'active')
    ..aOS(12, _omitFieldNames ? '' : 'nextDue')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringMsg copyWith(void Function(RecurringMsg) updates) =>
      super.copyWith((message) => updates(message as RecurringMsg))
          as RecurringMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RecurringMsg() / RecurringMsg.new instead')
  static RecurringMsg create() => RecurringMsg._();
  static $pb.GeneratedMessage $_createMessage() => RecurringMsg._();
  @$core.override
  RecurringMsg createEmptyInstance() => RecurringMsg._();
  @$core.pragma('dart2js:noInline')
  static RecurringMsg getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecurringMsg>(
          RecurringMsg.$_createMessage);
  static RecurringMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get walletId => $_getSZ(1);
  @$pb.TagNumber(2)
  set walletId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWalletId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWalletId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get kind => $_getSZ(2);
  @$pb.TagNumber(3)
  set kind($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasKind() => $_has(2);
  @$pb.TagNumber(3)
  void clearKind() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amountMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set amountMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmountMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountMinor() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get categoryId => $_getSZ(5);
  @$pb.TagNumber(6)
  set categoryId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCategoryId() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategoryId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get note => $_getSZ(6);
  @$pb.TagNumber(7)
  set note($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNote() => $_has(6);
  @$pb.TagNumber(7)
  void clearNote() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get period => $_getSZ(7);
  @$pb.TagNumber(8)
  set period($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPeriod() => $_has(7);
  @$pb.TagNumber(8)
  void clearPeriod() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get day => $_getIZ(8);
  @$pb.TagNumber(9)
  set day($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDay() => $_has(8);
  @$pb.TagNumber(9)
  void clearDay() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get autoConfirm => $_getBF(9);
  @$pb.TagNumber(10)
  set autoConfirm($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasAutoConfirm() => $_has(9);
  @$pb.TagNumber(10)
  void clearAutoConfirm() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get active => $_getBF(10);
  @$pb.TagNumber(11)
  set active($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasActive() => $_has(10);
  @$pb.TagNumber(11)
  void clearActive() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get nextDue => $_getSZ(11);
  @$pb.TagNumber(12)
  set nextDue($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasNextDue() => $_has(11);
  @$pb.TagNumber(12)
  void clearNextDue() => $_clearField(12);
}

class RecurringRef extends $pb.GeneratedMessage {
  factory RecurringRef({
    $core.String? recurringId,
  }) {
    final result = RecurringRef._();
    if (recurringId != null) result.recurringId = recurringId;
    return result;
  }

  RecurringRef._();

  factory RecurringRef.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RecurringRef()..mergeFromBuffer(data, registry);
  factory RecurringRef.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RecurringRef()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecurringRef',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.recurring'),
      createEmptyInstance: RecurringRef.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'recurringId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringRef clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringRef copyWith(void Function(RecurringRef) updates) =>
      super.copyWith((message) => updates(message as RecurringRef))
          as RecurringRef;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RecurringRef() / RecurringRef.new instead')
  static RecurringRef create() => RecurringRef._();
  static $pb.GeneratedMessage $_createMessage() => RecurringRef._();
  @$core.override
  RecurringRef createEmptyInstance() => RecurringRef._();
  @$core.pragma('dart2js:noInline')
  static RecurringRef getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecurringRef>(
          RecurringRef.$_createMessage);
  static RecurringRef? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recurringId => $_getSZ(0);
  @$pb.TagNumber(1)
  set recurringId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecurringId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecurringId() => $_clearField(1);
}

class RecurringReply extends $pb.GeneratedMessage {
  factory RecurringReply({
    RecurringMsg? recurring,
  }) {
    final result = RecurringReply._();
    if (recurring != null) result.recurring = recurring;
    return result;
  }

  RecurringReply._();

  factory RecurringReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RecurringReply()..mergeFromBuffer(data, registry);
  factory RecurringReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RecurringReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecurringReply',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.recurring'),
      createEmptyInstance: RecurringReply.$_createMessage)
    ..aOM<RecurringMsg>(1, _omitFieldNames ? '' : 'recurring',
        subBuilder: RecurringMsg.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringReply copyWith(void Function(RecurringReply) updates) =>
      super.copyWith((message) => updates(message as RecurringReply))
          as RecurringReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RecurringReply() / RecurringReply.new instead')
  static RecurringReply create() => RecurringReply._();
  static $pb.GeneratedMessage $_createMessage() => RecurringReply._();
  @$core.override
  RecurringReply createEmptyInstance() => RecurringReply._();
  @$core.pragma('dart2js:noInline')
  static RecurringReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecurringReply>(
          RecurringReply.$_createMessage);
  static RecurringReply? _defaultInstance;

  @$pb.TagNumber(1)
  RecurringMsg get recurring => $_getN(0);
  @$pb.TagNumber(1)
  set recurring(RecurringMsg value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRecurring() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecurring() => $_clearField(1);
  @$pb.TagNumber(1)
  RecurringMsg ensureRecurring() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
