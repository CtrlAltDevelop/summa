// This is a generated file - do not edit.
//
// Generated from apps/networth/grpc/networth.proto.

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

class BasketCreate extends $pb.GeneratedMessage {
  factory BasketCreate({
    $core.String? name,
    $fixnum.Int64? targetMinor,
    $core.Iterable<BasketItemRefMsg>? items,
    $core.String? clientMutationId,
  }) {
    final result = BasketCreate._();
    if (name != null) result.name = name;
    if (targetMinor != null) result.targetMinor = targetMinor;
    if (items != null) result.items.addAll(items);
    if (clientMutationId != null) result.clientMutationId = clientMutationId;
    return result;
  }

  BasketCreate._();

  factory BasketCreate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BasketCreate()..mergeFromBuffer(data, registry);
  factory BasketCreate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BasketCreate()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BasketCreate',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.networth'),
      createEmptyInstance: BasketCreate.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aInt64(2, _omitFieldNames ? '' : 'targetMinor')
    ..pPM<BasketItemRefMsg>(3, _omitFieldNames ? '' : 'items',
        subBuilder: BasketItemRefMsg.$_createMessage)
    ..aOS(4, _omitFieldNames ? '' : 'clientMutationId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BasketCreate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BasketCreate copyWith(void Function(BasketCreate) updates) =>
      super.copyWith((message) => updates(message as BasketCreate))
          as BasketCreate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BasketCreate() / BasketCreate.new instead')
  static BasketCreate create() => BasketCreate._();
  static $pb.GeneratedMessage $_createMessage() => BasketCreate._();
  @$core.override
  BasketCreate createEmptyInstance() => BasketCreate._();
  @$core.pragma('dart2js:noInline')
  static BasketCreate getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BasketCreate>(
          BasketCreate.$_createMessage);
  static BasketCreate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get targetMinor => $_getI64(1);
  @$pb.TagNumber(2)
  set targetMinor($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTargetMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetMinor() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<BasketItemRefMsg> get items => $_getList(2);

  @$pb.TagNumber(4)
  $core.String get clientMutationId => $_getSZ(3);
  @$pb.TagNumber(4)
  set clientMutationId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasClientMutationId() => $_has(3);
  @$pb.TagNumber(4)
  void clearClientMutationId() => $_clearField(4);
}

class BasketItemMsg extends $pb.GeneratedMessage {
  factory BasketItemMsg({
    $core.String? kind,
    $core.String? refId,
    $core.String? name,
    $fixnum.Int64? valueMinor,
  }) {
    final result = BasketItemMsg._();
    if (kind != null) result.kind = kind;
    if (refId != null) result.refId = refId;
    if (name != null) result.name = name;
    if (valueMinor != null) result.valueMinor = valueMinor;
    return result;
  }

  BasketItemMsg._();

  factory BasketItemMsg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BasketItemMsg()..mergeFromBuffer(data, registry);
  factory BasketItemMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BasketItemMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BasketItemMsg',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.networth'),
      createEmptyInstance: BasketItemMsg.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'kind')
    ..aOS(2, _omitFieldNames ? '' : 'refId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aInt64(4, _omitFieldNames ? '' : 'valueMinor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BasketItemMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BasketItemMsg copyWith(void Function(BasketItemMsg) updates) =>
      super.copyWith((message) => updates(message as BasketItemMsg))
          as BasketItemMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BasketItemMsg() / BasketItemMsg.new instead')
  static BasketItemMsg create() => BasketItemMsg._();
  static $pb.GeneratedMessage $_createMessage() => BasketItemMsg._();
  @$core.override
  BasketItemMsg createEmptyInstance() => BasketItemMsg._();
  @$core.pragma('dart2js:noInline')
  static BasketItemMsg getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BasketItemMsg>(
          BasketItemMsg.$_createMessage);
  static BasketItemMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get kind => $_getSZ(0);
  @$pb.TagNumber(1)
  set kind($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get refId => $_getSZ(1);
  @$pb.TagNumber(2)
  set refId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRefId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get valueMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set valueMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasValueMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearValueMinor() => $_clearField(4);
}

class BasketItemRefMsg extends $pb.GeneratedMessage {
  factory BasketItemRefMsg({
    $core.String? kind,
    $core.String? refId,
  }) {
    final result = BasketItemRefMsg._();
    if (kind != null) result.kind = kind;
    if (refId != null) result.refId = refId;
    return result;
  }

  BasketItemRefMsg._();

  factory BasketItemRefMsg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BasketItemRefMsg()..mergeFromBuffer(data, registry);
  factory BasketItemRefMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BasketItemRefMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BasketItemRefMsg',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.networth'),
      createEmptyInstance: BasketItemRefMsg.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'kind')
    ..aOS(2, _omitFieldNames ? '' : 'refId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BasketItemRefMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BasketItemRefMsg copyWith(void Function(BasketItemRefMsg) updates) =>
      super.copyWith((message) => updates(message as BasketItemRefMsg))
          as BasketItemRefMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BasketItemRefMsg() / BasketItemRefMsg.new instead')
  static BasketItemRefMsg create() => BasketItemRefMsg._();
  static $pb.GeneratedMessage $_createMessage() => BasketItemRefMsg._();
  @$core.override
  BasketItemRefMsg createEmptyInstance() => BasketItemRefMsg._();
  @$core.pragma('dart2js:noInline')
  static BasketItemRefMsg getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BasketItemRefMsg>(
          BasketItemRefMsg.$_createMessage);
  static BasketItemRefMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get kind => $_getSZ(0);
  @$pb.TagNumber(1)
  set kind($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get refId => $_getSZ(1);
  @$pb.TagNumber(2)
  set refId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRefId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefId() => $_clearField(2);
}

class BasketListReply extends $pb.GeneratedMessage {
  factory BasketListReply({
    $core.Iterable<BasketMsg>? baskets,
  }) {
    final result = BasketListReply._();
    if (baskets != null) result.baskets.addAll(baskets);
    return result;
  }

  BasketListReply._();

  factory BasketListReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BasketListReply()..mergeFromBuffer(data, registry);
  factory BasketListReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BasketListReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BasketListReply',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.networth'),
      createEmptyInstance: BasketListReply.$_createMessage)
    ..pPM<BasketMsg>(1, _omitFieldNames ? '' : 'baskets',
        subBuilder: BasketMsg.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BasketListReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BasketListReply copyWith(void Function(BasketListReply) updates) =>
      super.copyWith((message) => updates(message as BasketListReply))
          as BasketListReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BasketListReply() / BasketListReply.new instead')
  static BasketListReply create() => BasketListReply._();
  static $pb.GeneratedMessage $_createMessage() => BasketListReply._();
  @$core.override
  BasketListReply createEmptyInstance() => BasketListReply._();
  @$core.pragma('dart2js:noInline')
  static BasketListReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BasketListReply>(
          BasketListReply.$_createMessage);
  static BasketListReply? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<BasketMsg> get baskets => $_getList(0);
}

