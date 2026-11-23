// This is a generated file - do not edit.
//
// Generated from apps/debts/grpc/debts.proto.

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

class DebtCreate extends $pb.GeneratedMessage {
  factory DebtCreate({
    $core.String? kind,
    $core.String? title,
    $core.String? currency,
    $fixnum.Int64? installmentMinor,
    $core.int? count,
    $core.String? firstDue,
    $fixnum.Int64? principalMinor,
    $core.String? walletId,
    $core.String? categoryId,
    $core.String? clientMutationId,
  }) {
    final result = DebtCreate._();
    if (kind != null) result.kind = kind;
    if (title != null) result.title = title;
    if (currency != null) result.currency = currency;
    if (installmentMinor != null) result.installmentMinor = installmentMinor;
    if (count != null) result.count = count;
    if (firstDue != null) result.firstDue = firstDue;
    if (principalMinor != null) result.principalMinor = principalMinor;
    if (walletId != null) result.walletId = walletId;
    if (categoryId != null) result.categoryId = categoryId;
    if (clientMutationId != null) result.clientMutationId = clientMutationId;
    return result;
  }

  DebtCreate._();

  factory DebtCreate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DebtCreate()..mergeFromBuffer(data, registry);
  factory DebtCreate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DebtCreate()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DebtCreate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.debts'),
      createEmptyInstance: DebtCreate.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'kind')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aInt64(4, _omitFieldNames ? '' : 'installmentMinor')
    ..aI(5, _omitFieldNames ? '' : 'count')
    ..aOS(6, _omitFieldNames ? '' : 'firstDue')
    ..aInt64(7, _omitFieldNames ? '' : 'principalMinor')
    ..aOS(8, _omitFieldNames ? '' : 'walletId')
    ..aOS(9, _omitFieldNames ? '' : 'categoryId')
    ..aOS(10, _omitFieldNames ? '' : 'clientMutationId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DebtCreate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DebtCreate copyWith(void Function(DebtCreate) updates) =>
      super.copyWith((message) => updates(message as DebtCreate)) as DebtCreate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DebtCreate() / DebtCreate.new instead')
  static DebtCreate create() => DebtCreate._();
  static $pb.GeneratedMessage $_createMessage() => DebtCreate._();
  @$core.override
  DebtCreate createEmptyInstance() => DebtCreate._();
  @$core.pragma('dart2js:noInline')
  static DebtCreate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DebtCreate>(DebtCreate.$_createMessage);
  static DebtCreate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get kind => $_getSZ(0);
  @$pb.TagNumber(1)
  set kind($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get installmentMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set installmentMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInstallmentMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearInstallmentMinor() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get count => $_getIZ(4);
  @$pb.TagNumber(5)
  set count($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get firstDue => $_getSZ(5);
  @$pb.TagNumber(6)
  set firstDue($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFirstDue() => $_has(5);
  @$pb.TagNumber(6)
  void clearFirstDue() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get principalMinor => $_getI64(6);
  @$pb.TagNumber(7)
  set principalMinor($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPrincipalMinor() => $_has(6);
  @$pb.TagNumber(7)
  void clearPrincipalMinor() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get walletId => $_getSZ(7);
  @$pb.TagNumber(8)
  set walletId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasWalletId() => $_has(7);
  @$pb.TagNumber(8)
  void clearWalletId() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get categoryId => $_getSZ(8);
  @$pb.TagNumber(9)
  set categoryId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCategoryId() => $_has(8);
  @$pb.TagNumber(9)
  void clearCategoryId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get clientMutationId => $_getSZ(9);
  @$pb.TagNumber(10)
  set clientMutationId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasClientMutationId() => $_has(9);
  @$pb.TagNumber(10)
  void clearClientMutationId() => $_clearField(10);
}

class DebtListReply extends $pb.GeneratedMessage {
  factory DebtListReply({
    $core.Iterable<DebtMsg>? debts,
  }) {
    final result = DebtListReply._();
    if (debts != null) result.debts.addAll(debts);
    return result;
  }

  DebtListReply._();

  factory DebtListReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DebtListReply()..mergeFromBuffer(data, registry);
  factory DebtListReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DebtListReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DebtListReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.debts'),
      createEmptyInstance: DebtListReply.$_createMessage)
    ..pPM<DebtMsg>(1, _omitFieldNames ? '' : 'debts',
        subBuilder: DebtMsg.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DebtListReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DebtListReply copyWith(void Function(DebtListReply) updates) =>
      super.copyWith((message) => updates(message as DebtListReply))
          as DebtListReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DebtListReply() / DebtListReply.new instead')
  static DebtListReply create() => DebtListReply._();
  static $pb.GeneratedMessage $_createMessage() => DebtListReply._();
  @$core.override
  DebtListReply createEmptyInstance() => DebtListReply._();
  @$core.pragma('dart2js:noInline')
  static DebtListReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DebtListReply>(
          DebtListReply.$_createMessage);
  static DebtListReply? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DebtMsg> get debts => $_getList(0);
}

class DebtMsg extends $pb.GeneratedMessage {
  factory DebtMsg({
    $core.String? id,
    $core.String? kind,
    $core.String? title,
    $core.String? currency,
    $fixnum.Int64? installmentMinor,
    $core.int? count,
    $fixnum.Int64? principalMinor,
    $core.String? walletId,
    $core.String? categoryId,
    $core.int? paidCount,
    $fixnum.Int64? remainingMinor,
    $core.String? nextDue,
    $core.bool? closed,
    $core.Iterable<InstallmentMsg>? installments,
  }) {
    final result = DebtMsg._();
    if (id != null) result.id = id;
    if (kind != null) result.kind = kind;
    if (title != null) result.title = title;
    if (currency != null) result.currency = currency;
    if (installmentMinor != null) result.installmentMinor = installmentMinor;
    if (count != null) result.count = count;
    if (principalMinor != null) result.principalMinor = principalMinor;
    if (walletId != null) result.walletId = walletId;
    if (categoryId != null) result.categoryId = categoryId;
    if (paidCount != null) result.paidCount = paidCount;
    if (remainingMinor != null) result.remainingMinor = remainingMinor;
    if (nextDue != null) result.nextDue = nextDue;
    if (closed != null) result.closed = closed;
    if (installments != null) result.installments.addAll(installments);
    return result;
  }

  DebtMsg._();

  factory DebtMsg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DebtMsg()..mergeFromBuffer(data, registry);
  factory DebtMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DebtMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DebtMsg',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.debts'),
      createEmptyInstance: DebtMsg.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'kind')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aInt64(5, _omitFieldNames ? '' : 'installmentMinor')
    ..aI(6, _omitFieldNames ? '' : 'count')
    ..aInt64(7, _omitFieldNames ? '' : 'principalMinor')
    ..aOS(8, _omitFieldNames ? '' : 'walletId')
    ..aOS(9, _omitFieldNames ? '' : 'categoryId')
    ..aI(10, _omitFieldNames ? '' : 'paidCount')
    ..aInt64(11, _omitFieldNames ? '' : 'remainingMinor')
    ..aOS(12, _omitFieldNames ? '' : 'nextDue')
    ..aOB(13, _omitFieldNames ? '' : 'closed')
    ..pPM<InstallmentMsg>(14, _omitFieldNames ? '' : 'installments',
        subBuilder: InstallmentMsg.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DebtMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DebtMsg copyWith(void Function(DebtMsg) updates) =>
      super.copyWith((message) => updates(message as DebtMsg)) as DebtMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DebtMsg() / DebtMsg.new instead')
  static DebtMsg create() => DebtMsg._();
  static $pb.GeneratedMessage $_createMessage() => DebtMsg._();
  @$core.override
  DebtMsg createEmptyInstance() => DebtMsg._();
  @$core.pragma('dart2js:noInline')
  static DebtMsg getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DebtMsg>(DebtMsg.$_createMessage);
  static DebtMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get kind => $_getSZ(1);
  @$pb.TagNumber(2)
  set kind($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get installmentMinor => $_getI64(4);
  @$pb.TagNumber(5)
  set installmentMinor($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasInstallmentMinor() => $_has(4);
  @$pb.TagNumber(5)
  void clearInstallmentMinor() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get count => $_getIZ(5);
  @$pb.TagNumber(6)
  set count($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearCount() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get principalMinor => $_getI64(6);
  @$pb.TagNumber(7)
  set principalMinor($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPrincipalMinor() => $_has(6);
  @$pb.TagNumber(7)
  void clearPrincipalMinor() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get walletId => $_getSZ(7);
  @$pb.TagNumber(8)
  set walletId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasWalletId() => $_has(7);
  @$pb.TagNumber(8)
  void clearWalletId() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get categoryId => $_getSZ(8);
  @$pb.TagNumber(9)
  set categoryId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCategoryId() => $_has(8);
  @$pb.TagNumber(9)
  void clearCategoryId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get paidCount => $_getIZ(9);
  @$pb.TagNumber(10)
  set paidCount($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPaidCount() => $_has(9);
  @$pb.TagNumber(10)
  void clearPaidCount() => $_clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get remainingMinor => $_getI64(10);
  @$pb.TagNumber(11)
  set remainingMinor($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasRemainingMinor() => $_has(10);
  @$pb.TagNumber(11)
  void clearRemainingMinor() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get nextDue => $_getSZ(11);
  @$pb.TagNumber(12)
  set nextDue($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasNextDue() => $_has(11);
  @$pb.TagNumber(12)
  void clearNextDue() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.bool get closed => $_getBF(12);
  @$pb.TagNumber(13)
  set closed($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasClosed() => $_has(12);
  @$pb.TagNumber(13)
  void clearClosed() => $_clearField(13);

  @$pb.TagNumber(14)
  $pb.PbList<InstallmentMsg> get installments => $_getList(13);
}

class DebtRef extends $pb.GeneratedMessage {
  factory DebtRef({
    $core.String? debtId,
  }) {
    final result = DebtRef._();
    if (debtId != null) result.debtId = debtId;
    return result;
  }

  DebtRef._();

  factory DebtRef.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DebtRef()..mergeFromBuffer(data, registry);
  factory DebtRef.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DebtRef()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DebtRef',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.debts'),
      createEmptyInstance: DebtRef.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'debtId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DebtRef clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DebtRef copyWith(void Function(DebtRef) updates) =>
      super.copyWith((message) => updates(message as DebtRef)) as DebtRef;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DebtRef() / DebtRef.new instead')
  static DebtRef create() => DebtRef._();
  static $pb.GeneratedMessage $_createMessage() => DebtRef._();
  @$core.override
  DebtRef createEmptyInstance() => DebtRef._();
  @$core.pragma('dart2js:noInline')
  static DebtRef getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DebtRef>(DebtRef.$_createMessage);
  static DebtRef? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get debtId => $_getSZ(0);
  @$pb.TagNumber(1)
  set debtId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDebtId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDebtId() => $_clearField(1);
}

class DebtReply extends $pb.GeneratedMessage {
  factory DebtReply({
    DebtMsg? debt,
  }) {
    final result = DebtReply._();
    if (debt != null) result.debt = debt;
    return result;
  }

  DebtReply._();

  factory DebtReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DebtReply()..mergeFromBuffer(data, registry);
  factory DebtReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DebtReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DebtReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.debts'),
      createEmptyInstance: DebtReply.$_createMessage)
    ..aOM<DebtMsg>(1, _omitFieldNames ? '' : 'debt',
        subBuilder: DebtMsg.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DebtReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DebtReply copyWith(void Function(DebtReply) updates) =>
      super.copyWith((message) => updates(message as DebtReply)) as DebtReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DebtReply() / DebtReply.new instead')
  static DebtReply create() => DebtReply._();
  static $pb.GeneratedMessage $_createMessage() => DebtReply._();
  @$core.override
  DebtReply createEmptyInstance() => DebtReply._();
  @$core.pragma('dart2js:noInline')
  static DebtReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DebtReply>(DebtReply.$_createMessage);
  static DebtReply? _defaultInstance;

  @$pb.TagNumber(1)
  DebtMsg get debt => $_getN(0);
  @$pb.TagNumber(1)
  set debt(DebtMsg value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDebt() => $_has(0);
  @$pb.TagNumber(1)
  void clearDebt() => $_clearField(1);
  @$pb.TagNumber(1)
  DebtMsg ensureDebt() => $_ensure(0);
}

class InstallmentMsg extends $pb.GeneratedMessage {
  factory InstallmentMsg({
    $core.String? id,
    $core.int? number,
    $core.String? dueDate,
    $fixnum.Int64? amountMinor,
    $core.bool? paid,
    $core.bool? overdue,
  }) {
    final result = InstallmentMsg._();
    if (id != null) result.id = id;
    if (number != null) result.number = number;
    if (dueDate != null) result.dueDate = dueDate;
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (paid != null) result.paid = paid;
    if (overdue != null) result.overdue = overdue;
    return result;
  }

  InstallmentMsg._();

  factory InstallmentMsg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      InstallmentMsg()..mergeFromBuffer(data, registry);
  factory InstallmentMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      InstallmentMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InstallmentMsg',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.debts'),
      createEmptyInstance: InstallmentMsg.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aI(2, _omitFieldNames ? '' : 'number')
    ..aOS(3, _omitFieldNames ? '' : 'dueDate')
    ..aInt64(4, _omitFieldNames ? '' : 'amountMinor')
    ..aOB(5, _omitFieldNames ? '' : 'paid')
    ..aOB(6, _omitFieldNames ? '' : 'overdue')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstallmentMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstallmentMsg copyWith(void Function(InstallmentMsg) updates) =>
      super.copyWith((message) => updates(message as InstallmentMsg))
          as InstallmentMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use InstallmentMsg() / InstallmentMsg.new instead')
  static InstallmentMsg create() => InstallmentMsg._();
  static $pb.GeneratedMessage $_createMessage() => InstallmentMsg._();
  @$core.override
  InstallmentMsg createEmptyInstance() => InstallmentMsg._();
  @$core.pragma('dart2js:noInline')
  static InstallmentMsg getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstallmentMsg>(
          InstallmentMsg.$_createMessage);
  static InstallmentMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get number => $_getIZ(1);
  @$pb.TagNumber(2)
  set number($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get dueDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set dueDate($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDueDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearDueDate() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amountMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set amountMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmountMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountMinor() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get paid => $_getBF(4);
  @$pb.TagNumber(5)
  set paid($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPaid() => $_has(4);
  @$pb.TagNumber(5)
  void clearPaid() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get overdue => $_getBF(5);
  @$pb.TagNumber(6)
  set overdue($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasOverdue() => $_has(5);
  @$pb.TagNumber(6)
  void clearOverdue() => $_clearField(6);
}

class InstallmentPay extends $pb.GeneratedMessage {
  factory InstallmentPay({
    $core.String? installmentId,
    $core.String? walletId,
    $fixnum.Int64? amountMinor,
  }) {
    final result = InstallmentPay._();
    if (installmentId != null) result.installmentId = installmentId;
    if (walletId != null) result.walletId = walletId;
    if (amountMinor != null) result.amountMinor = amountMinor;
    return result;
  }

  InstallmentPay._();

  factory InstallmentPay.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      InstallmentPay()..mergeFromBuffer(data, registry);
  factory InstallmentPay.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      InstallmentPay()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InstallmentPay',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.debts'),
      createEmptyInstance: InstallmentPay.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'installmentId')
    ..aOS(2, _omitFieldNames ? '' : 'walletId')
    ..aInt64(3, _omitFieldNames ? '' : 'amountMinor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstallmentPay clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstallmentPay copyWith(void Function(InstallmentPay) updates) =>
      super.copyWith((message) => updates(message as InstallmentPay))
          as InstallmentPay;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use InstallmentPay() / InstallmentPay.new instead')
  static InstallmentPay create() => InstallmentPay._();
  static $pb.GeneratedMessage $_createMessage() => InstallmentPay._();
  @$core.override
  InstallmentPay createEmptyInstance() => InstallmentPay._();
  @$core.pragma('dart2js:noInline')
  static InstallmentPay getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstallmentPay>(
          InstallmentPay.$_createMessage);
  static InstallmentPay? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get installmentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set installmentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInstallmentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInstallmentId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get walletId => $_getSZ(1);
  @$pb.TagNumber(2)
  set walletId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWalletId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWalletId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amountMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set amountMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmountMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountMinor() => $_clearField(3);
}

class InstallmentRef extends $pb.GeneratedMessage {
  factory InstallmentRef({
    $core.String? installmentId,
  }) {
    final result = InstallmentRef._();
    if (installmentId != null) result.installmentId = installmentId;
    return result;
  }

  InstallmentRef._();

  factory InstallmentRef.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      InstallmentRef()..mergeFromBuffer(data, registry);
  factory InstallmentRef.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      InstallmentRef()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InstallmentRef',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.debts'),
      createEmptyInstance: InstallmentRef.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'installmentId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstallmentRef clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstallmentRef copyWith(void Function(InstallmentRef) updates) =>
      super.copyWith((message) => updates(message as InstallmentRef))
          as InstallmentRef;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use InstallmentRef() / InstallmentRef.new instead')
  static InstallmentRef create() => InstallmentRef._();
  static $pb.GeneratedMessage $_createMessage() => InstallmentRef._();
  @$core.override
  InstallmentRef createEmptyInstance() => InstallmentRef._();
  @$core.pragma('dart2js:noInline')
  static InstallmentRef getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstallmentRef>(
          InstallmentRef.$_createMessage);
  static InstallmentRef? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get installmentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set installmentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInstallmentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInstallmentId() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
