// This is a generated file - do not edit.
//
// Generated from apps/assets/grpc/assets.proto.

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

class AssetCreate extends $pb.GeneratedMessage {
  factory AssetCreate({
    $core.String? symbol,
    $core.String? name,
    $core.String? quantity,
    $fixnum.Int64? unitPriceMinor,
    $fixnum.Int64? manualPriceMinor,
    $core.String? boughtOn,
    $core.String? clientMutationId,
  }) {
    final result = AssetCreate._();
    if (symbol != null) result.symbol = symbol;
    if (name != null) result.name = name;
    if (quantity != null) result.quantity = quantity;
    if (unitPriceMinor != null) result.unitPriceMinor = unitPriceMinor;
    if (manualPriceMinor != null) result.manualPriceMinor = manualPriceMinor;
    if (boughtOn != null) result.boughtOn = boughtOn;
    if (clientMutationId != null) result.clientMutationId = clientMutationId;
    return result;
  }

  AssetCreate._();

  factory AssetCreate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AssetCreate()..mergeFromBuffer(data, registry);
  factory AssetCreate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AssetCreate()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AssetCreate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.assets'),
      createEmptyInstance: AssetCreate.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'quantity')
    ..aInt64(4, _omitFieldNames ? '' : 'unitPriceMinor')
    ..aInt64(5, _omitFieldNames ? '' : 'manualPriceMinor')
    ..aOS(6, _omitFieldNames ? '' : 'boughtOn')
    ..aOS(7, _omitFieldNames ? '' : 'clientMutationId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetCreate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetCreate copyWith(void Function(AssetCreate) updates) =>
      super.copyWith((message) => updates(message as AssetCreate))
          as AssetCreate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AssetCreate() / AssetCreate.new instead')
  static AssetCreate create() => AssetCreate._();
  static $pb.GeneratedMessage $_createMessage() => AssetCreate._();
  @$core.override
  AssetCreate createEmptyInstance() => AssetCreate._();
  @$core.pragma('dart2js:noInline')
  static AssetCreate getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AssetCreate>(
          AssetCreate.$_createMessage);
  static AssetCreate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get quantity => $_getSZ(2);
  @$pb.TagNumber(3)
  set quantity($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get unitPriceMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set unitPriceMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUnitPriceMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearUnitPriceMinor() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get manualPriceMinor => $_getI64(4);
  @$pb.TagNumber(5)
  set manualPriceMinor($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasManualPriceMinor() => $_has(4);
  @$pb.TagNumber(5)
  void clearManualPriceMinor() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get boughtOn => $_getSZ(5);
  @$pb.TagNumber(6)
  set boughtOn($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBoughtOn() => $_has(5);
  @$pb.TagNumber(6)
  void clearBoughtOn() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get clientMutationId => $_getSZ(6);
  @$pb.TagNumber(7)
  set clientMutationId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasClientMutationId() => $_has(6);
  @$pb.TagNumber(7)
  void clearClientMutationId() => $_clearField(7);
}

class AssetListReply extends $pb.GeneratedMessage {
  factory AssetListReply({
    $core.Iterable<AssetMsg>? assets,
    $fixnum.Int64? valueMinor,
    $fixnum.Int64? costMinor,
    $fixnum.Int64? profitMinor,
    $fixnum.Int64? realizedMinor,
  }) {
    final result = AssetListReply._();
    if (assets != null) result.assets.addAll(assets);
    if (valueMinor != null) result.valueMinor = valueMinor;
    if (costMinor != null) result.costMinor = costMinor;
    if (profitMinor != null) result.profitMinor = profitMinor;
    if (realizedMinor != null) result.realizedMinor = realizedMinor;
    return result;
  }

  AssetListReply._();

  factory AssetListReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AssetListReply()..mergeFromBuffer(data, registry);
  factory AssetListReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AssetListReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AssetListReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.assets'),
      createEmptyInstance: AssetListReply.$_createMessage)
    ..pPM<AssetMsg>(1, _omitFieldNames ? '' : 'assets',
        subBuilder: AssetMsg.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'valueMinor')
    ..aInt64(3, _omitFieldNames ? '' : 'costMinor')
    ..aInt64(4, _omitFieldNames ? '' : 'profitMinor')
    ..aInt64(5, _omitFieldNames ? '' : 'realizedMinor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetListReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetListReply copyWith(void Function(AssetListReply) updates) =>
      super.copyWith((message) => updates(message as AssetListReply))
          as AssetListReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AssetListReply() / AssetListReply.new instead')
  static AssetListReply create() => AssetListReply._();
  static $pb.GeneratedMessage $_createMessage() => AssetListReply._();
  @$core.override
  AssetListReply createEmptyInstance() => AssetListReply._();
  @$core.pragma('dart2js:noInline')
  static AssetListReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AssetListReply>(
          AssetListReply.$_createMessage);
  static AssetListReply? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AssetMsg> get assets => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get valueMinor => $_getI64(1);
  @$pb.TagNumber(2)
  set valueMinor($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValueMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearValueMinor() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get costMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set costMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCostMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearCostMinor() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get profitMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set profitMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProfitMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearProfitMinor() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get realizedMinor => $_getI64(4);
  @$pb.TagNumber(5)
  set realizedMinor($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRealizedMinor() => $_has(4);
  @$pb.TagNumber(5)
  void clearRealizedMinor() => $_clearField(5);
}

class AssetMsg extends $pb.GeneratedMessage {
  factory AssetMsg({
    $core.String? id,
    $core.String? symbol,
    $core.String? name,
    $core.String? unit,
    $core.String? quantity,
    $fixnum.Int64? costMinor,
    $fixnum.Int64? valueMinor,
    $fixnum.Int64? profitMinor,
    $fixnum.Int64? realizedMinor,
    $core.String? price,
    $core.bool? priceKnown,
    $core.bool? stale,
  }) {
    final result = AssetMsg._();
    if (id != null) result.id = id;
    if (symbol != null) result.symbol = symbol;
    if (name != null) result.name = name;
    if (unit != null) result.unit = unit;
    if (quantity != null) result.quantity = quantity;
    if (costMinor != null) result.costMinor = costMinor;
    if (valueMinor != null) result.valueMinor = valueMinor;
    if (profitMinor != null) result.profitMinor = profitMinor;
    if (realizedMinor != null) result.realizedMinor = realizedMinor;
    if (price != null) result.price = price;
    if (priceKnown != null) result.priceKnown = priceKnown;
    if (stale != null) result.stale = stale;
    return result;
  }

  AssetMsg._();

  factory AssetMsg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AssetMsg()..mergeFromBuffer(data, registry);
  factory AssetMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AssetMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AssetMsg',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.assets'),
      createEmptyInstance: AssetMsg.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'unit')
    ..aOS(5, _omitFieldNames ? '' : 'quantity')
    ..aInt64(6, _omitFieldNames ? '' : 'costMinor')
    ..aInt64(7, _omitFieldNames ? '' : 'valueMinor')
    ..aInt64(8, _omitFieldNames ? '' : 'profitMinor')
    ..aInt64(9, _omitFieldNames ? '' : 'realizedMinor')
    ..aOS(10, _omitFieldNames ? '' : 'price')
    ..aOB(11, _omitFieldNames ? '' : 'priceKnown')
    ..aOB(12, _omitFieldNames ? '' : 'stale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetMsg copyWith(void Function(AssetMsg) updates) =>
      super.copyWith((message) => updates(message as AssetMsg)) as AssetMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AssetMsg() / AssetMsg.new instead')
  static AssetMsg create() => AssetMsg._();
  static $pb.GeneratedMessage $_createMessage() => AssetMsg._();
  @$core.override
  AssetMsg createEmptyInstance() => AssetMsg._();
  @$core.pragma('dart2js:noInline')
  static AssetMsg getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AssetMsg>(AssetMsg.$_createMessage);
  static AssetMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get symbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set symbol($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearSymbol() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get unit => $_getSZ(3);
  @$pb.TagNumber(4)
  set unit($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUnit() => $_has(3);
  @$pb.TagNumber(4)
  void clearUnit() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get quantity => $_getSZ(4);
  @$pb.TagNumber(5)
  set quantity($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasQuantity() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuantity() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get costMinor => $_getI64(5);
  @$pb.TagNumber(6)
  set costMinor($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCostMinor() => $_has(5);
  @$pb.TagNumber(6)
  void clearCostMinor() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get valueMinor => $_getI64(6);
  @$pb.TagNumber(7)
  set valueMinor($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasValueMinor() => $_has(6);
  @$pb.TagNumber(7)
  void clearValueMinor() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get profitMinor => $_getI64(7);
  @$pb.TagNumber(8)
  set profitMinor($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasProfitMinor() => $_has(7);
  @$pb.TagNumber(8)
  void clearProfitMinor() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get realizedMinor => $_getI64(8);
  @$pb.TagNumber(9)
  set realizedMinor($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRealizedMinor() => $_has(8);
  @$pb.TagNumber(9)
  void clearRealizedMinor() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get price => $_getSZ(9);
  @$pb.TagNumber(10)
  set price($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPrice() => $_has(9);
  @$pb.TagNumber(10)
  void clearPrice() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get priceKnown => $_getBF(10);
  @$pb.TagNumber(11)
  set priceKnown($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasPriceKnown() => $_has(10);
  @$pb.TagNumber(11)
  void clearPriceKnown() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get stale => $_getBF(11);
  @$pb.TagNumber(12)
  set stale($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasStale() => $_has(11);
  @$pb.TagNumber(12)
  void clearStale() => $_clearField(12);
}

class AssetRef extends $pb.GeneratedMessage {
  factory AssetRef({
    $core.String? assetId,
  }) {
    final result = AssetRef._();
    if (assetId != null) result.assetId = assetId;
    return result;
  }

  AssetRef._();

  factory AssetRef.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AssetRef()..mergeFromBuffer(data, registry);
  factory AssetRef.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AssetRef()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AssetRef',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.assets'),
      createEmptyInstance: AssetRef.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'assetId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetRef clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetRef copyWith(void Function(AssetRef) updates) =>
      super.copyWith((message) => updates(message as AssetRef)) as AssetRef;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AssetRef() / AssetRef.new instead')
  static AssetRef create() => AssetRef._();
  static $pb.GeneratedMessage $_createMessage() => AssetRef._();
  @$core.override
  AssetRef createEmptyInstance() => AssetRef._();
  @$core.pragma('dart2js:noInline')
  static AssetRef getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AssetRef>(AssetRef.$_createMessage);
  static AssetRef? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAssetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetId() => $_clearField(1);
}

class AssetReply extends $pb.GeneratedMessage {
  factory AssetReply({
    AssetMsg? asset,
  }) {
    final result = AssetReply._();
    if (asset != null) result.asset = asset;
    return result;
  }

  AssetReply._();

  factory AssetReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AssetReply()..mergeFromBuffer(data, registry);
  factory AssetReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AssetReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AssetReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.assets'),
      createEmptyInstance: AssetReply.$_createMessage)
    ..aOM<AssetMsg>(1, _omitFieldNames ? '' : 'asset',
        subBuilder: AssetMsg.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetReply copyWith(void Function(AssetReply) updates) =>
      super.copyWith((message) => updates(message as AssetReply)) as AssetReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AssetReply() / AssetReply.new instead')
  static AssetReply create() => AssetReply._();
  static $pb.GeneratedMessage $_createMessage() => AssetReply._();
  @$core.override
  AssetReply createEmptyInstance() => AssetReply._();
  @$core.pragma('dart2js:noInline')
  static AssetReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AssetReply>(AssetReply.$_createMessage);
  static AssetReply? _defaultInstance;

  @$pb.TagNumber(1)
  AssetMsg get asset => $_getN(0);
  @$pb.TagNumber(1)
  set asset(AssetMsg value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAsset() => $_has(0);
  @$pb.TagNumber(1)
  void clearAsset() => $_clearField(1);
  @$pb.TagNumber(1)
  AssetMsg ensureAsset() => $_ensure(0);
}

class AssetSell extends $pb.GeneratedMessage {
  factory AssetSell({
    $core.String? assetId,
    $core.String? quantity,
    $fixnum.Int64? unitPriceMinor,
  }) {
    final result = AssetSell._();
    if (assetId != null) result.assetId = assetId;
    if (quantity != null) result.quantity = quantity;
    if (unitPriceMinor != null) result.unitPriceMinor = unitPriceMinor;
    return result;
  }

  AssetSell._();

  factory AssetSell.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AssetSell()..mergeFromBuffer(data, registry);
  factory AssetSell.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AssetSell()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AssetSell',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.assets'),
      createEmptyInstance: AssetSell.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'assetId')
    ..aOS(2, _omitFieldNames ? '' : 'quantity')
    ..aInt64(3, _omitFieldNames ? '' : 'unitPriceMinor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetSell clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetSell copyWith(void Function(AssetSell) updates) =>
      super.copyWith((message) => updates(message as AssetSell)) as AssetSell;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AssetSell() / AssetSell.new instead')
  static AssetSell create() => AssetSell._();
  static $pb.GeneratedMessage $_createMessage() => AssetSell._();
  @$core.override
  AssetSell createEmptyInstance() => AssetSell._();
  @$core.pragma('dart2js:noInline')
  static AssetSell getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AssetSell>(AssetSell.$_createMessage);
  static AssetSell? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAssetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get quantity => $_getSZ(1);
  @$pb.TagNumber(2)
  set quantity($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuantity() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuantity() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get unitPriceMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set unitPriceMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUnitPriceMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnitPriceMinor() => $_clearField(3);
}

class ConvertReply extends $pb.GeneratedMessage {
  factory ConvertReply({
    $fixnum.Int64? amountMinor,
    $core.bool? stale,
  }) {
    final result = ConvertReply._();
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (stale != null) result.stale = stale;
    return result;
  }

  ConvertReply._();

  factory ConvertReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ConvertReply()..mergeFromBuffer(data, registry);
  factory ConvertReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ConvertReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConvertReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.assets'),
      createEmptyInstance: ConvertReply.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'amountMinor')
    ..aOB(2, _omitFieldNames ? '' : 'stale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertReply copyWith(void Function(ConvertReply) updates) =>
      super.copyWith((message) => updates(message as ConvertReply))
          as ConvertReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ConvertReply() / ConvertReply.new instead')
  static ConvertReply create() => ConvertReply._();
  static $pb.GeneratedMessage $_createMessage() => ConvertReply._();
  @$core.override
  ConvertReply createEmptyInstance() => ConvertReply._();
  @$core.pragma('dart2js:noInline')
  static ConvertReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConvertReply>(
          ConvertReply.$_createMessage);
  static ConvertReply? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get amountMinor => $_getI64(0);
  @$pb.TagNumber(1)
  set amountMinor($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmountMinor() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmountMinor() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get stale => $_getBF(1);
  @$pb.TagNumber(2)
  set stale($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStale() => $_has(1);
  @$pb.TagNumber(2)
  void clearStale() => $_clearField(2);
}

class ConvertRequest extends $pb.GeneratedMessage {
  factory ConvertRequest({
    $fixnum.Int64? amountMinor,
    $core.String? fromCurrency,
    $core.String? toCurrency,
  }) {
    final result = ConvertRequest._();
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (fromCurrency != null) result.fromCurrency = fromCurrency;
    if (toCurrency != null) result.toCurrency = toCurrency;
    return result;
  }

  ConvertRequest._();

  factory ConvertRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ConvertRequest()..mergeFromBuffer(data, registry);
  factory ConvertRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ConvertRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConvertRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.assets'),
      createEmptyInstance: ConvertRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'amountMinor')
    ..aOS(2, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(3, _omitFieldNames ? '' : 'toCurrency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertRequest copyWith(void Function(ConvertRequest) updates) =>
      super.copyWith((message) => updates(message as ConvertRequest))
          as ConvertRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ConvertRequest() / ConvertRequest.new instead')
  static ConvertRequest create() => ConvertRequest._();
  static $pb.GeneratedMessage $_createMessage() => ConvertRequest._();
  @$core.override
  ConvertRequest createEmptyInstance() => ConvertRequest._();
  @$core.pragma('dart2js:noInline')
  static ConvertRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConvertRequest>(
          ConvertRequest.$_createMessage);
  static ConvertRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get amountMinor => $_getI64(0);
  @$pb.TagNumber(1)
  set amountMinor($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmountMinor() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmountMinor() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fromCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set fromCurrency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFromCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get toCurrency => $_getSZ(2);
  @$pb.TagNumber(3)
  set toCurrency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasToCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearToCurrency() => $_clearField(3);
}

class LotAdd extends $pb.GeneratedMessage {
  factory LotAdd({
    $core.String? assetId,
    $core.String? quantity,
    $fixnum.Int64? unitPriceMinor,
    $core.String? boughtOn,
  }) {
    final result = LotAdd._();
    if (assetId != null) result.assetId = assetId;
    if (quantity != null) result.quantity = quantity;
    if (unitPriceMinor != null) result.unitPriceMinor = unitPriceMinor;
    if (boughtOn != null) result.boughtOn = boughtOn;
    return result;
  }

  LotAdd._();

  factory LotAdd.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LotAdd()..mergeFromBuffer(data, registry);
  factory LotAdd.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LotAdd()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LotAdd',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.assets'),
      createEmptyInstance: LotAdd.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'assetId')
    ..aOS(2, _omitFieldNames ? '' : 'quantity')
    ..aInt64(3, _omitFieldNames ? '' : 'unitPriceMinor')
    ..aOS(4, _omitFieldNames ? '' : 'boughtOn')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LotAdd clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LotAdd copyWith(void Function(LotAdd) updates) =>
      super.copyWith((message) => updates(message as LotAdd)) as LotAdd;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use LotAdd() / LotAdd.new instead')
  static LotAdd create() => LotAdd._();
  static $pb.GeneratedMessage $_createMessage() => LotAdd._();
  @$core.override
  LotAdd createEmptyInstance() => LotAdd._();
  @$core.pragma('dart2js:noInline')
  static LotAdd getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LotAdd>(LotAdd.$_createMessage);
  static LotAdd? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAssetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get quantity => $_getSZ(1);
  @$pb.TagNumber(2)
  set quantity($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuantity() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuantity() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get unitPriceMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set unitPriceMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUnitPriceMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnitPriceMinor() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get boughtOn => $_getSZ(3);
  @$pb.TagNumber(4)
  set boughtOn($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBoughtOn() => $_has(3);
  @$pb.TagNumber(4)
  void clearBoughtOn() => $_clearField(4);
}

class RateListReply extends $pb.GeneratedMessage {
  factory RateListReply({
    $core.Iterable<RateMsg>? rates,
  }) {
    final result = RateListReply._();
    if (rates != null) result.rates.addAll(rates);
    return result;
  }

  RateListReply._();

  factory RateListReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RateListReply()..mergeFromBuffer(data, registry);
  factory RateListReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RateListReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RateListReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.assets'),
      createEmptyInstance: RateListReply.$_createMessage)
    ..pPM<RateMsg>(1, _omitFieldNames ? '' : 'rates',
        subBuilder: RateMsg.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RateListReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RateListReply copyWith(void Function(RateListReply) updates) =>
      super.copyWith((message) => updates(message as RateListReply))
          as RateListReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RateListReply() / RateListReply.new instead')
  static RateListReply create() => RateListReply._();
  static $pb.GeneratedMessage $_createMessage() => RateListReply._();
  @$core.override
  RateListReply createEmptyInstance() => RateListReply._();
  @$core.pragma('dart2js:noInline')
  static RateListReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RateListReply>(
          RateListReply.$_createMessage);
  static RateListReply? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RateMsg> get rates => $_getList(0);
}

class RateMsg extends $pb.GeneratedMessage {
  factory RateMsg({
    $core.String? symbol,
    $core.String? name,
    $core.String? unit,
    $core.String? group,
    $core.String? price,
    $core.bool? known,
    $core.String? source,
    $core.String? fetchedAt,
    $fixnum.Int64? ageSeconds,
    $core.bool? stale,
  }) {
    final result = RateMsg._();
    if (symbol != null) result.symbol = symbol;
    if (name != null) result.name = name;
    if (unit != null) result.unit = unit;
    if (group != null) result.group = group;
    if (price != null) result.price = price;
    if (known != null) result.known = known;
    if (source != null) result.source = source;
    if (fetchedAt != null) result.fetchedAt = fetchedAt;
    if (ageSeconds != null) result.ageSeconds = ageSeconds;
    if (stale != null) result.stale = stale;
    return result;
  }

  RateMsg._();

  factory RateMsg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RateMsg()..mergeFromBuffer(data, registry);
  factory RateMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RateMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RateMsg',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.assets'),
      createEmptyInstance: RateMsg.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'unit')
    ..aOS(4, _omitFieldNames ? '' : 'group')
    ..aOS(5, _omitFieldNames ? '' : 'price')
    ..aOB(6, _omitFieldNames ? '' : 'known')
    ..aOS(7, _omitFieldNames ? '' : 'source')
    ..aOS(8, _omitFieldNames ? '' : 'fetchedAt')
    ..aInt64(9, _omitFieldNames ? '' : 'ageSeconds')
    ..aOB(10, _omitFieldNames ? '' : 'stale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RateMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RateMsg copyWith(void Function(RateMsg) updates) =>
      super.copyWith((message) => updates(message as RateMsg)) as RateMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RateMsg() / RateMsg.new instead')
  static RateMsg create() => RateMsg._();
  static $pb.GeneratedMessage $_createMessage() => RateMsg._();
  @$core.override
  RateMsg createEmptyInstance() => RateMsg._();
  @$core.pragma('dart2js:noInline')
  static RateMsg getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RateMsg>(RateMsg.$_createMessage);
  static RateMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get unit => $_getSZ(2);
  @$pb.TagNumber(3)
  set unit($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUnit() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get group => $_getSZ(3);
  @$pb.TagNumber(4)
  set group($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasGroup() => $_has(3);
  @$pb.TagNumber(4)
  void clearGroup() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get price => $_getSZ(4);
  @$pb.TagNumber(5)
  set price($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearPrice() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get known => $_getBF(5);
  @$pb.TagNumber(6)
  set known($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasKnown() => $_has(5);
  @$pb.TagNumber(6)
  void clearKnown() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get source => $_getSZ(6);
  @$pb.TagNumber(7)
  set source($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSource() => $_has(6);
  @$pb.TagNumber(7)
  void clearSource() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get fetchedAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set fetchedAt($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasFetchedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearFetchedAt() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get ageSeconds => $_getI64(8);
  @$pb.TagNumber(9)
  set ageSeconds($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasAgeSeconds() => $_has(8);
  @$pb.TagNumber(9)
  void clearAgeSeconds() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get stale => $_getBF(9);
  @$pb.TagNumber(10)
  set stale($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasStale() => $_has(9);
  @$pb.TagNumber(10)
  void clearStale() => $_clearField(10);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