class BasketMsg extends $pb.GeneratedMessage {
  factory BasketMsg({
    $core.String? id,
    $core.String? name,
    $fixnum.Int64? targetMinor,
    $fixnum.Int64? valueMinor,
    $fixnum.Int64? percent,
    $core.Iterable<BasketItemMsg>? items,
  }) {
    final result = BasketMsg._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (targetMinor != null) result.targetMinor = targetMinor;
    if (valueMinor != null) result.valueMinor = valueMinor;
    if (percent != null) result.percent = percent;
    if (items != null) result.items.addAll(items);
    return result;
  }

  BasketMsg._();

  factory BasketMsg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BasketMsg()..mergeFromBuffer(data, registry);
  factory BasketMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BasketMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BasketMsg',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.networth'),
      createEmptyInstance: BasketMsg.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aInt64(3, _omitFieldNames ? '' : 'targetMinor')
    ..aInt64(4, _omitFieldNames ? '' : 'valueMinor')
    ..aInt64(5, _omitFieldNames ? '' : 'percent')
    ..pPM<BasketItemMsg>(6, _omitFieldNames ? '' : 'items',
        subBuilder: BasketItemMsg.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BasketMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BasketMsg copyWith(void Function(BasketMsg) updates) =>
      super.copyWith((message) => updates(message as BasketMsg)) as BasketMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BasketMsg() / BasketMsg.new instead')
  static BasketMsg create() => BasketMsg._();
  static $pb.GeneratedMessage $_createMessage() => BasketMsg._();
  @$core.override
  BasketMsg createEmptyInstance() => BasketMsg._();
  @$core.pragma('dart2js:noInline')
  static BasketMsg getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BasketMsg>(BasketMsg.$_createMessage);
  static BasketMsg? _defaultInstance;

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
  $fixnum.Int64 get targetMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set targetMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTargetMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetMinor() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get valueMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set valueMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasValueMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearValueMinor() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get percent => $_getI64(4);
  @$pb.TagNumber(5)
  set percent($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPercent() => $_has(4);
  @$pb.TagNumber(5)
  void clearPercent() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<BasketItemMsg> get items => $_getList(5);
}

class BasketRef extends $pb.GeneratedMessage {
  factory BasketRef({
    $core.String? basketId,
  }) {
    final result = BasketRef._();
    if (basketId != null) result.basketId = basketId;
    return result;
  }

  BasketRef._();

  factory BasketRef.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BasketRef()..mergeFromBuffer(data, registry);
  factory BasketRef.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BasketRef()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BasketRef',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.networth'),
      createEmptyInstance: BasketRef.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'basketId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BasketRef clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BasketRef copyWith(void Function(BasketRef) updates) =>
      super.copyWith((message) => updates(message as BasketRef)) as BasketRef;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BasketRef() / BasketRef.new instead')
  static BasketRef create() => BasketRef._();
  static $pb.GeneratedMessage $_createMessage() => BasketRef._();
  @$core.override
  BasketRef createEmptyInstance() => BasketRef._();
  @$core.pragma('dart2js:noInline')
  static BasketRef getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BasketRef>(BasketRef.$_createMessage);
  static BasketRef? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get basketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set basketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBasketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBasketId() => $_clearField(1);
}

