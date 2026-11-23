// This is a generated file - do not edit.
//
// Generated from apps/wallets/grpc/wallets.proto.

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

class CurrencyTotal extends $pb.GeneratedMessage {
  factory CurrencyTotal({
    $core.String? currency,
    $fixnum.Int64? balanceMinor,
  }) {
    final result = CurrencyTotal._();
    if (currency != null) result.currency = currency;
    if (balanceMinor != null) result.balanceMinor = balanceMinor;
    return result;
  }

  CurrencyTotal._();

  factory CurrencyTotal.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CurrencyTotal()..mergeFromBuffer(data, registry);
  factory CurrencyTotal.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CurrencyTotal()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CurrencyTotal',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.wallets'),
      createEmptyInstance: CurrencyTotal.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'currency')
    ..aInt64(2, _omitFieldNames ? '' : 'balanceMinor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CurrencyTotal clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CurrencyTotal copyWith(void Function(CurrencyTotal) updates) =>
      super.copyWith((message) => updates(message as CurrencyTotal))
          as CurrencyTotal;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CurrencyTotal() / CurrencyTotal.new instead')
  static CurrencyTotal create() => CurrencyTotal._();
  static $pb.GeneratedMessage $_createMessage() => CurrencyTotal._();
  @$core.override
  CurrencyTotal createEmptyInstance() => CurrencyTotal._();
  @$core.pragma('dart2js:noInline')
  static CurrencyTotal getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CurrencyTotal>(
          CurrencyTotal.$_createMessage);
  static CurrencyTotal? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currency => $_getSZ(0);
  @$pb.TagNumber(1)
  set currency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrency() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get balanceMinor => $_getI64(1);
  @$pb.TagNumber(2)
  set balanceMinor($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBalanceMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearBalanceMinor() => $_clearField(2);
}

class Entry extends $pb.GeneratedMessage {
  factory Entry({
    $core.String? id,
    $core.String? walletId,
    $core.String? kind,
    $fixnum.Int64? amountMinor,
    $core.String? currency,
    $core.String? occurredAt,
    $core.String? note,
  }) {
    final result = Entry._();
    if (id != null) result.id = id;
    if (walletId != null) result.walletId = walletId;
    if (kind != null) result.kind = kind;
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (currency != null) result.currency = currency;
    if (occurredAt != null) result.occurredAt = occurredAt;
    if (note != null) result.note = note;
    return result;
  }

  Entry._();

  factory Entry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Entry()..mergeFromBuffer(data, registry);
  factory Entry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Entry()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Entry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.wallets'),
      createEmptyInstance: Entry.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'walletId')
    ..aOS(3, _omitFieldNames ? '' : 'kind')
    ..aInt64(4, _omitFieldNames ? '' : 'amountMinor')
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'occurredAt')
    ..aOS(7, _omitFieldNames ? '' : 'note')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Entry clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Entry copyWith(void Function(Entry) updates) =>
      super.copyWith((message) => updates(message as Entry)) as Entry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Entry() / Entry.new instead')
  static Entry create() => Entry._();
  static $pb.GeneratedMessage $_createMessage() => Entry._();
  @$core.override
  Entry createEmptyInstance() => Entry._();
  @$core.pragma('dart2js:noInline')
  static Entry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Entry>(Entry.$_createMessage);
  static Entry? _defaultInstance;

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
}

class EntryEdit extends $pb.GeneratedMessage {
  factory EntryEdit({
    $core.String? entryId,
    $fixnum.Int64? amountMinor,
    $core.String? occurredAt,
    $core.String? note,
  }) {
    final result = EntryEdit._();
    if (entryId != null) result.entryId = entryId;
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (occurredAt != null) result.occurredAt = occurredAt;
    if (note != null) result.note = note;
    return result;
  }

  EntryEdit._();

