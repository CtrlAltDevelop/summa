// This is a generated file - do not edit.
//
// Generated from apps/reports/grpc/reports.proto.

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

class CategoryTotalMsg extends $pb.GeneratedMessage {
  factory CategoryTotalMsg({
    $core.String? categoryId,
    $core.String? name,
    $core.String? kind,
    $fixnum.Int64? totalMinor,
  }) {
    final result = CategoryTotalMsg._();
    if (categoryId != null) result.categoryId = categoryId;
    if (name != null) result.name = name;
    if (kind != null) result.kind = kind;
    if (totalMinor != null) result.totalMinor = totalMinor;
    return result;
  }

  CategoryTotalMsg._();

  factory CategoryTotalMsg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CategoryTotalMsg()..mergeFromBuffer(data, registry);
  factory CategoryTotalMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CategoryTotalMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CategoryTotalMsg',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.reports'),
      createEmptyInstance: CategoryTotalMsg.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'categoryId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'kind')
    ..aInt64(4, _omitFieldNames ? '' : 'totalMinor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CategoryTotalMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CategoryTotalMsg copyWith(void Function(CategoryTotalMsg) updates) =>
      super.copyWith((message) => updates(message as CategoryTotalMsg))
          as CategoryTotalMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CategoryTotalMsg() / CategoryTotalMsg.new instead')
  static CategoryTotalMsg create() => CategoryTotalMsg._();
  static $pb.GeneratedMessage $_createMessage() => CategoryTotalMsg._();
  @$core.override
  CategoryTotalMsg createEmptyInstance() => CategoryTotalMsg._();
  @$core.pragma('dart2js:noInline')
  static CategoryTotalMsg getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CategoryTotalMsg>(
          CategoryTotalMsg.$_createMessage);
  static CategoryTotalMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get categoryId => $_getSZ(0);
  @$pb.TagNumber(1)
  set categoryId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCategoryId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategoryId() => $_clearField(1);

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
  $fixnum.Int64 get totalMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set totalMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalMinor() => $_clearField(4);
}

class DayTotalMsg extends $pb.GeneratedMessage {
  factory DayTotalMsg({
    $core.String? day,
    $fixnum.Int64? incomeMinor,
    $fixnum.Int64? expenseMinor,
  }) {
    final result = DayTotalMsg._();
    if (day != null) result.day = day;
    if (incomeMinor != null) result.incomeMinor = incomeMinor;
    if (expenseMinor != null) result.expenseMinor = expenseMinor;
    return result;
  }

  DayTotalMsg._();

