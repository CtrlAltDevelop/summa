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