  factory EntryEdit.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EntryEdit()..mergeFromBuffer(data, registry);
  factory EntryEdit.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EntryEdit()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EntryEdit',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.wallets'),
      createEmptyInstance: EntryEdit.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'entryId')
    ..aInt64(2, _omitFieldNames ? '' : 'amountMinor')
    ..aOS(3, _omitFieldNames ? '' : 'occurredAt')
    ..aOS(4, _omitFieldNames ? '' : 'note')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EntryEdit clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EntryEdit copyWith(void Function(EntryEdit) updates) =>
      super.copyWith((message) => updates(message as EntryEdit)) as EntryEdit;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use EntryEdit() / EntryEdit.new instead')
  static EntryEdit create() => EntryEdit._();
  static $pb.GeneratedMessage $_createMessage() => EntryEdit._();
  @$core.override
  EntryEdit createEmptyInstance() => EntryEdit._();
  @$core.pragma('dart2js:noInline')
  static EntryEdit getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EntryEdit>(EntryEdit.$_createMessage);
  static EntryEdit? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get entryId => $_getSZ(0);
  @$pb.TagNumber(1)
  set entryId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEntryId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntryId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amountMinor => $_getI64(1);
  @$pb.TagNumber(2)
  set amountMinor($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmountMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountMinor() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get occurredAt => $_getSZ(2);
  @$pb.TagNumber(3)
  set occurredAt($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOccurredAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearOccurredAt() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get note => $_getSZ(3);
  @$pb.TagNumber(4)
  set note($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNote() => $_has(3);
  @$pb.TagNumber(4)
  void clearNote() => $_clearField(4);
}

class EntryListReply extends $pb.GeneratedMessage {
  factory EntryListReply({
    $core.Iterable<Entry>? entries,
  }) {
    final result = EntryListReply._();
    if (entries != null) result.entries.addAll(entries);
    return result;
  }

  EntryListReply._();

  factory EntryListReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EntryListReply()..mergeFromBuffer(data, registry);
  factory EntryListReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EntryListReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EntryListReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.wallets'),
      createEmptyInstance: EntryListReply.$_createMessage)
    ..pPM<Entry>(1, _omitFieldNames ? '' : 'entries',
        subBuilder: Entry.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EntryListReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EntryListReply copyWith(void Function(EntryListReply) updates) =>
      super.copyWith((message) => updates(message as EntryListReply))
          as EntryListReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use EntryListReply() / EntryListReply.new instead')
  static EntryListReply create() => EntryListReply._();
  static $pb.GeneratedMessage $_createMessage() => EntryListReply._();
  @$core.override
  EntryListReply createEmptyInstance() => EntryListReply._();
  @$core.pragma('dart2js:noInline')
  static EntryListReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EntryListReply>(
          EntryListReply.$_createMessage);
  static EntryListReply? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Entry> get entries => $_getList(0);
}

class EntryQuery extends $pb.GeneratedMessage {
  factory EntryQuery({
    $core.String? walletId,
    $core.int? limit,
  }) {
    final result = EntryQuery._();
    if (walletId != null) result.walletId = walletId;
    if (limit != null) result.limit = limit;
    return result;
  }

  EntryQuery._();

  factory EntryQuery.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EntryQuery()..mergeFromBuffer(data, registry);
  factory EntryQuery.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EntryQuery()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EntryQuery',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.wallets'),
      createEmptyInstance: EntryQuery.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'walletId')
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EntryQuery clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EntryQuery copyWith(void Function(EntryQuery) updates) =>
      super.copyWith((message) => updates(message as EntryQuery)) as EntryQuery;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use EntryQuery() / EntryQuery.new instead')
  static EntryQuery create() => EntryQuery._();
  static $pb.GeneratedMessage $_createMessage() => EntryQuery._();
  @$core.override
  EntryQuery createEmptyInstance() => EntryQuery._();
  @$core.pragma('dart2js:noInline')
  static EntryQuery getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EntryQuery>(EntryQuery.$_createMessage);
  static EntryQuery? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletId => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWalletId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class EntryRecord extends $pb.GeneratedMessage {
  factory EntryRecord({
    $core.String? walletId,
    $core.String? kind,
    $fixnum.Int64? amountMinor,
    $core.String? occurredAt,
    $core.String? note,
    $core.String? clientMutationId,
  }) {
    final result = EntryRecord._();
    if (walletId != null) result.walletId = walletId;
    if (kind != null) result.kind = kind;
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (occurredAt != null) result.occurredAt = occurredAt;
    if (note != null) result.note = note;
    if (clientMutationId != null) result.clientMutationId = clientMutationId;
    return result;
  }

  EntryRecord._();

  factory EntryRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EntryRecord()..mergeFromBuffer(data, registry);
  factory EntryRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EntryRecord()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EntryRecord',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.wallets'),
      createEmptyInstance: EntryRecord.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'walletId')
    ..aOS(2, _omitFieldNames ? '' : 'kind')
    ..aInt64(3, _omitFieldNames ? '' : 'amountMinor')
    ..aOS(4, _omitFieldNames ? '' : 'occurredAt')
    ..aOS(5, _omitFieldNames ? '' : 'note')
    ..aOS(6, _omitFieldNames ? '' : 'clientMutationId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EntryRecord clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EntryRecord copyWith(void Function(EntryRecord) updates) =>
      super.copyWith((message) => updates(message as EntryRecord))
          as EntryRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use EntryRecord() / EntryRecord.new instead')
  static EntryRecord create() => EntryRecord._();
  static $pb.GeneratedMessage $_createMessage() => EntryRecord._();
  @$core.override
  EntryRecord createEmptyInstance() => EntryRecord._();
  @$core.pragma('dart2js:noInline')
  static EntryRecord getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EntryRecord>(
          EntryRecord.$_createMessage);
  static EntryRecord? _defaultInstance;

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
  $core.String get occurredAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set occurredAt($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOccurredAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearOccurredAt() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get note => $_getSZ(4);
  @$pb.TagNumber(5)
  set note($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNote() => $_has(4);
  @$pb.TagNumber(5)
  void clearNote() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get clientMutationId => $_getSZ(5);
  @$pb.TagNumber(6)
  set clientMutationId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasClientMutationId() => $_has(5);
  @$pb.TagNumber(6)
  void clearClientMutationId() => $_clearField(6);
}

class EntryRef extends $pb.GeneratedMessage {
  factory EntryRef({
    $core.String? entryId,
  }) {
    final result = EntryRef._();
    if (entryId != null) result.entryId = entryId;
    return result;
  }

  EntryRef._();

  factory EntryRef.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EntryRef()..mergeFromBuffer(data, registry);
  factory EntryRef.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EntryRef()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EntryRef',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.wallets'),
      createEmptyInstance: EntryRef.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'entryId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EntryRef clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EntryRef copyWith(void Function(EntryRef) updates) =>
      super.copyWith((message) => updates(message as EntryRef)) as EntryRef;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use EntryRef() / EntryRef.new instead')
  static EntryRef create() => EntryRef._();
  static $pb.GeneratedMessage $_createMessage() => EntryRef._();
  @$core.override
  EntryRef createEmptyInstance() => EntryRef._();
  @$core.pragma('dart2js:noInline')
  static EntryRef getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EntryRef>(EntryRef.$_createMessage);
  static EntryRef? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get entryId => $_getSZ(0);
  @$pb.TagNumber(1)
  set entryId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEntryId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntryId() => $_clearField(1);
}

class EntryReply extends $pb.GeneratedMessage {
  factory EntryReply({
    Entry? entry,
  }) {
    final result = EntryReply._();
    if (entry != null) result.entry = entry;
    return result;
  }

  EntryReply._();

  factory EntryReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EntryReply()..mergeFromBuffer(data, registry);
  factory EntryReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EntryReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EntryReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.wallets'),
      createEmptyInstance: EntryReply.$_createMessage)
    ..aOM<Entry>(1, _omitFieldNames ? '' : 'entry',
        subBuilder: Entry.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EntryReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EntryReply copyWith(void Function(EntryReply) updates) =>
      super.copyWith((message) => updates(message as EntryReply)) as EntryReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use EntryReply() / EntryReply.new instead')
  static EntryReply create() => EntryReply._();
  static $pb.GeneratedMessage $_createMessage() => EntryReply._();
  @$core.override
  EntryReply createEmptyInstance() => EntryReply._();
  @$core.pragma('dart2js:noInline')
  static EntryReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EntryReply>(EntryReply.$_createMessage);
  static EntryReply? _defaultInstance;

  @$pb.TagNumber(1)
  Entry get entry => $_getN(0);
  @$pb.TagNumber(1)
  set entry(Entry value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEntry() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntry() => $_clearField(1);
  @$pb.TagNumber(1)
  Entry ensureEntry() => $_ensure(0);
}

class TransferRequest extends $pb.GeneratedMessage {
  factory TransferRequest({
    $core.String? fromWalletId,
    $core.String? toWalletId,
    $fixnum.Int64? amountMinor,
    $core.String? rate,
    $fixnum.Int64? feeMinor,
    $core.String? occurredAt,
    $core.String? note,
    $core.String? clientMutationId,
  }) {
    final result = TransferRequest._();
    if (fromWalletId != null) result.fromWalletId = fromWalletId;
    if (toWalletId != null) result.toWalletId = toWalletId;
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (rate != null) result.rate = rate;
    if (feeMinor != null) result.feeMinor = feeMinor;
    if (occurredAt != null) result.occurredAt = occurredAt;
    if (note != null) result.note = note;
    if (clientMutationId != null) result.clientMutationId = clientMutationId;
    return result;
  }

  TransferRequest._();

  factory TransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TransferRequest()..mergeFromBuffer(data, registry);
  factory TransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TransferRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.wallets'),
      createEmptyInstance: TransferRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'fromWalletId')
    ..aOS(2, _omitFieldNames ? '' : 'toWalletId')
    ..aInt64(3, _omitFieldNames ? '' : 'amountMinor')
    ..aOS(4, _omitFieldNames ? '' : 'rate')
    ..aInt64(5, _omitFieldNames ? '' : 'feeMinor')
    ..aOS(6, _omitFieldNames ? '' : 'occurredAt')
    ..aOS(7, _omitFieldNames ? '' : 'note')
    ..aOS(8, _omitFieldNames ? '' : 'clientMutationId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferRequest copyWith(void Function(TransferRequest) updates) =>
      super.copyWith((message) => updates(message as TransferRequest))
          as TransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TransferRequest() / TransferRequest.new instead')
  static TransferRequest create() => TransferRequest._();
  static $pb.GeneratedMessage $_createMessage() => TransferRequest._();
  @$core.override
  TransferRequest createEmptyInstance() => TransferRequest._();
  @$core.pragma('dart2js:noInline')
  static TransferRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferRequest>(
          TransferRequest.$_createMessage);
  static TransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromWalletId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromWalletId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromWalletId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromWalletId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toWalletId => $_getSZ(1);
  @$pb.TagNumber(2)
  set toWalletId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToWalletId() => $_has(1);
  @$pb.TagNumber(2)
  void clearToWalletId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amountMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set amountMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmountMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountMinor() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get rate => $_getSZ(3);
  @$pb.TagNumber(4)
  set rate($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearRate() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get feeMinor => $_getI64(4);
  @$pb.TagNumber(5)
  set feeMinor($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFeeMinor() => $_has(4);
  @$pb.TagNumber(5)
  void clearFeeMinor() => $_clearField(5);

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
  $core.String get clientMutationId => $_getSZ(7);
  @$pb.TagNumber(8)
  set clientMutationId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasClientMutationId() => $_has(7);
  @$pb.TagNumber(8)
  void clearClientMutationId() => $_clearField(8);
}

class Wallet extends $pb.GeneratedMessage {
  factory Wallet({
    $core.String? id,
    $core.String? name,
    $core.String? kind,
    $core.String? currency,
    $core.String? bank,
    $core.bool? archived,
    $fixnum.Int64? balanceMinor,
  }) {
    final result = Wallet._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (kind != null) result.kind = kind;
    if (currency != null) result.currency = currency;
    if (bank != null) result.bank = bank;
    if (archived != null) result.archived = archived;
    if (balanceMinor != null) result.balanceMinor = balanceMinor;
    return result;
  }

  Wallet._();

  factory Wallet.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Wallet()..mergeFromBuffer(data, registry);
  factory Wallet.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Wallet()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Wallet',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.wallets'),
      createEmptyInstance: Wallet.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'kind')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'bank')
    ..aOB(6, _omitFieldNames ? '' : 'archived')
    ..aInt64(7, _omitFieldNames ? '' : 'balanceMinor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Wallet clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Wallet copyWith(void Function(Wallet) updates) =>
      super.copyWith((message) => updates(message as Wallet)) as Wallet;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Wallet() / Wallet.new instead')
  static Wallet create() => Wallet._();
  static $pb.GeneratedMessage $_createMessage() => Wallet._();
  @$core.override
  Wallet createEmptyInstance() => Wallet._();
  @$core.pragma('dart2js:noInline')
  static Wallet getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Wallet>(Wallet.$_createMessage);
  static Wallet? _defaultInstance;

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

  @$pb.TagNumber(7)
  $fixnum.Int64 get balanceMinor => $_getI64(6);
  @$pb.TagNumber(7)
  set balanceMinor($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBalanceMinor() => $_has(6);
  @$pb.TagNumber(7)
  void clearBalanceMinor() => $_clearField(7);
}

class WalletCreate extends $pb.GeneratedMessage {
  factory WalletCreate({
    $core.String? name,
    $core.String? kind,
    $core.String? currency,
    $core.String? bank,
    $fixnum.Int64? openingBalanceMinor,
    $core.String? clientMutationId,
  }) {
    final result = WalletCreate._();
    if (name != null) result.name = name;
    if (kind != null) result.kind = kind;
    if (currency != null) result.currency = currency;
    if (bank != null) result.bank = bank;
    if (openingBalanceMinor != null)
      result.openingBalanceMinor = openingBalanceMinor;
    if (clientMutationId != null) result.clientMutationId = clientMutationId;
    return result;
  }

  WalletCreate._();

  factory WalletCreate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      WalletCreate()..mergeFromBuffer(data, registry);
  factory WalletCreate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      WalletCreate()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WalletCreate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.wallets'),
      createEmptyInstance: WalletCreate.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'kind')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'bank')
    ..aInt64(5, _omitFieldNames ? '' : 'openingBalanceMinor')
    ..aOS(6, _omitFieldNames ? '' : 'clientMutationId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WalletCreate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WalletCreate copyWith(void Function(WalletCreate) updates) =>
      super.copyWith((message) => updates(message as WalletCreate))
          as WalletCreate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use WalletCreate() / WalletCreate.new instead')
  static WalletCreate create() => WalletCreate._();
  static $pb.GeneratedMessage $_createMessage() => WalletCreate._();
  @$core.override
  WalletCreate createEmptyInstance() => WalletCreate._();
  @$core.pragma('dart2js:noInline')
  static WalletCreate getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WalletCreate>(
          WalletCreate.$_createMessage);
  static WalletCreate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get kind => $_getSZ(1);
  @$pb.TagNumber(2)
  set kind($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get bank => $_getSZ(3);
  @$pb.TagNumber(4)
  set bank($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBank() => $_has(3);
  @$pb.TagNumber(4)
  void clearBank() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get openingBalanceMinor => $_getI64(4);
  @$pb.TagNumber(5)
  set openingBalanceMinor($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasOpeningBalanceMinor() => $_has(4);
  @$pb.TagNumber(5)
  void clearOpeningBalanceMinor() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get clientMutationId => $_getSZ(5);
  @$pb.TagNumber(6)
  set clientMutationId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasClientMutationId() => $_has(5);
  @$pb.TagNumber(6)
  void clearClientMutationId() => $_clearField(6);
}

class WalletListReply extends $pb.GeneratedMessage {
  factory WalletListReply({
    $core.Iterable<Wallet>? wallets,
    $core.Iterable<CurrencyTotal>? totals,
  }) {
    final result = WalletListReply._();
    if (wallets != null) result.wallets.addAll(wallets);
    if (totals != null) result.totals.addAll(totals);
    return result;
  }

  WalletListReply._();

  factory WalletListReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      WalletListReply()..mergeFromBuffer(data, registry);
  factory WalletListReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      WalletListReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WalletListReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.wallets'),
      createEmptyInstance: WalletListReply.$_createMessage)
    ..pPM<Wallet>(1, _omitFieldNames ? '' : 'wallets',
        subBuilder: Wallet.$_createMessage)
    ..pPM<CurrencyTotal>(2, _omitFieldNames ? '' : 'totals',
        subBuilder: CurrencyTotal.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WalletListReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WalletListReply copyWith(void Function(WalletListReply) updates) =>
      super.copyWith((message) => updates(message as WalletListReply))
          as WalletListReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use WalletListReply() / WalletListReply.new instead')
  static WalletListReply create() => WalletListReply._();
  static $pb.GeneratedMessage $_createMessage() => WalletListReply._();
  @$core.override
  WalletListReply createEmptyInstance() => WalletListReply._();
  @$core.pragma('dart2js:noInline')
  static WalletListReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WalletListReply>(
          WalletListReply.$_createMessage);
  static WalletListReply? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Wallet> get wallets => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<CurrencyTotal> get totals => $_getList(1);
}

class WalletRef extends $pb.GeneratedMessage {
  factory WalletRef({
    $core.String? walletId,
  }) {
    final result = WalletRef._();
    if (walletId != null) result.walletId = walletId;
    return result;
  }

  WalletRef._();

  factory WalletRef.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      WalletRef()..mergeFromBuffer(data, registry);
  factory WalletRef.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      WalletRef()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WalletRef',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.wallets'),
      createEmptyInstance: WalletRef.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'walletId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WalletRef clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WalletRef copyWith(void Function(WalletRef) updates) =>
      super.copyWith((message) => updates(message as WalletRef)) as WalletRef;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use WalletRef() / WalletRef.new instead')
  static WalletRef create() => WalletRef._();
  static $pb.GeneratedMessage $_createMessage() => WalletRef._();
  @$core.override
  WalletRef createEmptyInstance() => WalletRef._();
  @$core.pragma('dart2js:noInline')
  static WalletRef getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WalletRef>(WalletRef.$_createMessage);
  static WalletRef? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletId => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWalletId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletId() => $_clearField(1);
}

class WalletReply extends $pb.GeneratedMessage {
  factory WalletReply({
    Wallet? wallet,
  }) {
    final result = WalletReply._();
    if (wallet != null) result.wallet = wallet;
    return result;
  }

  WalletReply._();

  factory WalletReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      WalletReply()..mergeFromBuffer(data, registry);
  factory WalletReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      WalletReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WalletReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.wallets'),
      createEmptyInstance: WalletReply.$_createMessage)
    ..aOM<Wallet>(1, _omitFieldNames ? '' : 'wallet',
        subBuilder: Wallet.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WalletReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WalletReply copyWith(void Function(WalletReply) updates) =>
      super.copyWith((message) => updates(message as WalletReply))
          as WalletReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use WalletReply() / WalletReply.new instead')
  static WalletReply create() => WalletReply._();
  static $pb.GeneratedMessage $_createMessage() => WalletReply._();
  @$core.override
  WalletReply createEmptyInstance() => WalletReply._();
  @$core.pragma('dart2js:noInline')
  static WalletReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WalletReply>(
          WalletReply.$_createMessage);
  static WalletReply? _defaultInstance;

  @$pb.TagNumber(1)
  Wallet get wallet => $_getN(0);
  @$pb.TagNumber(1)
  set wallet(Wallet value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasWallet() => $_has(0);
  @$pb.TagNumber(1)
  void clearWallet() => $_clearField(1);
  @$pb.TagNumber(1)
  Wallet ensureWallet() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