class BasketReply extends $pb.GeneratedMessage {
  factory BasketReply({
    BasketMsg? basket,
  }) {
    final result = BasketReply._();
    if (basket != null) result.basket = basket;
    return result;
  }

  BasketReply._();

  factory BasketReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BasketReply()..mergeFromBuffer(data, registry);
  factory BasketReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BasketReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BasketReply',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.networth'),
      createEmptyInstance: BasketReply.$_createMessage)
    ..aOM<BasketMsg>(1, _omitFieldNames ? '' : 'basket',
        subBuilder: BasketMsg.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BasketReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BasketReply copyWith(void Function(BasketReply) updates) =>
      super.copyWith((message) => updates(message as BasketReply))
          as BasketReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BasketReply() / BasketReply.new instead')
  static BasketReply create() => BasketReply._();
  static $pb.GeneratedMessage $_createMessage() => BasketReply._();
  @$core.override
  BasketReply createEmptyInstance() => BasketReply._();
  @$core.pragma('dart2js:noInline')
  static BasketReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BasketReply>(
          BasketReply.$_createMessage);
  static BasketReply? _defaultInstance;

  @$pb.TagNumber(1)
  BasketMsg get basket => $_getN(0);
  @$pb.TagNumber(1)
  set basket(BasketMsg value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBasket() => $_has(0);
  @$pb.TagNumber(1)
  void clearBasket() => $_clearField(1);
  @$pb.TagNumber(1)
  BasketMsg ensureBasket() => $_ensure(0);
}

class NetWorthReply extends $pb.GeneratedMessage {
  factory NetWorthReply({
    $fixnum.Int64? totalMinor,
    $fixnum.Int64? walletsMinor,
    $fixnum.Int64? assetsMinor,
    $fixnum.Int64? debtsMinor,
    $core.bool? usdPresent,
    $fixnum.Int64? usdMinor,
    $core.String? goldGrams,
    $core.bool? stale,
    $core.Iterable<$core.String>? unconverted,
    $core.int? unpricedAssets,
  }) {
    final result = NetWorthReply._();
    if (totalMinor != null) result.totalMinor = totalMinor;
    if (walletsMinor != null) result.walletsMinor = walletsMinor;
    if (assetsMinor != null) result.assetsMinor = assetsMinor;
    if (debtsMinor != null) result.debtsMinor = debtsMinor;
    if (usdPresent != null) result.usdPresent = usdPresent;
    if (usdMinor != null) result.usdMinor = usdMinor;
    if (goldGrams != null) result.goldGrams = goldGrams;
    if (stale != null) result.stale = stale;
    if (unconverted != null) result.unconverted.addAll(unconverted);
    if (unpricedAssets != null) result.unpricedAssets = unpricedAssets;
    return result;
  }

  NetWorthReply._();

  factory NetWorthReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NetWorthReply()..mergeFromBuffer(data, registry);
  factory NetWorthReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NetWorthReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NetWorthReply',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.networth'),
      createEmptyInstance: NetWorthReply.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'totalMinor')
    ..aInt64(2, _omitFieldNames ? '' : 'walletsMinor')
    ..aInt64(3, _omitFieldNames ? '' : 'assetsMinor')
    ..aInt64(4, _omitFieldNames ? '' : 'debtsMinor')
    ..aOB(5, _omitFieldNames ? '' : 'usdPresent')
    ..aInt64(6, _omitFieldNames ? '' : 'usdMinor')
    ..aOS(7, _omitFieldNames ? '' : 'goldGrams')
    ..aOB(8, _omitFieldNames ? '' : 'stale')
    ..pPS(9, _omitFieldNames ? '' : 'unconverted')
    ..aI(10, _omitFieldNames ? '' : 'unpricedAssets')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NetWorthReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NetWorthReply copyWith(void Function(NetWorthReply) updates) =>
      super.copyWith((message) => updates(message as NetWorthReply))
          as NetWorthReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use NetWorthReply() / NetWorthReply.new instead')
  static NetWorthReply create() => NetWorthReply._();
  static $pb.GeneratedMessage $_createMessage() => NetWorthReply._();
  @$core.override
  NetWorthReply createEmptyInstance() => NetWorthReply._();
  @$core.pragma('dart2js:noInline')
  static NetWorthReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NetWorthReply>(
          NetWorthReply.$_createMessage);
  static NetWorthReply? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get totalMinor => $_getI64(0);
  @$pb.TagNumber(1)
  set totalMinor($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalMinor() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalMinor() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get walletsMinor => $_getI64(1);
  @$pb.TagNumber(2)
  set walletsMinor($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWalletsMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearWalletsMinor() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get assetsMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set assetsMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAssetsMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAssetsMinor() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get debtsMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set debtsMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDebtsMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearDebtsMinor() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get usdPresent => $_getBF(4);
  @$pb.TagNumber(5)
  set usdPresent($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUsdPresent() => $_has(4);
  @$pb.TagNumber(5)
  void clearUsdPresent() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get usdMinor => $_getI64(5);
  @$pb.TagNumber(6)
  set usdMinor($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasUsdMinor() => $_has(5);
  @$pb.TagNumber(6)
  void clearUsdMinor() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get goldGrams => $_getSZ(6);
  @$pb.TagNumber(7)
  set goldGrams($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasGoldGrams() => $_has(6);
  @$pb.TagNumber(7)
  void clearGoldGrams() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get stale => $_getBF(7);
  @$pb.TagNumber(8)
  set stale($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStale() => $_has(7);
  @$pb.TagNumber(8)
  void clearStale() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get unconverted => $_getList(8);

  @$pb.TagNumber(10)
  $core.int get unpricedAssets => $_getIZ(9);
  @$pb.TagNumber(10)
  set unpricedAssets($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasUnpricedAssets() => $_has(9);
  @$pb.TagNumber(10)
  void clearUnpricedAssets() => $_clearField(10);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