  factory DayTotalMsg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DayTotalMsg()..mergeFromBuffer(data, registry);
  factory DayTotalMsg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DayTotalMsg()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DayTotalMsg',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.reports'),
      createEmptyInstance: DayTotalMsg.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'day')
    ..aInt64(2, _omitFieldNames ? '' : 'incomeMinor')
    ..aInt64(3, _omitFieldNames ? '' : 'expenseMinor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DayTotalMsg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DayTotalMsg copyWith(void Function(DayTotalMsg) updates) =>
      super.copyWith((message) => updates(message as DayTotalMsg))
          as DayTotalMsg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DayTotalMsg() / DayTotalMsg.new instead')
  static DayTotalMsg create() => DayTotalMsg._();
  static $pb.GeneratedMessage $_createMessage() => DayTotalMsg._();
  @$core.override
  DayTotalMsg createEmptyInstance() => DayTotalMsg._();
  @$core.pragma('dart2js:noInline')
  static DayTotalMsg getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DayTotalMsg>(
          DayTotalMsg.$_createMessage);
  static DayTotalMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get day => $_getSZ(0);
  @$pb.TagNumber(1)
  set day($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDay() => $_has(0);
  @$pb.TagNumber(1)
  void clearDay() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get incomeMinor => $_getI64(1);
  @$pb.TagNumber(2)
  set incomeMinor($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIncomeMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncomeMinor() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get expenseMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set expenseMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExpenseMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpenseMinor() => $_clearField(3);
}

class ExportReply extends $pb.GeneratedMessage {
  factory ExportReply({
    $core.String? filename,
    $core.List<$core.int>? content,
  }) {
    final result = ExportReply._();
    if (filename != null) result.filename = filename;
    if (content != null) result.content = content;
    return result;
  }

  ExportReply._();

  factory ExportReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExportReply()..mergeFromBuffer(data, registry);
  factory ExportReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExportReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExportReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.reports'),
      createEmptyInstance: ExportReply.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'filename')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'content', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportReply copyWith(void Function(ExportReply) updates) =>
      super.copyWith((message) => updates(message as ExportReply))
          as ExportReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ExportReply() / ExportReply.new instead')
  static ExportReply create() => ExportReply._();
  static $pb.GeneratedMessage $_createMessage() => ExportReply._();
  @$core.override
  ExportReply createEmptyInstance() => ExportReply._();
  @$core.pragma('dart2js:noInline')
  static ExportReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExportReply>(
          ExportReply.$_createMessage);
  static ExportReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get filename => $_getSZ(0);
  @$pb.TagNumber(1)
  set filename($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFilename() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilename() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get content => $_getN(1);
  @$pb.TagNumber(2)
  set content($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => $_clearField(2);
}

class ExportRequest extends $pb.GeneratedMessage {
  factory ExportRequest({
    $core.String? startsAt,
    $core.String? endsAt,
  }) {
    final result = ExportRequest._();
    if (startsAt != null) result.startsAt = startsAt;
    if (endsAt != null) result.endsAt = endsAt;
    return result;
  }

  ExportRequest._();

  factory ExportRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExportRequest()..mergeFromBuffer(data, registry);
  factory ExportRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExportRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExportRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.reports'),
      createEmptyInstance: ExportRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'startsAt')
    ..aOS(2, _omitFieldNames ? '' : 'endsAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportRequest copyWith(void Function(ExportRequest) updates) =>
      super.copyWith((message) => updates(message as ExportRequest))
          as ExportRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ExportRequest() / ExportRequest.new instead')
  static ExportRequest create() => ExportRequest._();
  static $pb.GeneratedMessage $_createMessage() => ExportRequest._();
  @$core.override
  ExportRequest createEmptyInstance() => ExportRequest._();
  @$core.pragma('dart2js:noInline')
  static ExportRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExportRequest>(
          ExportRequest.$_createMessage);
  static ExportRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get startsAt => $_getSZ(0);
  @$pb.TagNumber(1)
  set startsAt($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStartsAt() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartsAt() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get endsAt => $_getSZ(1);
  @$pb.TagNumber(2)
  set endsAt($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEndsAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndsAt() => $_clearField(2);
}

class ReportReply extends $pb.GeneratedMessage {
  factory ReportReply({
    $core.String? currency,
    $fixnum.Int64? incomeMinor,
    $fixnum.Int64? expenseMinor,
    $fixnum.Int64? netMinor,
    $core.int? entries,
    $core.Iterable<CategoryTotalMsg>? byCategory,
    $core.Iterable<DayTotalMsg>? daily,
    $core.String? topExpenseCategory,
    $core.Iterable<$core.String>? currencies,
  }) {
    final result = ReportReply._();
    if (currency != null) result.currency = currency;
    if (incomeMinor != null) result.incomeMinor = incomeMinor;
    if (expenseMinor != null) result.expenseMinor = expenseMinor;
    if (netMinor != null) result.netMinor = netMinor;
    if (entries != null) result.entries = entries;
    if (byCategory != null) result.byCategory.addAll(byCategory);
    if (daily != null) result.daily.addAll(daily);
    if (topExpenseCategory != null)
      result.topExpenseCategory = topExpenseCategory;
    if (currencies != null) result.currencies.addAll(currencies);
    return result;
  }

  ReportReply._();

  factory ReportReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReportReply()..mergeFromBuffer(data, registry);
  factory ReportReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReportReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReportReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.reports'),
      createEmptyInstance: ReportReply.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'currency')
    ..aInt64(2, _omitFieldNames ? '' : 'incomeMinor')
    ..aInt64(3, _omitFieldNames ? '' : 'expenseMinor')
    ..aInt64(4, _omitFieldNames ? '' : 'netMinor')
    ..aI(5, _omitFieldNames ? '' : 'entries')
    ..pPM<CategoryTotalMsg>(6, _omitFieldNames ? '' : 'byCategory',
        subBuilder: CategoryTotalMsg.$_createMessage)
    ..pPM<DayTotalMsg>(7, _omitFieldNames ? '' : 'daily',
        subBuilder: DayTotalMsg.$_createMessage)
    ..aOS(8, _omitFieldNames ? '' : 'topExpenseCategory')
    ..pPS(9, _omitFieldNames ? '' : 'currencies')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReportReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReportReply copyWith(void Function(ReportReply) updates) =>
      super.copyWith((message) => updates(message as ReportReply))
          as ReportReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ReportReply() / ReportReply.new instead')
  static ReportReply create() => ReportReply._();
  static $pb.GeneratedMessage $_createMessage() => ReportReply._();
  @$core.override
  ReportReply createEmptyInstance() => ReportReply._();
  @$core.pragma('dart2js:noInline')
  static ReportReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReportReply>(
          ReportReply.$_createMessage);
  static ReportReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currency => $_getSZ(0);
  @$pb.TagNumber(1)
  set currency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrency() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get incomeMinor => $_getI64(1);
  @$pb.TagNumber(2)
  set incomeMinor($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIncomeMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncomeMinor() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get expenseMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set expenseMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExpenseMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpenseMinor() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get netMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set netMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNetMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearNetMinor() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get entries => $_getIZ(4);
  @$pb.TagNumber(5)
  set entries($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEntries() => $_has(4);
  @$pb.TagNumber(5)
  void clearEntries() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<CategoryTotalMsg> get byCategory => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<DayTotalMsg> get daily => $_getList(6);

  @$pb.TagNumber(8)
  $core.String get topExpenseCategory => $_getSZ(7);
  @$pb.TagNumber(8)
  set topExpenseCategory($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTopExpenseCategory() => $_has(7);
  @$pb.TagNumber(8)
  void clearTopExpenseCategory() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get currencies => $_getList(8);
}

class ReportRequest extends $pb.GeneratedMessage {
  factory ReportRequest({
    $core.String? startsAt,
    $core.String? endsAt,
    $core.String? currency,
  }) {
    final result = ReportRequest._();
    if (startsAt != null) result.startsAt = startsAt;
    if (endsAt != null) result.endsAt = endsAt;
    if (currency != null) result.currency = currency;
    return result;
  }

  ReportRequest._();

  factory ReportRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReportRequest()..mergeFromBuffer(data, registry);
  factory ReportRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReportRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReportRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.reports'),
      createEmptyInstance: ReportRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'startsAt')
    ..aOS(2, _omitFieldNames ? '' : 'endsAt')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReportRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReportRequest copyWith(void Function(ReportRequest) updates) =>
      super.copyWith((message) => updates(message as ReportRequest))
          as ReportRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ReportRequest() / ReportRequest.new instead')
  static ReportRequest create() => ReportRequest._();
  static $pb.GeneratedMessage $_createMessage() => ReportRequest._();
  @$core.override
  ReportRequest createEmptyInstance() => ReportRequest._();
  @$core.pragma('dart2js:noInline')
  static ReportRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReportRequest>(
          ReportRequest.$_createMessage);
  static ReportRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get startsAt => $_getSZ(0);
  @$pb.TagNumber(1)
  set startsAt($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStartsAt() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartsAt() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get endsAt => $_getSZ(1);
  @$pb.TagNumber(2)
  set endsAt($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEndsAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndsAt() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
