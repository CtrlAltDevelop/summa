// This is a generated file - do not edit.
//
// Generated from apps/sync/grpc/sync.proto.

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

class ChangesReply extends $pb.GeneratedMessage {
  factory ChangesReply({
    $core.Iterable<SyncWalletMsg>? wallets,
    $core.Iterable<SyncCategoryMsg>? categories,
    $core.Iterable<SyncEntryMsg>? entries,
    $core.String? walletsCursor,
    $core.String? categoriesCursor,
    $core.String? eventsCursor,
    $core.bool? hasMore,
  }) {
    final result = ChangesReply._();
    if (wallets != null) result.wallets.addAll(wallets);
    if (categories != null) result.categories.addAll(categories);
    if (entries != null) result.entries.addAll(entries);
    if (walletsCursor != null) result.walletsCursor = walletsCursor;
    if (categoriesCursor != null) result.categoriesCursor = categoriesCursor;
    if (eventsCursor != null) result.eventsCursor = eventsCursor;
    if (hasMore != null) result.hasMore = hasMore;
    return result;
  }

  ChangesReply._();

  factory ChangesReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChangesReply()..mergeFromBuffer(data, registry);
  factory ChangesReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChangesReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChangesReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.sync'),
      createEmptyInstance: ChangesReply.$_createMessage)
    ..pPM<SyncWalletMsg>(1, _omitFieldNames ? '' : 'wallets',
        subBuilder: SyncWalletMsg.$_createMessage)
    ..pPM<SyncCategoryMsg>(2, _omitFieldNames ? '' : 'categories',
        subBuilder: SyncCategoryMsg.$_createMessage)
    ..pPM<SyncEntryMsg>(3, _omitFieldNames ? '' : 'entries',
        subBuilder: SyncEntryMsg.$_createMessage)
    ..aOS(4, _omitFieldNames ? '' : 'walletsCursor')
    ..aOS(5, _omitFieldNames ? '' : 'categoriesCursor')
    ..aOS(6, _omitFieldNames ? '' : 'eventsCursor')
    ..aOB(7, _omitFieldNames ? '' : 'hasMore')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangesReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangesReply copyWith(void Function(ChangesReply) updates) =>
      super.copyWith((message) => updates(message as ChangesReply))
          as ChangesReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChangesReply() / ChangesReply.new instead')
  static ChangesReply create() => ChangesReply._();
  static $pb.GeneratedMessage $_createMessage() => ChangesReply._();
  @$core.override
  ChangesReply createEmptyInstance() => ChangesReply._();
  @$core.pragma('dart2js:noInline')
  static ChangesReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangesReply>(
          ChangesReply.$_createMessage);
  static ChangesReply? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SyncWalletMsg> get wallets => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<SyncCategoryMsg> get categories => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<SyncEntryMsg> get entries => $_getList(2);

  @$pb.TagNumber(4)
  $core.String get walletsCursor => $_getSZ(3);
  @$pb.TagNumber(4)
  set walletsCursor($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasWalletsCursor() => $_has(3);
  @$pb.TagNumber(4)
  void clearWalletsCursor() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get categoriesCursor => $_getSZ(4);
  @$pb.TagNumber(5)
  set categoriesCursor($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCategoriesCursor() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategoriesCursor() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get eventsCursor => $_getSZ(5);
  @$pb.TagNumber(6)
  set eventsCursor($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasEventsCursor() => $_has(5);
  @$pb.TagNumber(6)
  void clearEventsCursor() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get hasMore => $_getBF(6);
  @$pb.TagNumber(7)
  set hasMore($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasHasMore() => $_has(6);
  @$pb.TagNumber(7)
  void clearHasMore() => $_clearField(7);
}

class ChangesRequest extends $pb.GeneratedMessage {
  factory ChangesRequest({
    $core.String? walletsCursor,
    $core.String? categoriesCursor,
    $core.String? eventsCursor,
    $core.int? limit,
  }) {
    final result = ChangesRequest._();
    if (walletsCursor != null) result.walletsCursor = walletsCursor;
    if (categoriesCursor != null) result.categoriesCursor = categoriesCursor;
    if (eventsCursor != null) result.eventsCursor = eventsCursor;
    if (limit != null) result.limit = limit;
    return result;
  }

  ChangesRequest._();

  factory ChangesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChangesRequest()..mergeFromBuffer(data, registry);
  factory ChangesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChangesRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChangesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.sync'),
      createEmptyInstance: ChangesRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'walletsCursor')
    ..aOS(2, _omitFieldNames ? '' : 'categoriesCursor')
    ..aOS(3, _omitFieldNames ? '' : 'eventsCursor')
    ..aI(4, _omitFieldNames ? '' : 'limit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangesRequest copyWith(void Function(ChangesRequest) updates) =>
      super.copyWith((message) => updates(message as ChangesRequest))
          as ChangesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChangesRequest() / ChangesRequest.new instead')
  static ChangesRequest create() => ChangesRequest._();
  static $pb.GeneratedMessage $_createMessage() => ChangesRequest._();
  @$core.override
  ChangesRequest createEmptyInstance() => ChangesRequest._();
  @$core.pragma('dart2js:noInline')
  static ChangesRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangesRequest>(
          ChangesRequest.$_createMessage);
  static ChangesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletsCursor => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletsCursor($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWalletsCursor() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletsCursor() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get categoriesCursor => $_getSZ(1);
  @$pb.TagNumber(2)
  set categoriesCursor($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCategoriesCursor() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategoriesCursor() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get eventsCursor => $_getSZ(2);
  @$pb.TagNumber(3)
  set eventsCursor($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEventsCursor() => $_has(2);
  @$pb.TagNumber(3)
  void clearEventsCursor() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField(4);
}

class SyncCategoryMsg extends $pb.GeneratedMessage {
  factory SyncCategoryMsg({
    $core.String? id,
    $core.String? name,
    $core.String? kind,
    $core.bool? isOther,
  }) {
    final result = SyncCategoryMsg._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (kind != null) result.kind = kind;
    if (isOther != null) result.isOther = isOther;
    return result;
  }

  SyncCategoryMsg._();

  factory SyncCategoryMsg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncCategoryMsg()..mergeFromBuffer(data, registry);
  factory SyncCategoryMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncCategoryMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncCategoryMsg',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.sync'),
      createEmptyInstance: SyncCategoryMsg.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'kind')
    ..aOB(4, _omitFieldNames ? '' : 'isOther')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncCategoryMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncCategoryMsg copyWith(void Function(SyncCategoryMsg) updates) =>
      super.copyWith((message) => updates(message as SyncCategoryMsg))
          as SyncCategoryMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SyncCategoryMsg() / SyncCategoryMsg.new instead')
  static SyncCategoryMsg create() => SyncCategoryMsg._();
  static $pb.GeneratedMessage $_createMessage() => SyncCategoryMsg._();
  @$core.override
  SyncCategoryMsg createEmptyInstance() => SyncCategoryMsg._();
  @$core.pragma('dart2js:noInline')
  static SyncCategoryMsg getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncCategoryMsg>(
          SyncCategoryMsg.$_createMessage);
  static SyncCategoryMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get kind => $_getSZ(2);
  @$pb.TagNumber(3)
  set kind($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasKind() => $_has(2);
  @$pb.TagNumber(3)
  void clearKind() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isOther => $_getBF(3);
  @$pb.TagNumber(4)
  set isOther($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsOther() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsOther() => $_clearField(4);
}

class SyncEntryMsg extends $pb.GeneratedMessage {
  factory SyncEntryMsg({
    $core.String? id,
    $core.String? walletId,
    $core.String? kind,
    $core.String? direction,
    $fixnum.Int64? amountMinor,
    $core.String? occurredAt,
    $core.String? note,
    $core.String? categoryId,
    $core.bool? outsideTotals,
    $core.String? splitId,
    $core.String? transferId,
    $core.String? refundOf,
    $core.bool? voided,
  }) {
    final result = SyncEntryMsg._();
    if (id != null) result.id = id;
    if (walletId != null) result.walletId = walletId;
    if (kind != null) result.kind = kind;
    if (direction != null) result.direction = direction;
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (occurredAt != null) result.occurredAt = occurredAt;
    if (note != null) result.note = note;
    if (categoryId != null) result.categoryId = categoryId;
    if (outsideTotals != null) result.outsideTotals = outsideTotals;
    if (splitId != null) result.splitId = splitId;
    if (transferId != null) result.transferId = transferId;
    if (refundOf != null) result.refundOf = refundOf;
    if (voided != null) result.voided = voided;
    return result;
  }

  SyncEntryMsg._();

  factory SyncEntryMsg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncEntryMsg()..mergeFromBuffer(data, registry);
  factory SyncEntryMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncEntryMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncEntryMsg',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.sync'),
      createEmptyInstance: SyncEntryMsg.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'walletId')
    ..aOS(3, _omitFieldNames ? '' : 'kind')
    ..aOS(4, _omitFieldNames ? '' : 'direction')
    ..aInt64(5, _omitFieldNames ? '' : 'amountMinor')
    ..aOS(6, _omitFieldNames ? '' : 'occurredAt')
    ..aOS(7, _omitFieldNames ? '' : 'note')
    ..aOS(8, _omitFieldNames ? '' : 'categoryId')
    ..aOB(9, _omitFieldNames ? '' : 'outsideTotals')
    ..aOS(10, _omitFieldNames ? '' : 'splitId')
    ..aOS(11, _omitFieldNames ? '' : 'transferId')
    ..aOS(12, _omitFieldNames ? '' : 'refundOf')
    ..aOB(13, _omitFieldNames ? '' : 'voided')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncEntryMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncEntryMsg copyWith(void Function(SyncEntryMsg) updates) =>
      super.copyWith((message) => updates(message as SyncEntryMsg))
          as SyncEntryMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SyncEntryMsg() / SyncEntryMsg.new instead')
  static SyncEntryMsg create() => SyncEntryMsg._();
  static $pb.GeneratedMessage $_createMessage() => SyncEntryMsg._();
  @$core.override
  SyncEntryMsg createEmptyInstance() => SyncEntryMsg._();
  @$core.pragma('dart2js:noInline')
  static SyncEntryMsg getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncEntryMsg>(
          SyncEntryMsg.$_createMessage);
  static SyncEntryMsg? _defaultInstance;

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
  $core.String get direction => $_getSZ(3);
  @$pb.TagNumber(4)
  set direction($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDirection() => $_has(3);
  @$pb.TagNumber(4)
  void clearDirection() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get amountMinor => $_getI64(4);
  @$pb.TagNumber(5)
  set amountMinor($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmountMinor() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountMinor() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get occurredAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set occurredAt($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasOccurredAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearOccurredAt() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get note => $_getSZ(6);
  @$pb.TagNumber(7)
  set note($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNote() => $_has(6);
  @$pb.TagNumber(7)
  void clearNote() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get categoryId => $_getSZ(7);
  @$pb.TagNumber(8)
  set categoryId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCategoryId() => $_has(7);
  @$pb.TagNumber(8)
  void clearCategoryId() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get outsideTotals => $_getBF(8);
  @$pb.TagNumber(9)
  set outsideTotals($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasOutsideTotals() => $_has(8);
  @$pb.TagNumber(9)
  void clearOutsideTotals() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get splitId => $_getSZ(9);
  @$pb.TagNumber(10)
  set splitId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSplitId() => $_has(9);
  @$pb.TagNumber(10)
  void clearSplitId() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get transferId => $_getSZ(10);
  @$pb.TagNumber(11)
  set transferId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTransferId() => $_has(10);
  @$pb.TagNumber(11)
  void clearTransferId() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get refundOf => $_getSZ(11);
  @$pb.TagNumber(12)
  set refundOf($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasRefundOf() => $_has(11);
  @$pb.TagNumber(12)
  void clearRefundOf() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.bool get voided => $_getBF(12);
  @$pb.TagNumber(13)
  set voided($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasVoided() => $_has(12);
  @$pb.TagNumber(13)
  void clearVoided() => $_clearField(13);
}

class SyncWalletMsg extends $pb.GeneratedMessage {
  factory SyncWalletMsg({
    $core.String? id,
    $core.String? name,
    $core.String? kind,
    $core.String? currency,
    $core.String? bank,
    $core.bool? archived,
  }) {
    final result = SyncWalletMsg._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (kind != null) result.kind = kind;
    if (currency != null) result.currency = currency;
    if (bank != null) result.bank = bank;
    if (archived != null) result.archived = archived;
    return result;
  }

  SyncWalletMsg._();

  factory SyncWalletMsg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncWalletMsg()..mergeFromBuffer(data, registry);
  factory SyncWalletMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncWalletMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncWalletMsg',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.sync'),
      createEmptyInstance: SyncWalletMsg.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'kind')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'bank')
    ..aOB(6, _omitFieldNames ? '' : 'archived')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncWalletMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncWalletMsg copyWith(void Function(SyncWalletMsg) updates) =>
      super.copyWith((message) => updates(message as SyncWalletMsg))
          as SyncWalletMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SyncWalletMsg() / SyncWalletMsg.new instead')
  static SyncWalletMsg create() => SyncWalletMsg._();
  static $pb.GeneratedMessage $_createMessage() => SyncWalletMsg._();
  @$core.override
  SyncWalletMsg createEmptyInstance() => SyncWalletMsg._();
  @$core.pragma('dart2js:noInline')
  static SyncWalletMsg getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncWalletMsg>(
          SyncWalletMsg.$_createMessage);
  static SyncWalletMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get kind => $_getSZ(2);
  @$pb.TagNumber(3)
  set kind($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasKind() => $_has(2);
  @$pb.TagNumber(3)
  void clearKind() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get bank => $_getSZ(4);
  @$pb.TagNumber(5)
  set bank($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBank() => $_has(4);
  @$pb.TagNumber(5)
  void clearBank() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get archived => $_getBF(5);
  @$pb.TagNumber(6)
  set archived($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasArchived() => $_has(5);
  @$pb.TagNumber(6)
  void clearArchived() => $_clearField(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
