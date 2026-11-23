// This is a generated file - do not edit.
//
// Generated from apps/support/grpc/support.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Account extends $pb.GeneratedMessage {
  factory Account({
    $core.String? id,
    $core.String? username,
    $core.bool? staff,
  }) {
    final result = Account._();
    if (id != null) result.id = id;
    if (username != null) result.username = username;
    if (staff != null) result.staff = staff;
    return result;
  }

  Account._();

  factory Account.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Account()..mergeFromBuffer(data, registry);
  factory Account.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Account()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Account',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: Account.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOB(3, _omitFieldNames ? '' : 'staff')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Account clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Account copyWith(void Function(Account) updates) =>
      super.copyWith((message) => updates(message as Account)) as Account;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Account() / Account.new instead')
  static Account create() => Account._();
  static $pb.GeneratedMessage $_createMessage() => Account._();
  @$core.override
  Account createEmptyInstance() => Account._();
  @$core.pragma('dart2js:noInline')
  static Account getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Account>(Account.$_createMessage);
  static Account? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get staff => $_getBF(2);
  @$pb.TagNumber(3)
  set staff($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStaff() => $_has(2);
  @$pb.TagNumber(3)
  void clearStaff() => $_clearField(3);
}

class AccountResponse extends $pb.GeneratedMessage {
  factory AccountResponse({
    $core.String? id,
    $core.String? username,
    $core.bool? staff,
  }) {
    final result = AccountResponse._();
    if (id != null) result.id = id;
    if (username != null) result.username = username;
    if (staff != null) result.staff = staff;
    return result;
  }

  AccountResponse._();

  factory AccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AccountResponse()..mergeFromBuffer(data, registry);
  factory AccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AccountResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: AccountResponse.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOB(3, _omitFieldNames ? '' : 'staff')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccountResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccountResponse copyWith(void Function(AccountResponse) updates) =>
      super.copyWith((message) => updates(message as AccountResponse))
          as AccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AccountResponse() / AccountResponse.new instead')
  static AccountResponse create() => AccountResponse._();
  static $pb.GeneratedMessage $_createMessage() => AccountResponse._();
  @$core.override
  AccountResponse createEmptyInstance() => AccountResponse._();
  @$core.pragma('dart2js:noInline')
  static AccountResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccountResponse>(
          AccountResponse.$_createMessage);
  static AccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get staff => $_getBF(2);
  @$pb.TagNumber(3)
  set staff($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStaff() => $_has(2);
  @$pb.TagNumber(3)
  void clearStaff() => $_clearField(3);
}

class AssignRequest extends $pb.GeneratedMessage {
  factory AssignRequest({
    $core.String? ticketId,
    $core.String? agent,
  }) {
    final result = AssignRequest._();
    if (ticketId != null) result.ticketId = ticketId;
    if (agent != null) result.agent = agent;
    return result;
  }

  AssignRequest._();

  factory AssignRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AssignRequest()..mergeFromBuffer(data, registry);
  factory AssignRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AssignRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AssignRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: AssignRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..aOS(2, _omitFieldNames ? '' : 'agent')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssignRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssignRequest copyWith(void Function(AssignRequest) updates) =>
      super.copyWith((message) => updates(message as AssignRequest))
          as AssignRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AssignRequest() / AssignRequest.new instead')
  static AssignRequest create() => AssignRequest._();
  static $pb.GeneratedMessage $_createMessage() => AssignRequest._();
  @$core.override
  AssignRequest createEmptyInstance() => AssignRequest._();
  @$core.pragma('dart2js:noInline')
  static AssignRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AssignRequest>(
          AssignRequest.$_createMessage);
  static AssignRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get agent => $_getSZ(1);
  @$pb.TagNumber(2)
  set agent($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAgent() => $_has(1);
  @$pb.TagNumber(2)
  void clearAgent() => $_clearField(2);
}

class AssignResult extends $pb.GeneratedMessage {
  factory AssignResult({
    $core.String? ticket,
    Account? assignee,
    $core.bool? changed,
  }) {
    final result = AssignResult._();
    if (ticket != null) result.ticket = ticket;
    if (assignee != null) result.assignee = assignee;
    if (changed != null) result.changed = changed;
    return result;
  }

  AssignResult._();

  factory AssignResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AssignResult()..mergeFromBuffer(data, registry);
  factory AssignResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AssignResult()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AssignResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: AssignResult.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticket')
    ..aOM<Account>(2, _omitFieldNames ? '' : 'assignee',
        subBuilder: Account.$_createMessage)
    ..aOB(3, _omitFieldNames ? '' : 'changed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssignResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssignResult copyWith(void Function(AssignResult) updates) =>
      super.copyWith((message) => updates(message as AssignResult))
          as AssignResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AssignResult() / AssignResult.new instead')
  static AssignResult create() => AssignResult._();
  static $pb.GeneratedMessage $_createMessage() => AssignResult._();
  @$core.override
  AssignResult createEmptyInstance() => AssignResult._();
  @$core.pragma('dart2js:noInline')
  static AssignResult getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AssignResult>(
          AssignResult.$_createMessage);
  static AssignResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticket => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticket($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicket() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicket() => $_clearField(1);

  @$pb.TagNumber(2)
  Account get assignee => $_getN(1);
  @$pb.TagNumber(2)
  set assignee(Account value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAssignee() => $_has(1);
  @$pb.TagNumber(2)
  void clearAssignee() => $_clearField(2);
  @$pb.TagNumber(2)
  Account ensureAssignee() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get changed => $_getBF(2);
  @$pb.TagNumber(3)
  set changed($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChanged() => $_has(2);
  @$pb.TagNumber(3)
  void clearChanged() => $_clearField(3);
}

class Attachment extends $pb.GeneratedMessage {
  factory Attachment({
    $core.String? id,
    $core.String? name,
    $core.String? url,
    $core.String? contentType,
    $core.int? size,
  }) {
    final result = Attachment._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (url != null) result.url = url;
    if (contentType != null) result.contentType = contentType;
    if (size != null) result.size = size;
    return result;
  }

  Attachment._();

  factory Attachment.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Attachment()..mergeFromBuffer(data, registry);
  factory Attachment.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Attachment()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Attachment',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: Attachment.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'url')
    ..aOS(4, _omitFieldNames ? '' : 'contentType')
    ..aI(5, _omitFieldNames ? '' : 'size')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Attachment clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Attachment copyWith(void Function(Attachment) updates) =>
      super.copyWith((message) => updates(message as Attachment)) as Attachment;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Attachment() / Attachment.new instead')
  static Attachment create() => Attachment._();
  static $pb.GeneratedMessage $_createMessage() => Attachment._();
  @$core.override
  Attachment createEmptyInstance() => Attachment._();
  @$core.pragma('dart2js:noInline')
  static Attachment getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Attachment>(Attachment.$_createMessage);
  static Attachment? _defaultInstance;

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
  $core.String get url => $_getSZ(2);
  @$pb.TagNumber(3)
  set url($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get contentType => $_getSZ(3);
  @$pb.TagNumber(4)
  set contentType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasContentType() => $_has(3);
  @$pb.TagNumber(4)
  void clearContentType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get size => $_getIZ(4);
  @$pb.TagNumber(5)
  set size($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearSize() => $_clearField(5);
}

class AttachmentResponse extends $pb.GeneratedMessage {
  factory AttachmentResponse({
    $core.String? id,
    $core.String? name,
    $core.String? url,
    $core.String? contentType,
    $core.int? size,
  }) {
    final result = AttachmentResponse._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (url != null) result.url = url;
    if (contentType != null) result.contentType = contentType;
    if (size != null) result.size = size;
    return result;
  }

  AttachmentResponse._();

  factory AttachmentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AttachmentResponse()..mergeFromBuffer(data, registry);
  factory AttachmentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AttachmentResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AttachmentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: AttachmentResponse.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'url')
    ..aOS(4, _omitFieldNames ? '' : 'contentType')
    ..aI(5, _omitFieldNames ? '' : 'size')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AttachmentResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AttachmentResponse copyWith(void Function(AttachmentResponse) updates) =>
      super.copyWith((message) => updates(message as AttachmentResponse))
          as AttachmentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AttachmentResponse() / AttachmentResponse.new instead')
  static AttachmentResponse create() => AttachmentResponse._();
  static $pb.GeneratedMessage $_createMessage() => AttachmentResponse._();
  @$core.override
  AttachmentResponse createEmptyInstance() => AttachmentResponse._();
  @$core.pragma('dart2js:noInline')
  static AttachmentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AttachmentResponse>(
          AttachmentResponse.$_createMessage);
  static AttachmentResponse? _defaultInstance;

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
  $core.String get url => $_getSZ(2);
  @$pb.TagNumber(3)
  set url($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get contentType => $_getSZ(3);
  @$pb.TagNumber(4)
  set contentType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasContentType() => $_has(3);
  @$pb.TagNumber(4)
  void clearContentType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get size => $_getIZ(4);
  @$pb.TagNumber(5)
  set size($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearSize() => $_clearField(5);
}

class CannedList extends $pb.GeneratedMessage {
  factory CannedList({
    $core.Iterable<CannedReply>? replies,
  }) {
    final result = CannedList._();
    if (replies != null) result.replies.addAll(replies);
    return result;
  }

  CannedList._();

  factory CannedList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CannedList()..mergeFromBuffer(data, registry);
  factory CannedList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CannedList()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CannedList',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: CannedList.$_createMessage)
    ..pPM<CannedReply>(1, _omitFieldNames ? '' : 'replies',
        subBuilder: CannedReply.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CannedList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CannedList copyWith(void Function(CannedList) updates) =>
      super.copyWith((message) => updates(message as CannedList)) as CannedList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CannedList() / CannedList.new instead')
  static CannedList create() => CannedList._();
  static $pb.GeneratedMessage $_createMessage() => CannedList._();
  @$core.override
  CannedList createEmptyInstance() => CannedList._();
  @$core.pragma('dart2js:noInline')
  static CannedList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CannedList>(CannedList.$_createMessage);
  static CannedList? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CannedReply> get replies => $_getList(0);
}

class CannedReply extends $pb.GeneratedMessage {
  factory CannedReply({
    $core.String? id,
    $core.String? title,
    $core.String? body,
    $core.String? category,
  }) {
    final result = CannedReply._();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (body != null) result.body = body;
    if (category != null) result.category = category;
    return result;
  }

  CannedReply._();

  factory CannedReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CannedReply()..mergeFromBuffer(data, registry);
  factory CannedReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CannedReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CannedReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: CannedReply.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'body')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CannedReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CannedReply copyWith(void Function(CannedReply) updates) =>
      super.copyWith((message) => updates(message as CannedReply))
          as CannedReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CannedReply() / CannedReply.new instead')
  static CannedReply create() => CannedReply._();
  static $pb.GeneratedMessage $_createMessage() => CannedReply._();
  @$core.override
  CannedReply createEmptyInstance() => CannedReply._();
  @$core.pragma('dart2js:noInline')
  static CannedReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CannedReply>(
          CannedReply.$_createMessage);
  static CannedReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get body => $_getSZ(2);
  @$pb.TagNumber(3)
  set body($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBody() => $_has(2);
  @$pb.TagNumber(3)
  void clearBody() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);
}

class CannedRequest extends $pb.GeneratedMessage {
  factory CannedRequest({
    $core.String? category,
  }) {
    final result = CannedRequest._();
    if (category != null) result.category = category;
    return result;
  }

  CannedRequest._();

  factory CannedRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CannedRequest()..mergeFromBuffer(data, registry);
  factory CannedRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CannedRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CannedRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: CannedRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CannedRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CannedRequest copyWith(void Function(CannedRequest) updates) =>
      super.copyWith((message) => updates(message as CannedRequest))
          as CannedRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CannedRequest() / CannedRequest.new instead')
  static CannedRequest create() => CannedRequest._();
  static $pb.GeneratedMessage $_createMessage() => CannedRequest._();
  @$core.override
  CannedRequest createEmptyInstance() => CannedRequest._();
  @$core.pragma('dart2js:noInline')
  static CannedRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CannedRequest>(
          CannedRequest.$_createMessage);
  static CannedRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);
}

class Category extends $pb.GeneratedMessage {
  factory Category({
    $core.String? id,
    $core.String? name,
    $core.String? slug,
    $core.String? description,
    $core.String? defaultPriority,
    $core.int? firstResponseMinutes,
    $core.int? resolutionMinutes,
  }) {
    final result = Category._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (slug != null) result.slug = slug;
    if (description != null) result.description = description;
    if (defaultPriority != null) result.defaultPriority = defaultPriority;
    if (firstResponseMinutes != null)
      result.firstResponseMinutes = firstResponseMinutes;
    if (resolutionMinutes != null) result.resolutionMinutes = resolutionMinutes;
    return result;
  }

  Category._();

  factory Category.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Category()..mergeFromBuffer(data, registry);
  factory Category.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Category()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Category',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: Category.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'slug')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'defaultPriority')
    ..aI(6, _omitFieldNames ? '' : 'firstResponseMinutes')
    ..aI(7, _omitFieldNames ? '' : 'resolutionMinutes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Category clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Category copyWith(void Function(Category) updates) =>
      super.copyWith((message) => updates(message as Category)) as Category;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Category() / Category.new instead')
  static Category create() => Category._();
  static $pb.GeneratedMessage $_createMessage() => Category._();
  @$core.override
  Category createEmptyInstance() => Category._();
  @$core.pragma('dart2js:noInline')
  static Category getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Category>(Category.$_createMessage);
  static Category? _defaultInstance;

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
  $core.String get slug => $_getSZ(2);
  @$pb.TagNumber(3)
  set slug($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSlug() => $_has(2);
  @$pb.TagNumber(3)
  void clearSlug() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get defaultPriority => $_getSZ(4);
  @$pb.TagNumber(5)
  set defaultPriority($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDefaultPriority() => $_has(4);
  @$pb.TagNumber(5)
  void clearDefaultPriority() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get firstResponseMinutes => $_getIZ(5);
  @$pb.TagNumber(6)
  set firstResponseMinutes($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFirstResponseMinutes() => $_has(5);
  @$pb.TagNumber(6)
  void clearFirstResponseMinutes() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get resolutionMinutes => $_getIZ(6);
  @$pb.TagNumber(7)
  set resolutionMinutes($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasResolutionMinutes() => $_has(6);
  @$pb.TagNumber(7)
  void clearResolutionMinutes() => $_clearField(7);
}

class CategoryList extends $pb.GeneratedMessage {
  factory CategoryList({
    $core.Iterable<Category>? categories,
  }) {
    final result = CategoryList._();
    if (categories != null) result.categories.addAll(categories);
    return result;
  }

  CategoryList._();

  factory CategoryList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CategoryList()..mergeFromBuffer(data, registry);
  factory CategoryList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CategoryList()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CategoryList',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: CategoryList.$_createMessage)
    ..pPM<Category>(1, _omitFieldNames ? '' : 'categories',
        subBuilder: Category.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CategoryList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CategoryList copyWith(void Function(CategoryList) updates) =>
      super.copyWith((message) => updates(message as CategoryList))
          as CategoryList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CategoryList() / CategoryList.new instead')
  static CategoryList create() => CategoryList._();
  static $pb.GeneratedMessage $_createMessage() => CategoryList._();
  @$core.override
  CategoryList createEmptyInstance() => CategoryList._();
  @$core.pragma('dart2js:noInline')
  static CategoryList getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CategoryList>(
          CategoryList.$_createMessage);
  static CategoryList? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Category> get categories => $_getList(0);
}

class CategoryRef extends $pb.GeneratedMessage {
  factory CategoryRef({
    $core.String? id,
    $core.String? name,
    $core.String? slug,
  }) {
    final result = CategoryRef._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (slug != null) result.slug = slug;
    return result;
  }

  CategoryRef._();

  factory CategoryRef.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CategoryRef()..mergeFromBuffer(data, registry);
  factory CategoryRef.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CategoryRef()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CategoryRef',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: CategoryRef.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'slug')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CategoryRef clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CategoryRef copyWith(void Function(CategoryRef) updates) =>
      super.copyWith((message) => updates(message as CategoryRef))
          as CategoryRef;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CategoryRef() / CategoryRef.new instead')
  static CategoryRef create() => CategoryRef._();
  static $pb.GeneratedMessage $_createMessage() => CategoryRef._();
  @$core.override
  CategoryRef createEmptyInstance() => CategoryRef._();
  @$core.pragma('dart2js:noInline')
  static CategoryRef getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CategoryRef>(
          CategoryRef.$_createMessage);
  static CategoryRef? _defaultInstance;

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
  $core.String get slug => $_getSZ(2);
  @$pb.TagNumber(3)
  set slug($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSlug() => $_has(2);
  @$pb.TagNumber(3)
  void clearSlug() => $_clearField(3);
}

class CategoryRefResponse extends $pb.GeneratedMessage {
  factory CategoryRefResponse({
    $core.String? id,
    $core.String? name,
    $core.String? slug,
  }) {
    final result = CategoryRefResponse._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (slug != null) result.slug = slug;
    return result;
  }

  CategoryRefResponse._();

  factory CategoryRefResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CategoryRefResponse()..mergeFromBuffer(data, registry);
  factory CategoryRefResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CategoryRefResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CategoryRefResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: CategoryRefResponse.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'slug')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CategoryRefResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CategoryRefResponse copyWith(void Function(CategoryRefResponse) updates) =>
      super.copyWith((message) => updates(message as CategoryRefResponse))
          as CategoryRefResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use CategoryRefResponse() / CategoryRefResponse.new instead')
  static CategoryRefResponse create() => CategoryRefResponse._();
  static $pb.GeneratedMessage $_createMessage() => CategoryRefResponse._();
  @$core.override
  CategoryRefResponse createEmptyInstance() => CategoryRefResponse._();
  @$core.pragma('dart2js:noInline')
  static CategoryRefResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CategoryRefResponse>(
          CategoryRefResponse.$_createMessage);
  static CategoryRefResponse? _defaultInstance;

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
  $core.String get slug => $_getSZ(2);
  @$pb.TagNumber(3)
  set slug($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSlug() => $_has(2);
  @$pb.TagNumber(3)
  void clearSlug() => $_clearField(3);
}

class Channel extends $pb.GeneratedMessage {
  factory Channel({
    $core.String? id,
    $core.String? reference,
    $core.String? kind,
    $core.String? subject,
    $core.String? slug,
    $core.String? status,
    $core.String? priority,
    Account? client,
    Account? assignee,
    CategoryRef? category,
    $core.Iterable<$core.String>? tags,
    $core.String? dataJson,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? lastMessageAt,
    $core.String? resolvedAt,
    $core.String? closedAt,
    $core.int? rating,
    $core.String? ratingComment,
    Sla? sla,
    $core.int? unread,
    $core.Iterable<Participant>? participants,
    $core.bool? joined,
    $core.int? members,
  }) {
    final result = Channel._();
    if (id != null) result.id = id;
    if (reference != null) result.reference = reference;
    if (kind != null) result.kind = kind;
    if (subject != null) result.subject = subject;
    if (slug != null) result.slug = slug;
    if (status != null) result.status = status;
    if (priority != null) result.priority = priority;
    if (client != null) result.client = client;
    if (assignee != null) result.assignee = assignee;
    if (category != null) result.category = category;
    if (tags != null) result.tags.addAll(tags);
    if (dataJson != null) result.dataJson = dataJson;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (lastMessageAt != null) result.lastMessageAt = lastMessageAt;
    if (resolvedAt != null) result.resolvedAt = resolvedAt;
    if (closedAt != null) result.closedAt = closedAt;
    if (rating != null) result.rating = rating;
    if (ratingComment != null) result.ratingComment = ratingComment;
    if (sla != null) result.sla = sla;
    if (unread != null) result.unread = unread;
    if (participants != null) result.participants.addAll(participants);
    if (joined != null) result.joined = joined;
    if (members != null) result.members = members;
    return result;
  }

  Channel._();

  factory Channel.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Channel()..mergeFromBuffer(data, registry);
  factory Channel.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Channel()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Channel',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: Channel.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'reference')
    ..aOS(3, _omitFieldNames ? '' : 'kind')
    ..aOS(4, _omitFieldNames ? '' : 'subject')
    ..aOS(5, _omitFieldNames ? '' : 'slug')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOS(7, _omitFieldNames ? '' : 'priority')
    ..aOM<Account>(8, _omitFieldNames ? '' : 'client',
        subBuilder: Account.$_createMessage)
    ..aOM<Account>(9, _omitFieldNames ? '' : 'assignee',
        subBuilder: Account.$_createMessage)
    ..aOM<CategoryRef>(10, _omitFieldNames ? '' : 'category',
        subBuilder: CategoryRef.$_createMessage)
    ..pPS(11, _omitFieldNames ? '' : 'tags')
    ..aOS(12, _omitFieldNames ? '' : 'dataJson')
    ..aOS(13, _omitFieldNames ? '' : 'createdAt')
    ..aOS(14, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(15, _omitFieldNames ? '' : 'lastMessageAt')
    ..aOS(16, _omitFieldNames ? '' : 'resolvedAt')
    ..aOS(17, _omitFieldNames ? '' : 'closedAt')
    ..aI(18, _omitFieldNames ? '' : 'rating')
    ..aOS(19, _omitFieldNames ? '' : 'ratingComment')
    ..aOM<Sla>(20, _omitFieldNames ? '' : 'sla',
        subBuilder: Sla.$_createMessage)
    ..aI(21, _omitFieldNames ? '' : 'unread')
    ..pPM<Participant>(22, _omitFieldNames ? '' : 'participants',
        subBuilder: Participant.$_createMessage)
    ..aOB(23, _omitFieldNames ? '' : 'joined')
    ..aI(24, _omitFieldNames ? '' : 'members')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Channel clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Channel copyWith(void Function(Channel) updates) =>
      super.copyWith((message) => updates(message as Channel)) as Channel;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Channel() / Channel.new instead')
  static Channel create() => Channel._();
  static $pb.GeneratedMessage $_createMessage() => Channel._();
  @$core.override
  Channel createEmptyInstance() => Channel._();
  @$core.pragma('dart2js:noInline')
  static Channel getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Channel>(Channel.$_createMessage);
  static Channel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get kind => $_getSZ(2);
  @$pb.TagNumber(3)
  set kind($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasKind() => $_has(2);
  @$pb.TagNumber(3)
  void clearKind() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get subject => $_getSZ(3);
  @$pb.TagNumber(4)
  set subject($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSubject() => $_has(3);
  @$pb.TagNumber(4)
  void clearSubject() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get slug => $_getSZ(4);
  @$pb.TagNumber(5)
  set slug($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSlug() => $_has(4);
  @$pb.TagNumber(5)
  void clearSlug() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get priority => $_getSZ(6);
  @$pb.TagNumber(7)
  set priority($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPriority() => $_has(6);
  @$pb.TagNumber(7)
  void clearPriority() => $_clearField(7);

  @$pb.TagNumber(8)
  Account get client => $_getN(7);
  @$pb.TagNumber(8)
  set client(Account value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasClient() => $_has(7);
  @$pb.TagNumber(8)
  void clearClient() => $_clearField(8);
  @$pb.TagNumber(8)
  Account ensureClient() => $_ensure(7);

  @$pb.TagNumber(9)
  Account get assignee => $_getN(8);
  @$pb.TagNumber(9)
  set assignee(Account value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasAssignee() => $_has(8);
  @$pb.TagNumber(9)
  void clearAssignee() => $_clearField(9);
  @$pb.TagNumber(9)
  Account ensureAssignee() => $_ensure(8);

  @$pb.TagNumber(10)
  CategoryRef get category => $_getN(9);
  @$pb.TagNumber(10)
  set category(CategoryRef value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasCategory() => $_has(9);
  @$pb.TagNumber(10)
  void clearCategory() => $_clearField(10);
  @$pb.TagNumber(10)
  CategoryRef ensureCategory() => $_ensure(9);

  @$pb.TagNumber(11)
  $pb.PbList<$core.String> get tags => $_getList(10);

  @$pb.TagNumber(12)
  $core.String get dataJson => $_getSZ(11);
  @$pb.TagNumber(12)
  set dataJson($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasDataJson() => $_has(11);
  @$pb.TagNumber(12)
  void clearDataJson() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get createdAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set createdAt($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get updatedAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set updatedAt($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasUpdatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearUpdatedAt() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get lastMessageAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set lastMessageAt($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasLastMessageAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearLastMessageAt() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get resolvedAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set resolvedAt($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasResolvedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearResolvedAt() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get closedAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set closedAt($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasClosedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearClosedAt() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.int get rating => $_getIZ(17);
  @$pb.TagNumber(18)
  set rating($core.int value) => $_setSignedInt32(17, value);
  @$pb.TagNumber(18)
  $core.bool hasRating() => $_has(17);
  @$pb.TagNumber(18)
  void clearRating() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get ratingComment => $_getSZ(18);
  @$pb.TagNumber(19)
  set ratingComment($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasRatingComment() => $_has(18);
  @$pb.TagNumber(19)
  void clearRatingComment() => $_clearField(19);

  @$pb.TagNumber(20)
  Sla get sla => $_getN(19);
  @$pb.TagNumber(20)
  set sla(Sla value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasSla() => $_has(19);
  @$pb.TagNumber(20)
  void clearSla() => $_clearField(20);
  @$pb.TagNumber(20)
  Sla ensureSla() => $_ensure(19);

  @$pb.TagNumber(21)
  $core.int get unread => $_getIZ(20);
  @$pb.TagNumber(21)
  set unread($core.int value) => $_setSignedInt32(20, value);
  @$pb.TagNumber(21)
  $core.bool hasUnread() => $_has(20);
  @$pb.TagNumber(21)
  void clearUnread() => $_clearField(21);

  @$pb.TagNumber(22)
  $pb.PbList<Participant> get participants => $_getList(21);

  @$pb.TagNumber(23)
  $core.bool get joined => $_getBF(22);
  @$pb.TagNumber(23)
  set joined($core.bool value) => $_setBool(22, value);
  @$pb.TagNumber(23)
  $core.bool hasJoined() => $_has(22);
  @$pb.TagNumber(23)
  void clearJoined() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.int get members => $_getIZ(23);
  @$pb.TagNumber(24)
  set members($core.int value) => $_setSignedInt32(23, value);
  @$pb.TagNumber(24)
  $core.bool hasMembers() => $_has(23);
  @$pb.TagNumber(24)
  void clearMembers() => $_clearField(24);
}

class ChannelList extends $pb.GeneratedMessage {
  factory ChannelList({
    $core.Iterable<Channel>? channels,
  }) {
    final result = ChannelList._();
    if (channels != null) result.channels.addAll(channels);
    return result;
  }

  ChannelList._();

  factory ChannelList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChannelList()..mergeFromBuffer(data, registry);
  factory ChannelList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChannelList()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChannelList',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: ChannelList.$_createMessage)
    ..pPM<Channel>(1, _omitFieldNames ? '' : 'channels',
        subBuilder: Channel.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelList copyWith(void Function(ChannelList) updates) =>
      super.copyWith((message) => updates(message as ChannelList))
          as ChannelList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChannelList() / ChannelList.new instead')
  static ChannelList create() => ChannelList._();
  static $pb.GeneratedMessage $_createMessage() => ChannelList._();
  @$core.override
  ChannelList createEmptyInstance() => ChannelList._();
  @$core.pragma('dart2js:noInline')
  static ChannelList getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelList>(
          ChannelList.$_createMessage);
  static ChannelList? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Channel> get channels => $_getList(0);
}

class ChannelsRequest extends $pb.GeneratedMessage {
  factory ChannelsRequest({
    $core.String? search,
  }) {
    final result = ChannelsRequest._();
    if (search != null) result.search = search;
    return result;
  }

  ChannelsRequest._();

  factory ChannelsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChannelsRequest()..mergeFromBuffer(data, registry);
  factory ChannelsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChannelsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChannelsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: ChannelsRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'search')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelsRequest copyWith(void Function(ChannelsRequest) updates) =>
      super.copyWith((message) => updates(message as ChannelsRequest))
          as ChannelsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChannelsRequest() / ChannelsRequest.new instead')
  static ChannelsRequest create() => ChannelsRequest._();
  static $pb.GeneratedMessage $_createMessage() => ChannelsRequest._();
  @$core.override
  ChannelsRequest createEmptyInstance() => ChannelsRequest._();
  @$core.pragma('dart2js:noInline')
  static ChannelsRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelsRequest>(
          ChannelsRequest.$_createMessage);
  static ChannelsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get search => $_getSZ(0);
  @$pb.TagNumber(1)
  set search($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSearch() => $_has(0);
  @$pb.TagNumber(1)
  void clearSearch() => $_clearField(1);
}

class ClaimRequest extends $pb.GeneratedMessage {
  factory ClaimRequest({
    $core.String? ticketId,
  }) {
    final result = ClaimRequest._();
    if (ticketId != null) result.ticketId = ticketId;
    return result;
  }

  ClaimRequest._();

  factory ClaimRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ClaimRequest()..mergeFromBuffer(data, registry);
  factory ClaimRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ClaimRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClaimRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: ClaimRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClaimRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClaimRequest copyWith(void Function(ClaimRequest) updates) =>
      super.copyWith((message) => updates(message as ClaimRequest))
          as ClaimRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ClaimRequest() / ClaimRequest.new instead')
  static ClaimRequest create() => ClaimRequest._();
  static $pb.GeneratedMessage $_createMessage() => ClaimRequest._();
  @$core.override
  ClaimRequest createEmptyInstance() => ClaimRequest._();
  @$core.pragma('dart2js:noInline')
  static ClaimRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClaimRequest>(
          ClaimRequest.$_createMessage);
  static ClaimRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);
}

class ClaimResult extends $pb.GeneratedMessage {
  factory ClaimResult({
    $core.String? ticket,
    Account? assignee,
    $core.bool? changed,
  }) {
    final result = ClaimResult._();
    if (ticket != null) result.ticket = ticket;
    if (assignee != null) result.assignee = assignee;
    if (changed != null) result.changed = changed;
    return result;
  }

  ClaimResult._();

  factory ClaimResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ClaimResult()..mergeFromBuffer(data, registry);
  factory ClaimResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ClaimResult()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClaimResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: ClaimResult.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticket')
    ..aOM<Account>(2, _omitFieldNames ? '' : 'assignee',
        subBuilder: Account.$_createMessage)
    ..aOB(3, _omitFieldNames ? '' : 'changed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClaimResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClaimResult copyWith(void Function(ClaimResult) updates) =>
      super.copyWith((message) => updates(message as ClaimResult))
          as ClaimResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ClaimResult() / ClaimResult.new instead')
  static ClaimResult create() => ClaimResult._();
  static $pb.GeneratedMessage $_createMessage() => ClaimResult._();
  @$core.override
  ClaimResult createEmptyInstance() => ClaimResult._();
  @$core.pragma('dart2js:noInline')
  static ClaimResult getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClaimResult>(
          ClaimResult.$_createMessage);
  static ClaimResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticket => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticket($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicket() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicket() => $_clearField(1);

  @$pb.TagNumber(2)
  Account get assignee => $_getN(1);
  @$pb.TagNumber(2)
  set assignee(Account value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAssignee() => $_has(1);
  @$pb.TagNumber(2)
  void clearAssignee() => $_clearField(2);
  @$pb.TagNumber(2)
  Account ensureAssignee() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get changed => $_getBF(2);
  @$pb.TagNumber(3)
  set changed($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChanged() => $_has(2);
  @$pb.TagNumber(3)
  void clearChanged() => $_clearField(3);
}

class CountRequest extends $pb.GeneratedMessage {
  factory CountRequest({
    $core.String? status,
    $core.String? kind,
    $core.String? priority,
    $core.String? category,
    $core.String? assignee,
    $core.bool? mine,
    $core.bool? unassigned,
    $core.bool? live,
    $core.String? search,
  }) {
    final result = CountRequest._();
    if (status != null) result.status = status;
    if (kind != null) result.kind = kind;
    if (priority != null) result.priority = priority;
    if (category != null) result.category = category;
    if (assignee != null) result.assignee = assignee;
    if (mine != null) result.mine = mine;
    if (unassigned != null) result.unassigned = unassigned;
    if (live != null) result.live = live;
    if (search != null) result.search = search;
    return result;
  }

  CountRequest._();

  factory CountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CountRequest()..mergeFromBuffer(data, registry);
  factory CountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CountRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: CountRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOS(2, _omitFieldNames ? '' : 'kind')
    ..aOS(3, _omitFieldNames ? '' : 'priority')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..aOS(5, _omitFieldNames ? '' : 'assignee')
    ..aOB(6, _omitFieldNames ? '' : 'mine')
    ..aOB(7, _omitFieldNames ? '' : 'unassigned')
    ..aOB(8, _omitFieldNames ? '' : 'live')
    ..aOS(9, _omitFieldNames ? '' : 'search')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CountRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CountRequest copyWith(void Function(CountRequest) updates) =>
      super.copyWith((message) => updates(message as CountRequest))
          as CountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CountRequest() / CountRequest.new instead')
  static CountRequest create() => CountRequest._();
  static $pb.GeneratedMessage $_createMessage() => CountRequest._();
  @$core.override
  CountRequest createEmptyInstance() => CountRequest._();
  @$core.pragma('dart2js:noInline')
  static CountRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CountRequest>(
          CountRequest.$_createMessage);
  static CountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get kind => $_getSZ(1);
  @$pb.TagNumber(2)
  set kind($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get priority => $_getSZ(2);
  @$pb.TagNumber(3)
  set priority($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPriority() => $_has(2);
  @$pb.TagNumber(3)
  void clearPriority() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get assignee => $_getSZ(4);
  @$pb.TagNumber(5)
  set assignee($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAssignee() => $_has(4);
  @$pb.TagNumber(5)
  void clearAssignee() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get mine => $_getBF(5);
  @$pb.TagNumber(6)
  set mine($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMine() => $_has(5);
  @$pb.TagNumber(6)
  void clearMine() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get unassigned => $_getBF(6);
  @$pb.TagNumber(7)
  set unassigned($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUnassigned() => $_has(6);
  @$pb.TagNumber(7)
  void clearUnassigned() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get live => $_getBF(7);
  @$pb.TagNumber(8)
  set live($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasLive() => $_has(7);
  @$pb.TagNumber(8)
  void clearLive() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get search => $_getSZ(8);
  @$pb.TagNumber(9)
  set search($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSearch() => $_has(8);
  @$pb.TagNumber(9)
  void clearSearch() => $_clearField(9);
}

class CountResult extends $pb.GeneratedMessage {
  factory CountResult({
    $core.int? count,
  }) {
    final result = CountResult._();
    if (count != null) result.count = count;
    return result;
  }

  CountResult._();

  factory CountResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CountResult()..mergeFromBuffer(data, registry);
  factory CountResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CountResult()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CountResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: CountResult.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'count')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CountResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CountResult copyWith(void Function(CountResult) updates) =>
      super.copyWith((message) => updates(message as CountResult))
          as CountResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CountResult() / CountResult.new instead')
  static CountResult create() => CountResult._();
  static $pb.GeneratedMessage $_createMessage() => CountResult._();
  @$core.override
  CountResult createEmptyInstance() => CountResult._();
  @$core.pragma('dart2js:noInline')
  static CountResult getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CountResult>(
          CountResult.$_createMessage);
  static CountResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get count => $_getIZ(0);
  @$pb.TagNumber(1)
  set count($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearCount() => $_clearField(1);
}

class CreateChannelRequest extends $pb.GeneratedMessage {
  factory CreateChannelRequest({
    $core.String? name,
    $core.String? slug,
    $core.String? body,
  }) {
    final result = CreateChannelRequest._();
    if (name != null) result.name = name;
    if (slug != null) result.slug = slug;
    if (body != null) result.body = body;
    return result;
  }

  CreateChannelRequest._();

  factory CreateChannelRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateChannelRequest()..mergeFromBuffer(data, registry);
  factory CreateChannelRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateChannelRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateChannelRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: CreateChannelRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'slug')
    ..aOS(3, _omitFieldNames ? '' : 'body')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateChannelRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateChannelRequest copyWith(void Function(CreateChannelRequest) updates) =>
      super.copyWith((message) => updates(message as CreateChannelRequest))
          as CreateChannelRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CreateChannelRequest() / CreateChannelRequest.new instead')
  static CreateChannelRequest create() => CreateChannelRequest._();
  static $pb.GeneratedMessage $_createMessage() => CreateChannelRequest._();
  @$core.override
  CreateChannelRequest createEmptyInstance() => CreateChannelRequest._();
  @$core.pragma('dart2js:noInline')
  static CreateChannelRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateChannelRequest>(
          CreateChannelRequest.$_createMessage);
  static CreateChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get slug => $_getSZ(1);
  @$pb.TagNumber(2)
  set slug($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSlug() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlug() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get body => $_getSZ(2);
  @$pb.TagNumber(3)
  set body($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBody() => $_has(2);
  @$pb.TagNumber(3)
  void clearBody() => $_clearField(3);
}

class CreateGroupRequest extends $pb.GeneratedMessage {
  factory CreateGroupRequest({
    $core.String? name,
    $core.Iterable<$core.String>? members,
    $core.String? body,
  }) {
    final result = CreateGroupRequest._();
    if (name != null) result.name = name;
    if (members != null) result.members.addAll(members);
    if (body != null) result.body = body;
    return result;
  }

  CreateGroupRequest._();

  factory CreateGroupRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateGroupRequest()..mergeFromBuffer(data, registry);
  factory CreateGroupRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateGroupRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateGroupRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: CreateGroupRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pPS(2, _omitFieldNames ? '' : 'members')
    ..aOS(3, _omitFieldNames ? '' : 'body')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateGroupRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateGroupRequest copyWith(void Function(CreateGroupRequest) updates) =>
      super.copyWith((message) => updates(message as CreateGroupRequest))
          as CreateGroupRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CreateGroupRequest() / CreateGroupRequest.new instead')
  static CreateGroupRequest create() => CreateGroupRequest._();
  static $pb.GeneratedMessage $_createMessage() => CreateGroupRequest._();
  @$core.override
  CreateGroupRequest createEmptyInstance() => CreateGroupRequest._();
  @$core.pragma('dart2js:noInline')
  static CreateGroupRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateGroupRequest>(
          CreateGroupRequest.$_createMessage);
  static CreateGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get members => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get body => $_getSZ(2);
  @$pb.TagNumber(3)
  set body($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBody() => $_has(2);
  @$pb.TagNumber(3)
  void clearBody() => $_clearField(3);
}

class DeleteRequest extends $pb.GeneratedMessage {
  factory DeleteRequest({
    $core.String? messageId,
  }) {
    final result = DeleteRequest._();
    if (messageId != null) result.messageId = messageId;
    return result;
  }

  DeleteRequest._();

  factory DeleteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteRequest()..mergeFromBuffer(data, registry);
  factory DeleteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: DeleteRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'messageId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRequest copyWith(void Function(DeleteRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteRequest))
          as DeleteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DeleteRequest() / DeleteRequest.new instead')
  static DeleteRequest create() => DeleteRequest._();
  static $pb.GeneratedMessage $_createMessage() => DeleteRequest._();
  @$core.override
  DeleteRequest createEmptyInstance() => DeleteRequest._();
  @$core.pragma('dart2js:noInline')
  static DeleteRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteRequest>(
          DeleteRequest.$_createMessage);
  static DeleteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get messageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set messageId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessageId() => $_clearField(1);
}

class DeletedMessage extends $pb.GeneratedMessage {
  factory DeletedMessage({
    $core.String? id,
    $core.String? ticket,
    AccountResponse? author,
    $core.String? kind,
    $core.String? visibility,
    $core.String? body,
    $core.String? dataJson,
    $core.Iterable<AttachmentResponse>? attachments,
    $core.String? createdAt,
    $core.String? editedAt,
    $core.bool? deleted,
  }) {
    final result = DeletedMessage._();
    if (id != null) result.id = id;
    if (ticket != null) result.ticket = ticket;
    if (author != null) result.author = author;
    if (kind != null) result.kind = kind;
    if (visibility != null) result.visibility = visibility;
    if (body != null) result.body = body;
    if (dataJson != null) result.dataJson = dataJson;
    if (attachments != null) result.attachments.addAll(attachments);
    if (createdAt != null) result.createdAt = createdAt;
    if (editedAt != null) result.editedAt = editedAt;
    if (deleted != null) result.deleted = deleted;
    return result;
  }

  DeletedMessage._();

  factory DeletedMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeletedMessage()..mergeFromBuffer(data, registry);
  factory DeletedMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeletedMessage()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeletedMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: DeletedMessage.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'ticket')
    ..aOM<AccountResponse>(3, _omitFieldNames ? '' : 'author',
        subBuilder: AccountResponse.$_createMessage)
    ..aOS(4, _omitFieldNames ? '' : 'kind')
    ..aOS(5, _omitFieldNames ? '' : 'visibility')
    ..aOS(6, _omitFieldNames ? '' : 'body')
    ..aOS(7, _omitFieldNames ? '' : 'dataJson')
    ..pPM<AttachmentResponse>(8, _omitFieldNames ? '' : 'attachments',
        subBuilder: AttachmentResponse.$_createMessage)
    ..aOS(9, _omitFieldNames ? '' : 'createdAt')
    ..aOS(10, _omitFieldNames ? '' : 'editedAt')
    ..aOB(11, _omitFieldNames ? '' : 'deleted')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeletedMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeletedMessage copyWith(void Function(DeletedMessage) updates) =>
      super.copyWith((message) => updates(message as DeletedMessage))
          as DeletedMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DeletedMessage() / DeletedMessage.new instead')
  static DeletedMessage create() => DeletedMessage._();
  static $pb.GeneratedMessage $_createMessage() => DeletedMessage._();
  @$core.override
  DeletedMessage createEmptyInstance() => DeletedMessage._();
  @$core.pragma('dart2js:noInline')
  static DeletedMessage getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeletedMessage>(
          DeletedMessage.$_createMessage);
  static DeletedMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get ticket => $_getSZ(1);
  @$pb.TagNumber(2)
  set ticket($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTicket() => $_has(1);
  @$pb.TagNumber(2)
  void clearTicket() => $_clearField(2);

  @$pb.TagNumber(3)
  AccountResponse get author => $_getN(2);
  @$pb.TagNumber(3)
  set author(AccountResponse value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthor() => $_clearField(3);
  @$pb.TagNumber(3)
  AccountResponse ensureAuthor() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get kind => $_getSZ(3);
  @$pb.TagNumber(4)
  set kind($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasKind() => $_has(3);
  @$pb.TagNumber(4)
  void clearKind() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get visibility => $_getSZ(4);
  @$pb.TagNumber(5)
  set visibility($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVisibility() => $_has(4);
  @$pb.TagNumber(5)
  void clearVisibility() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get body => $_getSZ(5);
  @$pb.TagNumber(6)
  set body($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBody() => $_has(5);
  @$pb.TagNumber(6)
  void clearBody() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get dataJson => $_getSZ(6);
  @$pb.TagNumber(7)
  set dataJson($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDataJson() => $_has(6);
  @$pb.TagNumber(7)
  void clearDataJson() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<AttachmentResponse> get attachments => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get createdAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set createdAt($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get editedAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set editedAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasEditedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearEditedAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get deleted => $_getBF(10);
  @$pb.TagNumber(11)
  set deleted($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDeleted() => $_has(10);
  @$pb.TagNumber(11)
  void clearDeleted() => $_clearField(11);
}

class DirectRequest extends $pb.GeneratedMessage {
  factory DirectRequest({
    $core.String? account,
  }) {
    final result = DirectRequest._();
    if (account != null) result.account = account;
    return result;
  }

  DirectRequest._();

  factory DirectRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DirectRequest()..mergeFromBuffer(data, registry);
  factory DirectRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DirectRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DirectRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: DirectRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'account')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DirectRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DirectRequest copyWith(void Function(DirectRequest) updates) =>
      super.copyWith((message) => updates(message as DirectRequest))
          as DirectRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DirectRequest() / DirectRequest.new instead')
  static DirectRequest create() => DirectRequest._();
  static $pb.GeneratedMessage $_createMessage() => DirectRequest._();
  @$core.override
  DirectRequest createEmptyInstance() => DirectRequest._();
  @$core.pragma('dart2js:noInline')
  static DirectRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DirectRequest>(
          DirectRequest.$_createMessage);
  static DirectRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get account => $_getSZ(0);
  @$pb.TagNumber(1)
  set account($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => $_clearField(1);
}

class EditRequest extends $pb.GeneratedMessage {
  factory EditRequest({
    $core.String? messageId,
    $core.String? body,
  }) {
    final result = EditRequest._();
    if (messageId != null) result.messageId = messageId;
    if (body != null) result.body = body;
    return result;
  }

  EditRequest._();

  factory EditRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EditRequest()..mergeFromBuffer(data, registry);
  factory EditRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EditRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EditRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: EditRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'messageId')
    ..aOS(2, _omitFieldNames ? '' : 'body')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EditRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EditRequest copyWith(void Function(EditRequest) updates) =>
      super.copyWith((message) => updates(message as EditRequest))
          as EditRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use EditRequest() / EditRequest.new instead')
  static EditRequest create() => EditRequest._();
  static $pb.GeneratedMessage $_createMessage() => EditRequest._();
  @$core.override
  EditRequest createEmptyInstance() => EditRequest._();
  @$core.pragma('dart2js:noInline')
  static EditRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EditRequest>(
          EditRequest.$_createMessage);
  static EditRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get messageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set messageId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessageId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get body => $_getSZ(1);
  @$pb.TagNumber(2)
  set body($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBody() => $_has(1);
  @$pb.TagNumber(2)
  void clearBody() => $_clearField(2);
}

class EditedMessage extends $pb.GeneratedMessage {
  factory EditedMessage({
    $core.String? id,
    $core.String? ticket,
    AccountResponse? author,
    $core.String? kind,
    $core.String? visibility,
    $core.String? body,
    $core.String? dataJson,
    $core.Iterable<AttachmentResponse>? attachments,
    $core.String? createdAt,
    $core.String? editedAt,
    $core.bool? deleted,
  }) {
    final result = EditedMessage._();
    if (id != null) result.id = id;
    if (ticket != null) result.ticket = ticket;
    if (author != null) result.author = author;
    if (kind != null) result.kind = kind;
    if (visibility != null) result.visibility = visibility;
    if (body != null) result.body = body;
    if (dataJson != null) result.dataJson = dataJson;
    if (attachments != null) result.attachments.addAll(attachments);
    if (createdAt != null) result.createdAt = createdAt;
    if (editedAt != null) result.editedAt = editedAt;
    if (deleted != null) result.deleted = deleted;
    return result;
  }

  EditedMessage._();

  factory EditedMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EditedMessage()..mergeFromBuffer(data, registry);
  factory EditedMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EditedMessage()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EditedMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: EditedMessage.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'ticket')
    ..aOM<AccountResponse>(3, _omitFieldNames ? '' : 'author',
        subBuilder: AccountResponse.$_createMessage)
    ..aOS(4, _omitFieldNames ? '' : 'kind')
    ..aOS(5, _omitFieldNames ? '' : 'visibility')
    ..aOS(6, _omitFieldNames ? '' : 'body')
    ..aOS(7, _omitFieldNames ? '' : 'dataJson')
    ..pPM<AttachmentResponse>(8, _omitFieldNames ? '' : 'attachments',
        subBuilder: AttachmentResponse.$_createMessage)
    ..aOS(9, _omitFieldNames ? '' : 'createdAt')
    ..aOS(10, _omitFieldNames ? '' : 'editedAt')
    ..aOB(11, _omitFieldNames ? '' : 'deleted')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EditedMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EditedMessage copyWith(void Function(EditedMessage) updates) =>
      super.copyWith((message) => updates(message as EditedMessage))
          as EditedMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use EditedMessage() / EditedMessage.new instead')
  static EditedMessage create() => EditedMessage._();
  static $pb.GeneratedMessage $_createMessage() => EditedMessage._();
  @$core.override
  EditedMessage createEmptyInstance() => EditedMessage._();
  @$core.pragma('dart2js:noInline')
  static EditedMessage getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EditedMessage>(
          EditedMessage.$_createMessage);
  static EditedMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get ticket => $_getSZ(1);
  @$pb.TagNumber(2)
  set ticket($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTicket() => $_has(1);
  @$pb.TagNumber(2)
  void clearTicket() => $_clearField(2);

  @$pb.TagNumber(3)
  AccountResponse get author => $_getN(2);
  @$pb.TagNumber(3)
  set author(AccountResponse value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthor() => $_clearField(3);
  @$pb.TagNumber(3)
  AccountResponse ensureAuthor() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get kind => $_getSZ(3);
  @$pb.TagNumber(4)
  set kind($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasKind() => $_has(3);
  @$pb.TagNumber(4)
  void clearKind() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get visibility => $_getSZ(4);
  @$pb.TagNumber(5)
  set visibility($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVisibility() => $_has(4);
  @$pb.TagNumber(5)
  void clearVisibility() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get body => $_getSZ(5);
  @$pb.TagNumber(6)
  set body($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBody() => $_has(5);
  @$pb.TagNumber(6)
  void clearBody() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get dataJson => $_getSZ(6);
  @$pb.TagNumber(7)
  set dataJson($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDataJson() => $_has(6);
  @$pb.TagNumber(7)
  void clearDataJson() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<AttachmentResponse> get attachments => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get createdAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set createdAt($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get editedAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set editedAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasEditedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearEditedAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get deleted => $_getBF(10);
  @$pb.TagNumber(11)
  set deleted($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDeleted() => $_has(10);
  @$pb.TagNumber(11)
  void clearDeleted() => $_clearField(11);
}

class GetRequest extends $pb.GeneratedMessage {
  factory GetRequest({
    $core.String? ticketId,
  }) {
    final result = GetRequest._();
    if (ticketId != null) result.ticketId = ticketId;
    return result;
  }

  GetRequest._();

  factory GetRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetRequest()..mergeFromBuffer(data, registry);
  factory GetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: GetRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRequest copyWith(void Function(GetRequest) updates) =>
      super.copyWith((message) => updates(message as GetRequest)) as GetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetRequest() / GetRequest.new instead')
  static GetRequest create() => GetRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetRequest._();
  @$core.override
  GetRequest createEmptyInstance() => GetRequest._();
  @$core.pragma('dart2js:noInline')
  static GetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRequest>(GetRequest.$_createMessage);
  static GetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);
}

class InviteRequest extends $pb.GeneratedMessage {
  factory InviteRequest({
    $core.String? ticketId,
    $core.String? account,
    $core.String? role,
  }) {
    final result = InviteRequest._();
    if (ticketId != null) result.ticketId = ticketId;
    if (account != null) result.account = account;
    if (role != null) result.role = role;
    return result;
  }

  InviteRequest._();

  factory InviteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      InviteRequest()..mergeFromBuffer(data, registry);
  factory InviteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      InviteRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InviteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: InviteRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..aOS(2, _omitFieldNames ? '' : 'account')
    ..aOS(3, _omitFieldNames ? '' : 'role')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InviteRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InviteRequest copyWith(void Function(InviteRequest) updates) =>
      super.copyWith((message) => updates(message as InviteRequest))
          as InviteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use InviteRequest() / InviteRequest.new instead')
  static InviteRequest create() => InviteRequest._();
  static $pb.GeneratedMessage $_createMessage() => InviteRequest._();
  @$core.override
  InviteRequest createEmptyInstance() => InviteRequest._();
  @$core.pragma('dart2js:noInline')
  static InviteRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InviteRequest>(
          InviteRequest.$_createMessage);
  static InviteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get account => $_getSZ(1);
  @$pb.TagNumber(2)
  set account($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get role => $_getSZ(2);
  @$pb.TagNumber(3)
  set role($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => $_clearField(3);
}

class InvitedParticipant extends $pb.GeneratedMessage {
  factory InvitedParticipant({
    AccountResponse? user,
    $core.String? role,
    $core.String? joinedAt,
    $core.String? lastReadAt,
    $core.bool? notify,
  }) {
    final result = InvitedParticipant._();
    if (user != null) result.user = user;
    if (role != null) result.role = role;
    if (joinedAt != null) result.joinedAt = joinedAt;
    if (lastReadAt != null) result.lastReadAt = lastReadAt;
    if (notify != null) result.notify = notify;
    return result;
  }

  InvitedParticipant._();

  factory InvitedParticipant.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      InvitedParticipant()..mergeFromBuffer(data, registry);
  factory InvitedParticipant.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      InvitedParticipant()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InvitedParticipant',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: InvitedParticipant.$_createMessage)
    ..aOM<AccountResponse>(1, _omitFieldNames ? '' : 'user',
        subBuilder: AccountResponse.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'role')
    ..aOS(3, _omitFieldNames ? '' : 'joinedAt')
    ..aOS(4, _omitFieldNames ? '' : 'lastReadAt')
    ..aOB(5, _omitFieldNames ? '' : 'notify')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvitedParticipant clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvitedParticipant copyWith(void Function(InvitedParticipant) updates) =>
      super.copyWith((message) => updates(message as InvitedParticipant))
          as InvitedParticipant;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use InvitedParticipant() / InvitedParticipant.new instead')
  static InvitedParticipant create() => InvitedParticipant._();
  static $pb.GeneratedMessage $_createMessage() => InvitedParticipant._();
  @$core.override
  InvitedParticipant createEmptyInstance() => InvitedParticipant._();
  @$core.pragma('dart2js:noInline')
  static InvitedParticipant getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InvitedParticipant>(
          InvitedParticipant.$_createMessage);
  static InvitedParticipant? _defaultInstance;

  @$pb.TagNumber(1)
  AccountResponse get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(AccountResponse value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountResponse ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get role => $_getSZ(1);
  @$pb.TagNumber(2)
  set role($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearRole() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get joinedAt => $_getSZ(2);
  @$pb.TagNumber(3)
  set joinedAt($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasJoinedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearJoinedAt() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastReadAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastReadAt($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLastReadAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastReadAt() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get notify => $_getBF(4);
  @$pb.TagNumber(5)
  set notify($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNotify() => $_has(4);
  @$pb.TagNumber(5)
  void clearNotify() => $_clearField(5);
}

class JoinRequest extends $pb.GeneratedMessage {
  factory JoinRequest({
    $core.String? ticketId,
  }) {
    final result = JoinRequest._();
    if (ticketId != null) result.ticketId = ticketId;
    return result;
  }

  JoinRequest._();

  factory JoinRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      JoinRequest()..mergeFromBuffer(data, registry);
  factory JoinRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      JoinRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JoinRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: JoinRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinRequest copyWith(void Function(JoinRequest) updates) =>
      super.copyWith((message) => updates(message as JoinRequest))
          as JoinRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use JoinRequest() / JoinRequest.new instead')
  static JoinRequest create() => JoinRequest._();
  static $pb.GeneratedMessage $_createMessage() => JoinRequest._();
  @$core.override
  JoinRequest createEmptyInstance() => JoinRequest._();
  @$core.pragma('dart2js:noInline')
  static JoinRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JoinRequest>(
          JoinRequest.$_createMessage);
  static JoinRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);
}

class JoinedParticipant extends $pb.GeneratedMessage {
  factory JoinedParticipant({
    AccountResponse? user,
    $core.String? role,
    $core.String? joinedAt,
    $core.String? lastReadAt,
    $core.bool? notify,
  }) {
    final result = JoinedParticipant._();
    if (user != null) result.user = user;
    if (role != null) result.role = role;
    if (joinedAt != null) result.joinedAt = joinedAt;
    if (lastReadAt != null) result.lastReadAt = lastReadAt;
    if (notify != null) result.notify = notify;
    return result;
  }

  JoinedParticipant._();

  factory JoinedParticipant.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      JoinedParticipant()..mergeFromBuffer(data, registry);
  factory JoinedParticipant.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      JoinedParticipant()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JoinedParticipant',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: JoinedParticipant.$_createMessage)
    ..aOM<AccountResponse>(1, _omitFieldNames ? '' : 'user',
        subBuilder: AccountResponse.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'role')
    ..aOS(3, _omitFieldNames ? '' : 'joinedAt')
    ..aOS(4, _omitFieldNames ? '' : 'lastReadAt')
    ..aOB(5, _omitFieldNames ? '' : 'notify')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinedParticipant clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinedParticipant copyWith(void Function(JoinedParticipant) updates) =>
      super.copyWith((message) => updates(message as JoinedParticipant))
          as JoinedParticipant;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use JoinedParticipant() / JoinedParticipant.new instead')
  static JoinedParticipant create() => JoinedParticipant._();
  static $pb.GeneratedMessage $_createMessage() => JoinedParticipant._();
  @$core.override
  JoinedParticipant createEmptyInstance() => JoinedParticipant._();
  @$core.pragma('dart2js:noInline')
  static JoinedParticipant getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JoinedParticipant>(
          JoinedParticipant.$_createMessage);
  static JoinedParticipant? _defaultInstance;

  @$pb.TagNumber(1)
  AccountResponse get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(AccountResponse value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountResponse ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get role => $_getSZ(1);
  @$pb.TagNumber(2)
  set role($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearRole() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get joinedAt => $_getSZ(2);
  @$pb.TagNumber(3)
  set joinedAt($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasJoinedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearJoinedAt() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastReadAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastReadAt($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLastReadAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastReadAt() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get notify => $_getBF(4);
  @$pb.TagNumber(5)
  set notify($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNotify() => $_has(4);
  @$pb.TagNumber(5)
  void clearNotify() => $_clearField(5);
}

class LeaveRequest extends $pb.GeneratedMessage {
  factory LeaveRequest({
    $core.String? ticketId,
  }) {
    final result = LeaveRequest._();
    if (ticketId != null) result.ticketId = ticketId;
    return result;
  }

  LeaveRequest._();

  factory LeaveRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LeaveRequest()..mergeFromBuffer(data, registry);
  factory LeaveRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LeaveRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LeaveRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: LeaveRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveRequest copyWith(void Function(LeaveRequest) updates) =>
      super.copyWith((message) => updates(message as LeaveRequest))
          as LeaveRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use LeaveRequest() / LeaveRequest.new instead')
  static LeaveRequest create() => LeaveRequest._();
  static $pb.GeneratedMessage $_createMessage() => LeaveRequest._();
  @$core.override
  LeaveRequest createEmptyInstance() => LeaveRequest._();
  @$core.pragma('dart2js:noInline')
  static LeaveRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LeaveRequest>(
          LeaveRequest.$_createMessage);
  static LeaveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);
}

class LeaveResult extends $pb.GeneratedMessage {
  factory LeaveResult({
    $core.String? ticket,
    $core.bool? left,
  }) {
    final result = LeaveResult._();
    if (ticket != null) result.ticket = ticket;
    if (left != null) result.left = left;
    return result;
  }

  LeaveResult._();

  factory LeaveResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LeaveResult()..mergeFromBuffer(data, registry);
  factory LeaveResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LeaveResult()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LeaveResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: LeaveResult.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticket')
    ..aOB(2, _omitFieldNames ? '' : 'left')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveResult copyWith(void Function(LeaveResult) updates) =>
      super.copyWith((message) => updates(message as LeaveResult))
          as LeaveResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use LeaveResult() / LeaveResult.new instead')
  static LeaveResult create() => LeaveResult._();
  static $pb.GeneratedMessage $_createMessage() => LeaveResult._();
  @$core.override
  LeaveResult createEmptyInstance() => LeaveResult._();
  @$core.pragma('dart2js:noInline')
  static LeaveResult getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LeaveResult>(
          LeaveResult.$_createMessage);
  static LeaveResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticket => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticket($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicket() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicket() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get left => $_getBF(1);
  @$pb.TagNumber(2)
  set left($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLeft() => $_has(1);
  @$pb.TagNumber(2)
  void clearLeft() => $_clearField(2);
}

class ListRequest extends $pb.GeneratedMessage {
  factory ListRequest({
    $core.String? status,
    $core.String? kind,
    $core.String? priority,
    $core.String? category,
    $core.String? assignee,
    $core.bool? mine,
    $core.bool? unassigned,
    $core.bool? live,
    $core.String? search,
    $core.bool? breached,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = ListRequest._();
    if (status != null) result.status = status;
    if (kind != null) result.kind = kind;
    if (priority != null) result.priority = priority;
    if (category != null) result.category = category;
    if (assignee != null) result.assignee = assignee;
    if (mine != null) result.mine = mine;
    if (unassigned != null) result.unassigned = unassigned;
    if (live != null) result.live = live;
    if (search != null) result.search = search;
    if (breached != null) result.breached = breached;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  ListRequest._();

  factory ListRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListRequest()..mergeFromBuffer(data, registry);
  factory ListRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: ListRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOS(2, _omitFieldNames ? '' : 'kind')
    ..aOS(3, _omitFieldNames ? '' : 'priority')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..aOS(5, _omitFieldNames ? '' : 'assignee')
    ..aOB(6, _omitFieldNames ? '' : 'mine')
    ..aOB(7, _omitFieldNames ? '' : 'unassigned')
    ..aOB(8, _omitFieldNames ? '' : 'live')
    ..aOS(9, _omitFieldNames ? '' : 'search')
    ..aOB(10, _omitFieldNames ? '' : 'breached')
    ..aI(11, _omitFieldNames ? '' : 'limit')
    ..aI(12, _omitFieldNames ? '' : 'offset')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRequest copyWith(void Function(ListRequest) updates) =>
      super.copyWith((message) => updates(message as ListRequest))
          as ListRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ListRequest() / ListRequest.new instead')
  static ListRequest create() => ListRequest._();
  static $pb.GeneratedMessage $_createMessage() => ListRequest._();
  @$core.override
  ListRequest createEmptyInstance() => ListRequest._();
  @$core.pragma('dart2js:noInline')
  static ListRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListRequest>(
          ListRequest.$_createMessage);
  static ListRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get kind => $_getSZ(1);
  @$pb.TagNumber(2)
  set kind($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get priority => $_getSZ(2);
  @$pb.TagNumber(3)
  set priority($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPriority() => $_has(2);
  @$pb.TagNumber(3)
  void clearPriority() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get assignee => $_getSZ(4);
  @$pb.TagNumber(5)
  set assignee($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAssignee() => $_has(4);
  @$pb.TagNumber(5)
  void clearAssignee() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get mine => $_getBF(5);
  @$pb.TagNumber(6)
  set mine($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMine() => $_has(5);
  @$pb.TagNumber(6)
  void clearMine() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get unassigned => $_getBF(6);
  @$pb.TagNumber(7)
  set unassigned($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUnassigned() => $_has(6);
  @$pb.TagNumber(7)
  void clearUnassigned() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get live => $_getBF(7);
  @$pb.TagNumber(8)
  set live($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasLive() => $_has(7);
  @$pb.TagNumber(8)
  void clearLive() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get search => $_getSZ(8);
  @$pb.TagNumber(9)
  set search($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSearch() => $_has(8);
  @$pb.TagNumber(9)
  void clearSearch() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get breached => $_getBF(9);
  @$pb.TagNumber(10)
  set breached($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasBreached() => $_has(9);
  @$pb.TagNumber(10)
  void clearBreached() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get limit => $_getIZ(10);
  @$pb.TagNumber(11)
  set limit($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasLimit() => $_has(10);
  @$pb.TagNumber(11)
  void clearLimit() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get offset => $_getIZ(11);
  @$pb.TagNumber(12)
  set offset($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasOffset() => $_has(11);
  @$pb.TagNumber(12)
  void clearOffset() => $_clearField(12);
}

class Message extends $pb.GeneratedMessage {
  factory Message({
    $core.String? id,
    $core.String? ticket,
    Account? author,
    $core.String? kind,
    $core.String? visibility,
    $core.String? body,
    $core.String? dataJson,
    $core.Iterable<Attachment>? attachments,
    $core.String? createdAt,
    $core.String? editedAt,
    $core.bool? deleted,
  }) {
    final result = Message._();
    if (id != null) result.id = id;
    if (ticket != null) result.ticket = ticket;
    if (author != null) result.author = author;
    if (kind != null) result.kind = kind;
    if (visibility != null) result.visibility = visibility;
    if (body != null) result.body = body;
    if (dataJson != null) result.dataJson = dataJson;
    if (attachments != null) result.attachments.addAll(attachments);
    if (createdAt != null) result.createdAt = createdAt;
    if (editedAt != null) result.editedAt = editedAt;
    if (deleted != null) result.deleted = deleted;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: Message.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'ticket')
    ..aOM<Account>(3, _omitFieldNames ? '' : 'author',
        subBuilder: Account.$_createMessage)
    ..aOS(4, _omitFieldNames ? '' : 'kind')
    ..aOS(5, _omitFieldNames ? '' : 'visibility')
    ..aOS(6, _omitFieldNames ? '' : 'body')
    ..aOS(7, _omitFieldNames ? '' : 'dataJson')
    ..pPM<Attachment>(8, _omitFieldNames ? '' : 'attachments',
        subBuilder: Attachment.$_createMessage)
    ..aOS(9, _omitFieldNames ? '' : 'createdAt')
    ..aOS(10, _omitFieldNames ? '' : 'editedAt')
    ..aOB(11, _omitFieldNames ? '' : 'deleted')
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
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get ticket => $_getSZ(1);
  @$pb.TagNumber(2)
  set ticket($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTicket() => $_has(1);
  @$pb.TagNumber(2)
  void clearTicket() => $_clearField(2);

  @$pb.TagNumber(3)
  Account get author => $_getN(2);
  @$pb.TagNumber(3)
  set author(Account value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthor() => $_clearField(3);
  @$pb.TagNumber(3)
  Account ensureAuthor() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get kind => $_getSZ(3);
  @$pb.TagNumber(4)
  set kind($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasKind() => $_has(3);
  @$pb.TagNumber(4)
  void clearKind() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get visibility => $_getSZ(4);
  @$pb.TagNumber(5)
  set visibility($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVisibility() => $_has(4);
  @$pb.TagNumber(5)
  void clearVisibility() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get body => $_getSZ(5);
  @$pb.TagNumber(6)
  set body($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBody() => $_has(5);
  @$pb.TagNumber(6)
  void clearBody() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get dataJson => $_getSZ(6);
  @$pb.TagNumber(7)
  set dataJson($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDataJson() => $_has(6);
  @$pb.TagNumber(7)
  void clearDataJson() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<Attachment> get attachments => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get createdAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set createdAt($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get editedAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set editedAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasEditedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearEditedAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get deleted => $_getBF(10);
  @$pb.TagNumber(11)
  set deleted($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDeleted() => $_has(10);
  @$pb.TagNumber(11)
  void clearDeleted() => $_clearField(11);
}

class MessageList extends $pb.GeneratedMessage {
  factory MessageList({
    $core.String? ticket,
    $core.Iterable<Message>? messages,
    $core.int? total,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = MessageList._();
    if (ticket != null) result.ticket = ticket;
    if (messages != null) result.messages.addAll(messages);
    if (total != null) result.total = total;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  MessageList._();

  factory MessageList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessageList()..mergeFromBuffer(data, registry);
  factory MessageList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessageList()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MessageList',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: MessageList.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticket')
    ..pPM<Message>(2, _omitFieldNames ? '' : 'messages',
        subBuilder: Message.$_createMessage)
    ..aI(3, _omitFieldNames ? '' : 'total')
    ..aI(4, _omitFieldNames ? '' : 'limit')
    ..aI(5, _omitFieldNames ? '' : 'offset')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessageList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessageList copyWith(void Function(MessageList) updates) =>
      super.copyWith((message) => updates(message as MessageList))
          as MessageList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MessageList() / MessageList.new instead')
  static MessageList create() => MessageList._();
  static $pb.GeneratedMessage $_createMessage() => MessageList._();
  @$core.override
  MessageList createEmptyInstance() => MessageList._();
  @$core.pragma('dart2js:noInline')
  static MessageList getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MessageList>(
          MessageList.$_createMessage);
  static MessageList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticket => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticket($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicket() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicket() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<Message> get messages => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get total => $_getIZ(2);
  @$pb.TagNumber(3)
  set total($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotal() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotal() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get offset => $_getIZ(4);
  @$pb.TagNumber(5)
  set offset($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasOffset() => $_has(4);
  @$pb.TagNumber(5)
  void clearOffset() => $_clearField(5);
}

class MessagesRequest extends $pb.GeneratedMessage {
  factory MessagesRequest({
    $core.String? ticketId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = MessagesRequest._();
    if (ticketId != null) result.ticketId = ticketId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  MessagesRequest._();

  factory MessagesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessagesRequest()..mergeFromBuffer(data, registry);
  factory MessagesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessagesRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MessagesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: MessagesRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..aI(3, _omitFieldNames ? '' : 'offset')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessagesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessagesRequest copyWith(void Function(MessagesRequest) updates) =>
      super.copyWith((message) => updates(message as MessagesRequest))
          as MessagesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MessagesRequest() / MessagesRequest.new instead')
  static MessagesRequest create() => MessagesRequest._();
  static $pb.GeneratedMessage $_createMessage() => MessagesRequest._();
  @$core.override
  MessagesRequest createEmptyInstance() => MessagesRequest._();
  @$core.pragma('dart2js:noInline')
  static MessagesRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MessagesRequest>(
          MessagesRequest.$_createMessage);
  static MessagesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);
}

class OpenRequest extends $pb.GeneratedMessage {
  factory OpenRequest({
    $core.String? subject,
    $core.String? body,
    $core.String? kind,
    $core.String? category,
    $core.String? priority,
    $core.Iterable<$core.String>? uploadIds,
    $core.String? dataJson,
  }) {
    final result = OpenRequest._();
    if (subject != null) result.subject = subject;
    if (body != null) result.body = body;
    if (kind != null) result.kind = kind;
    if (category != null) result.category = category;
    if (priority != null) result.priority = priority;
    if (uploadIds != null) result.uploadIds.addAll(uploadIds);
    if (dataJson != null) result.dataJson = dataJson;
    return result;
  }

  OpenRequest._();

  factory OpenRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OpenRequest()..mergeFromBuffer(data, registry);
  factory OpenRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OpenRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: OpenRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'subject')
    ..aOS(2, _omitFieldNames ? '' : 'body')
    ..aOS(3, _omitFieldNames ? '' : 'kind')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..aOS(5, _omitFieldNames ? '' : 'priority')
    ..pPS(6, _omitFieldNames ? '' : 'uploadIds')
    ..aOS(7, _omitFieldNames ? '' : 'dataJson')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpenRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpenRequest copyWith(void Function(OpenRequest) updates) =>
      super.copyWith((message) => updates(message as OpenRequest))
          as OpenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use OpenRequest() / OpenRequest.new instead')
  static OpenRequest create() => OpenRequest._();
  static $pb.GeneratedMessage $_createMessage() => OpenRequest._();
  @$core.override
  OpenRequest createEmptyInstance() => OpenRequest._();
  @$core.pragma('dart2js:noInline')
  static OpenRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpenRequest>(
          OpenRequest.$_createMessage);
  static OpenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get subject => $_getSZ(0);
  @$pb.TagNumber(1)
  set subject($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSubject() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubject() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get body => $_getSZ(1);
  @$pb.TagNumber(2)
  set body($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBody() => $_has(1);
  @$pb.TagNumber(2)
  void clearBody() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get kind => $_getSZ(2);
  @$pb.TagNumber(3)
  set kind($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasKind() => $_has(2);
  @$pb.TagNumber(3)
  void clearKind() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get priority => $_getSZ(4);
  @$pb.TagNumber(5)
  set priority($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPriority() => $_has(4);
  @$pb.TagNumber(5)
  void clearPriority() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get uploadIds => $_getList(5);

  @$pb.TagNumber(7)
  $core.String get dataJson => $_getSZ(6);
  @$pb.TagNumber(7)
  set dataJson($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDataJson() => $_has(6);
  @$pb.TagNumber(7)
  void clearDataJson() => $_clearField(7);
}

class OpenedTicket extends $pb.GeneratedMessage {
  factory OpenedTicket({
    $core.String? id,
    $core.String? reference,
    $core.String? kind,
    $core.String? subject,
    $core.String? status,
    $core.String? priority,
    AccountResponse? client,
    AccountResponse? assignee,
    CategoryRefResponse? category,
    $core.Iterable<$core.String>? tags,
    $core.String? dataJson,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? lastMessageAt,
    $core.String? resolvedAt,
    $core.String? closedAt,
    $core.int? rating,
    $core.String? ratingComment,
    SlaResponse? sla,
    $core.int? unread,
    $core.Iterable<ParticipantResponse>? participants,
    $core.String? slug,
  }) {
    final result = OpenedTicket._();
    if (id != null) result.id = id;
    if (reference != null) result.reference = reference;
    if (kind != null) result.kind = kind;
    if (subject != null) result.subject = subject;
    if (status != null) result.status = status;
    if (priority != null) result.priority = priority;
    if (client != null) result.client = client;
    if (assignee != null) result.assignee = assignee;
    if (category != null) result.category = category;
    if (tags != null) result.tags.addAll(tags);
    if (dataJson != null) result.dataJson = dataJson;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (lastMessageAt != null) result.lastMessageAt = lastMessageAt;
    if (resolvedAt != null) result.resolvedAt = resolvedAt;
    if (closedAt != null) result.closedAt = closedAt;
    if (rating != null) result.rating = rating;
    if (ratingComment != null) result.ratingComment = ratingComment;
    if (sla != null) result.sla = sla;
    if (unread != null) result.unread = unread;
    if (participants != null) result.participants.addAll(participants);
    if (slug != null) result.slug = slug;
    return result;
  }

  OpenedTicket._();

  factory OpenedTicket.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OpenedTicket()..mergeFromBuffer(data, registry);
  factory OpenedTicket.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OpenedTicket()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpenedTicket',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: OpenedTicket.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'reference')
    ..aOS(3, _omitFieldNames ? '' : 'kind')
    ..aOS(4, _omitFieldNames ? '' : 'subject')
    ..aOS(5, _omitFieldNames ? '' : 'status')
    ..aOS(6, _omitFieldNames ? '' : 'priority')
    ..aOM<AccountResponse>(7, _omitFieldNames ? '' : 'client',
        subBuilder: AccountResponse.$_createMessage)
    ..aOM<AccountResponse>(8, _omitFieldNames ? '' : 'assignee',
        subBuilder: AccountResponse.$_createMessage)
    ..aOM<CategoryRefResponse>(9, _omitFieldNames ? '' : 'category',
        subBuilder: CategoryRefResponse.$_createMessage)
    ..pPS(10, _omitFieldNames ? '' : 'tags')
    ..aOS(11, _omitFieldNames ? '' : 'dataJson')
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..aOS(13, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(14, _omitFieldNames ? '' : 'lastMessageAt')
    ..aOS(15, _omitFieldNames ? '' : 'resolvedAt')
    ..aOS(16, _omitFieldNames ? '' : 'closedAt')
    ..aI(17, _omitFieldNames ? '' : 'rating')
    ..aOS(18, _omitFieldNames ? '' : 'ratingComment')
    ..aOM<SlaResponse>(19, _omitFieldNames ? '' : 'sla',
        subBuilder: SlaResponse.$_createMessage)
    ..aI(20, _omitFieldNames ? '' : 'unread')
    ..pPM<ParticipantResponse>(21, _omitFieldNames ? '' : 'participants',
        subBuilder: ParticipantResponse.$_createMessage)
    ..aOS(22, _omitFieldNames ? '' : 'slug')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpenedTicket clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpenedTicket copyWith(void Function(OpenedTicket) updates) =>
      super.copyWith((message) => updates(message as OpenedTicket))
          as OpenedTicket;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use OpenedTicket() / OpenedTicket.new instead')
  static OpenedTicket create() => OpenedTicket._();
  static $pb.GeneratedMessage $_createMessage() => OpenedTicket._();
  @$core.override
  OpenedTicket createEmptyInstance() => OpenedTicket._();
  @$core.pragma('dart2js:noInline')
  static OpenedTicket getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpenedTicket>(
          OpenedTicket.$_createMessage);
  static OpenedTicket? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get kind => $_getSZ(2);
  @$pb.TagNumber(3)
  set kind($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasKind() => $_has(2);
  @$pb.TagNumber(3)
  void clearKind() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get subject => $_getSZ(3);
  @$pb.TagNumber(4)
  set subject($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSubject() => $_has(3);
  @$pb.TagNumber(4)
  void clearSubject() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get status => $_getSZ(4);
  @$pb.TagNumber(5)
  set status($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get priority => $_getSZ(5);
  @$pb.TagNumber(6)
  set priority($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPriority() => $_has(5);
  @$pb.TagNumber(6)
  void clearPriority() => $_clearField(6);

  @$pb.TagNumber(7)
  AccountResponse get client => $_getN(6);
  @$pb.TagNumber(7)
  set client(AccountResponse value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasClient() => $_has(6);
  @$pb.TagNumber(7)
  void clearClient() => $_clearField(7);
  @$pb.TagNumber(7)
  AccountResponse ensureClient() => $_ensure(6);

  @$pb.TagNumber(8)
  AccountResponse get assignee => $_getN(7);
  @$pb.TagNumber(8)
  set assignee(AccountResponse value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasAssignee() => $_has(7);
  @$pb.TagNumber(8)
  void clearAssignee() => $_clearField(8);
  @$pb.TagNumber(8)
  AccountResponse ensureAssignee() => $_ensure(7);

  @$pb.TagNumber(9)
  CategoryRefResponse get category => $_getN(8);
  @$pb.TagNumber(9)
  set category(CategoryRefResponse value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasCategory() => $_has(8);
  @$pb.TagNumber(9)
  void clearCategory() => $_clearField(9);
  @$pb.TagNumber(9)
  CategoryRefResponse ensureCategory() => $_ensure(8);

  @$pb.TagNumber(10)
  $pb.PbList<$core.String> get tags => $_getList(9);

  @$pb.TagNumber(11)
  $core.String get dataJson => $_getSZ(10);
  @$pb.TagNumber(11)
  set dataJson($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDataJson() => $_has(10);
  @$pb.TagNumber(11)
  void clearDataJson() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get updatedAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set updatedAt($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get lastMessageAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set lastMessageAt($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasLastMessageAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearLastMessageAt() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get resolvedAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set resolvedAt($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasResolvedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearResolvedAt() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get closedAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set closedAt($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasClosedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearClosedAt() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.int get rating => $_getIZ(16);
  @$pb.TagNumber(17)
  set rating($core.int value) => $_setSignedInt32(16, value);
  @$pb.TagNumber(17)
  $core.bool hasRating() => $_has(16);
  @$pb.TagNumber(17)
  void clearRating() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get ratingComment => $_getSZ(17);
  @$pb.TagNumber(18)
  set ratingComment($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasRatingComment() => $_has(17);
  @$pb.TagNumber(18)
  void clearRatingComment() => $_clearField(18);

  @$pb.TagNumber(19)
  SlaResponse get sla => $_getN(18);
  @$pb.TagNumber(19)
  set sla(SlaResponse value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasSla() => $_has(18);
  @$pb.TagNumber(19)
  void clearSla() => $_clearField(19);
  @$pb.TagNumber(19)
  SlaResponse ensureSla() => $_ensure(18);

  @$pb.TagNumber(20)
  $core.int get unread => $_getIZ(19);
  @$pb.TagNumber(20)
  set unread($core.int value) => $_setSignedInt32(19, value);
  @$pb.TagNumber(20)
  $core.bool hasUnread() => $_has(19);
  @$pb.TagNumber(20)
  void clearUnread() => $_clearField(20);

  @$pb.TagNumber(21)
  $pb.PbList<ParticipantResponse> get participants => $_getList(20);

  @$pb.TagNumber(22)
  $core.String get slug => $_getSZ(21);
  @$pb.TagNumber(22)
  set slug($core.String value) => $_setString(21, value);
  @$pb.TagNumber(22)
  $core.bool hasSlug() => $_has(21);
  @$pb.TagNumber(22)
  void clearSlug() => $_clearField(22);
}

class Participant extends $pb.GeneratedMessage {
  factory Participant({
    Account? user,
    $core.String? role,
    $core.String? joinedAt,
    $core.String? lastReadAt,
    $core.bool? notify,
  }) {
    final result = Participant._();
    if (user != null) result.user = user;
    if (role != null) result.role = role;
    if (joinedAt != null) result.joinedAt = joinedAt;
    if (lastReadAt != null) result.lastReadAt = lastReadAt;
    if (notify != null) result.notify = notify;
    return result;
  }

  Participant._();

  factory Participant.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Participant()..mergeFromBuffer(data, registry);
  factory Participant.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Participant()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Participant',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: Participant.$_createMessage)
    ..aOM<Account>(1, _omitFieldNames ? '' : 'user',
        subBuilder: Account.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'role')
    ..aOS(3, _omitFieldNames ? '' : 'joinedAt')
    ..aOS(4, _omitFieldNames ? '' : 'lastReadAt')
    ..aOB(5, _omitFieldNames ? '' : 'notify')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Participant clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Participant copyWith(void Function(Participant) updates) =>
      super.copyWith((message) => updates(message as Participant))
          as Participant;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Participant() / Participant.new instead')
  static Participant create() => Participant._();
  static $pb.GeneratedMessage $_createMessage() => Participant._();
  @$core.override
  Participant createEmptyInstance() => Participant._();
  @$core.pragma('dart2js:noInline')
  static Participant getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Participant>(
          Participant.$_createMessage);
  static Participant? _defaultInstance;

  @$pb.TagNumber(1)
  Account get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(Account value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  Account ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get role => $_getSZ(1);
  @$pb.TagNumber(2)
  set role($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearRole() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get joinedAt => $_getSZ(2);
  @$pb.TagNumber(3)
  set joinedAt($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasJoinedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearJoinedAt() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastReadAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastReadAt($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLastReadAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastReadAt() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get notify => $_getBF(4);
  @$pb.TagNumber(5)
  set notify($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNotify() => $_has(4);
  @$pb.TagNumber(5)
  void clearNotify() => $_clearField(5);
}

class ParticipantResponse extends $pb.GeneratedMessage {
  factory ParticipantResponse({
    AccountResponse? user,
    $core.String? role,
    $core.String? joinedAt,
    $core.String? lastReadAt,
    $core.bool? notify,
  }) {
    final result = ParticipantResponse._();
    if (user != null) result.user = user;
    if (role != null) result.role = role;
    if (joinedAt != null) result.joinedAt = joinedAt;
    if (lastReadAt != null) result.lastReadAt = lastReadAt;
    if (notify != null) result.notify = notify;
    return result;
  }

  ParticipantResponse._();

  factory ParticipantResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ParticipantResponse()..mergeFromBuffer(data, registry);
  factory ParticipantResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ParticipantResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ParticipantResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: ParticipantResponse.$_createMessage)
    ..aOM<AccountResponse>(1, _omitFieldNames ? '' : 'user',
        subBuilder: AccountResponse.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'role')
    ..aOS(3, _omitFieldNames ? '' : 'joinedAt')
    ..aOS(4, _omitFieldNames ? '' : 'lastReadAt')
    ..aOB(5, _omitFieldNames ? '' : 'notify')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ParticipantResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ParticipantResponse copyWith(void Function(ParticipantResponse) updates) =>
      super.copyWith((message) => updates(message as ParticipantResponse))
          as ParticipantResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use ParticipantResponse() / ParticipantResponse.new instead')
  static ParticipantResponse create() => ParticipantResponse._();
  static $pb.GeneratedMessage $_createMessage() => ParticipantResponse._();
  @$core.override
  ParticipantResponse createEmptyInstance() => ParticipantResponse._();
  @$core.pragma('dart2js:noInline')
  static ParticipantResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ParticipantResponse>(
          ParticipantResponse.$_createMessage);
  static ParticipantResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountResponse get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(AccountResponse value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountResponse ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get role => $_getSZ(1);
  @$pb.TagNumber(2)
  set role($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearRole() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get joinedAt => $_getSZ(2);
  @$pb.TagNumber(3)
  set joinedAt($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasJoinedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearJoinedAt() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastReadAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastReadAt($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLastReadAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastReadAt() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get notify => $_getBF(4);
  @$pb.TagNumber(5)
  set notify($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNotify() => $_has(4);
  @$pb.TagNumber(5)
  void clearNotify() => $_clearField(5);
}

class PriorityRequest extends $pb.GeneratedMessage {
  factory PriorityRequest({
    $core.String? ticketId,
    $core.String? priority,
  }) {
    final result = PriorityRequest._();
    if (ticketId != null) result.ticketId = ticketId;
    if (priority != null) result.priority = priority;
    return result;
  }

  PriorityRequest._();

  factory PriorityRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PriorityRequest()..mergeFromBuffer(data, registry);
  factory PriorityRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PriorityRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PriorityRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: PriorityRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..aOS(2, _omitFieldNames ? '' : 'priority')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PriorityRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PriorityRequest copyWith(void Function(PriorityRequest) updates) =>
      super.copyWith((message) => updates(message as PriorityRequest))
          as PriorityRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PriorityRequest() / PriorityRequest.new instead')
  static PriorityRequest create() => PriorityRequest._();
  static $pb.GeneratedMessage $_createMessage() => PriorityRequest._();
  @$core.override
  PriorityRequest createEmptyInstance() => PriorityRequest._();
  @$core.pragma('dart2js:noInline')
  static PriorityRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PriorityRequest>(
          PriorityRequest.$_createMessage);
  static PriorityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get priority => $_getSZ(1);
  @$pb.TagNumber(2)
  set priority($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPriority() => $_has(1);
  @$pb.TagNumber(2)
  void clearPriority() => $_clearField(2);
}

class PriorityResult extends $pb.GeneratedMessage {
  factory PriorityResult({
    $core.String? ticket,
    $core.String? priority,
    $core.bool? changed,
  }) {
    final result = PriorityResult._();
    if (ticket != null) result.ticket = ticket;
    if (priority != null) result.priority = priority;
    if (changed != null) result.changed = changed;
    return result;
  }

  PriorityResult._();

  factory PriorityResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PriorityResult()..mergeFromBuffer(data, registry);
  factory PriorityResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PriorityResult()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PriorityResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: PriorityResult.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticket')
    ..aOS(2, _omitFieldNames ? '' : 'priority')
    ..aOB(3, _omitFieldNames ? '' : 'changed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PriorityResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PriorityResult copyWith(void Function(PriorityResult) updates) =>
      super.copyWith((message) => updates(message as PriorityResult))
          as PriorityResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PriorityResult() / PriorityResult.new instead')
  static PriorityResult create() => PriorityResult._();
  static $pb.GeneratedMessage $_createMessage() => PriorityResult._();
  @$core.override
  PriorityResult createEmptyInstance() => PriorityResult._();
  @$core.pragma('dart2js:noInline')
  static PriorityResult getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PriorityResult>(
          PriorityResult.$_createMessage);
  static PriorityResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticket => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticket($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicket() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicket() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get priority => $_getSZ(1);
  @$pb.TagNumber(2)
  set priority($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPriority() => $_has(1);
  @$pb.TagNumber(2)
  void clearPriority() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get changed => $_getBF(2);
  @$pb.TagNumber(3)
  set changed($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChanged() => $_has(2);
  @$pb.TagNumber(3)
  void clearChanged() => $_clearField(3);
}

class RateRequest extends $pb.GeneratedMessage {
  factory RateRequest({
    $core.String? ticketId,
    $core.int? score,
    $core.String? comment,
  }) {
    final result = RateRequest._();
    if (ticketId != null) result.ticketId = ticketId;
    if (score != null) result.score = score;
    if (comment != null) result.comment = comment;
    return result;
  }

  RateRequest._();

  factory RateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RateRequest()..mergeFromBuffer(data, registry);
  factory RateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RateRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: RateRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..aI(2, _omitFieldNames ? '' : 'score')
    ..aOS(3, _omitFieldNames ? '' : 'comment')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RateRequest copyWith(void Function(RateRequest) updates) =>
      super.copyWith((message) => updates(message as RateRequest))
          as RateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RateRequest() / RateRequest.new instead')
  static RateRequest create() => RateRequest._();
  static $pb.GeneratedMessage $_createMessage() => RateRequest._();
  @$core.override
  RateRequest createEmptyInstance() => RateRequest._();
  @$core.pragma('dart2js:noInline')
  static RateRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RateRequest>(
          RateRequest.$_createMessage);
  static RateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get score => $_getIZ(1);
  @$pb.TagNumber(2)
  set score($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearScore() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get comment => $_getSZ(2);
  @$pb.TagNumber(3)
  set comment($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasComment() => $_has(2);
  @$pb.TagNumber(3)
  void clearComment() => $_clearField(3);
}

class RateResult extends $pb.GeneratedMessage {
  factory RateResult({
    $core.String? ticket,
    $core.int? rating,
    $core.String? comment,
  }) {
    final result = RateResult._();
    if (ticket != null) result.ticket = ticket;
    if (rating != null) result.rating = rating;
    if (comment != null) result.comment = comment;
    return result;
  }

  RateResult._();

  factory RateResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RateResult()..mergeFromBuffer(data, registry);
  factory RateResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RateResult()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RateResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: RateResult.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticket')
    ..aI(2, _omitFieldNames ? '' : 'rating')
    ..aOS(3, _omitFieldNames ? '' : 'comment')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RateResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RateResult copyWith(void Function(RateResult) updates) =>
      super.copyWith((message) => updates(message as RateResult)) as RateResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RateResult() / RateResult.new instead')
  static RateResult create() => RateResult._();
  static $pb.GeneratedMessage $_createMessage() => RateResult._();
  @$core.override
  RateResult createEmptyInstance() => RateResult._();
  @$core.pragma('dart2js:noInline')
  static RateResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RateResult>(RateResult.$_createMessage);
  static RateResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticket => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticket($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicket() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicket() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get rating => $_getIZ(1);
  @$pb.TagNumber(2)
  set rating($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRating() => $_has(1);
  @$pb.TagNumber(2)
  void clearRating() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get comment => $_getSZ(2);
  @$pb.TagNumber(3)
  set comment($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasComment() => $_has(2);
  @$pb.TagNumber(3)
  void clearComment() => $_clearField(3);
}

class ReadRequest extends $pb.GeneratedMessage {
  factory ReadRequest({
    $core.String? ticketId,
  }) {
    final result = ReadRequest._();
    if (ticketId != null) result.ticketId = ticketId;
    return result;
  }

  ReadRequest._();

  factory ReadRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReadRequest()..mergeFromBuffer(data, registry);
  factory ReadRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReadRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReadRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: ReadRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadRequest copyWith(void Function(ReadRequest) updates) =>
      super.copyWith((message) => updates(message as ReadRequest))
          as ReadRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ReadRequest() / ReadRequest.new instead')
  static ReadRequest create() => ReadRequest._();
  static $pb.GeneratedMessage $_createMessage() => ReadRequest._();
  @$core.override
  ReadRequest createEmptyInstance() => ReadRequest._();
  @$core.pragma('dart2js:noInline')
  static ReadRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReadRequest>(
          ReadRequest.$_createMessage);
  static ReadRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);
}

class ReadResult extends $pb.GeneratedMessage {
  factory ReadResult({
    $core.String? ticket,
    $core.bool? changed,
    $core.int? unread,
    $core.String? lastReadAt,
  }) {
    final result = ReadResult._();
    if (ticket != null) result.ticket = ticket;
    if (changed != null) result.changed = changed;
    if (unread != null) result.unread = unread;
    if (lastReadAt != null) result.lastReadAt = lastReadAt;
    return result;
  }

  ReadResult._();

  factory ReadResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReadResult()..mergeFromBuffer(data, registry);
  factory ReadResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReadResult()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReadResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: ReadResult.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticket')
    ..aOB(2, _omitFieldNames ? '' : 'changed')
    ..aI(3, _omitFieldNames ? '' : 'unread')
    ..aOS(4, _omitFieldNames ? '' : 'lastReadAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadResult copyWith(void Function(ReadResult) updates) =>
      super.copyWith((message) => updates(message as ReadResult)) as ReadResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ReadResult() / ReadResult.new instead')
  static ReadResult create() => ReadResult._();
  static $pb.GeneratedMessage $_createMessage() => ReadResult._();
  @$core.override
  ReadResult createEmptyInstance() => ReadResult._();
  @$core.pragma('dart2js:noInline')
  static ReadResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReadResult>(ReadResult.$_createMessage);
  static ReadResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticket => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticket($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicket() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicket() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get changed => $_getBF(1);
  @$pb.TagNumber(2)
  set changed($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChanged() => $_has(1);
  @$pb.TagNumber(2)
  void clearChanged() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get unread => $_getIZ(2);
  @$pb.TagNumber(3)
  set unread($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUnread() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnread() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastReadAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastReadAt($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLastReadAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastReadAt() => $_clearField(4);
}

class SendRequest extends $pb.GeneratedMessage {
  factory SendRequest({
    $core.String? ticketId,
    $core.String? body,
    $core.Iterable<$core.String>? uploadIds,
    $core.bool? internal,
    $core.String? dataJson,
  }) {
    final result = SendRequest._();
    if (ticketId != null) result.ticketId = ticketId;
    if (body != null) result.body = body;
    if (uploadIds != null) result.uploadIds.addAll(uploadIds);
    if (internal != null) result.internal = internal;
    if (dataJson != null) result.dataJson = dataJson;
    return result;
  }

  SendRequest._();

  factory SendRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SendRequest()..mergeFromBuffer(data, registry);
  factory SendRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SendRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: SendRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..aOS(2, _omitFieldNames ? '' : 'body')
    ..pPS(3, _omitFieldNames ? '' : 'uploadIds')
    ..aOB(4, _omitFieldNames ? '' : 'internal')
    ..aOS(5, _omitFieldNames ? '' : 'dataJson')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendRequest copyWith(void Function(SendRequest) updates) =>
      super.copyWith((message) => updates(message as SendRequest))
          as SendRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SendRequest() / SendRequest.new instead')
  static SendRequest create() => SendRequest._();
  static $pb.GeneratedMessage $_createMessage() => SendRequest._();
  @$core.override
  SendRequest createEmptyInstance() => SendRequest._();
  @$core.pragma('dart2js:noInline')
  static SendRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendRequest>(
          SendRequest.$_createMessage);
  static SendRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get body => $_getSZ(1);
  @$pb.TagNumber(2)
  set body($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBody() => $_has(1);
  @$pb.TagNumber(2)
  void clearBody() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get uploadIds => $_getList(2);

  @$pb.TagNumber(4)
  $core.bool get internal => $_getBF(3);
  @$pb.TagNumber(4)
  set internal($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInternal() => $_has(3);
  @$pb.TagNumber(4)
  void clearInternal() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get dataJson => $_getSZ(4);
  @$pb.TagNumber(5)
  set dataJson($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDataJson() => $_has(4);
  @$pb.TagNumber(5)
  void clearDataJson() => $_clearField(5);
}

class SentMessage extends $pb.GeneratedMessage {
  factory SentMessage({
    $core.String? id,
    $core.String? ticket,
    AccountResponse? author,
    $core.String? kind,
    $core.String? visibility,
    $core.String? body,
    $core.String? dataJson,
    $core.Iterable<AttachmentResponse>? attachments,
    $core.String? createdAt,
    $core.String? editedAt,
    $core.bool? deleted,
  }) {
    final result = SentMessage._();
    if (id != null) result.id = id;
    if (ticket != null) result.ticket = ticket;
    if (author != null) result.author = author;
    if (kind != null) result.kind = kind;
    if (visibility != null) result.visibility = visibility;
    if (body != null) result.body = body;
    if (dataJson != null) result.dataJson = dataJson;
    if (attachments != null) result.attachments.addAll(attachments);
    if (createdAt != null) result.createdAt = createdAt;
    if (editedAt != null) result.editedAt = editedAt;
    if (deleted != null) result.deleted = deleted;
    return result;
  }

  SentMessage._();

  factory SentMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SentMessage()..mergeFromBuffer(data, registry);
  factory SentMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SentMessage()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SentMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: SentMessage.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'ticket')
    ..aOM<AccountResponse>(3, _omitFieldNames ? '' : 'author',
        subBuilder: AccountResponse.$_createMessage)
    ..aOS(4, _omitFieldNames ? '' : 'kind')
    ..aOS(5, _omitFieldNames ? '' : 'visibility')
    ..aOS(6, _omitFieldNames ? '' : 'body')
    ..aOS(7, _omitFieldNames ? '' : 'dataJson')
    ..pPM<AttachmentResponse>(8, _omitFieldNames ? '' : 'attachments',
        subBuilder: AttachmentResponse.$_createMessage)
    ..aOS(9, _omitFieldNames ? '' : 'createdAt')
    ..aOS(10, _omitFieldNames ? '' : 'editedAt')
    ..aOB(11, _omitFieldNames ? '' : 'deleted')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SentMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SentMessage copyWith(void Function(SentMessage) updates) =>
      super.copyWith((message) => updates(message as SentMessage))
          as SentMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SentMessage() / SentMessage.new instead')
  static SentMessage create() => SentMessage._();
  static $pb.GeneratedMessage $_createMessage() => SentMessage._();
  @$core.override
  SentMessage createEmptyInstance() => SentMessage._();
  @$core.pragma('dart2js:noInline')
  static SentMessage getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SentMessage>(
          SentMessage.$_createMessage);
  static SentMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get ticket => $_getSZ(1);
  @$pb.TagNumber(2)
  set ticket($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTicket() => $_has(1);
  @$pb.TagNumber(2)
  void clearTicket() => $_clearField(2);

  @$pb.TagNumber(3)
  AccountResponse get author => $_getN(2);
  @$pb.TagNumber(3)
  set author(AccountResponse value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthor() => $_clearField(3);
  @$pb.TagNumber(3)
  AccountResponse ensureAuthor() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get kind => $_getSZ(3);
  @$pb.TagNumber(4)
  set kind($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasKind() => $_has(3);
  @$pb.TagNumber(4)
  void clearKind() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get visibility => $_getSZ(4);
  @$pb.TagNumber(5)
  set visibility($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVisibility() => $_has(4);
  @$pb.TagNumber(5)
  void clearVisibility() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get body => $_getSZ(5);
  @$pb.TagNumber(6)
  set body($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBody() => $_has(5);
  @$pb.TagNumber(6)
  void clearBody() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get dataJson => $_getSZ(6);
  @$pb.TagNumber(7)
  set dataJson($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDataJson() => $_has(6);
  @$pb.TagNumber(7)
  void clearDataJson() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<AttachmentResponse> get attachments => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get createdAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set createdAt($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get editedAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set editedAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasEditedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearEditedAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get deleted => $_getBF(10);
  @$pb.TagNumber(11)
  set deleted($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDeleted() => $_has(10);
  @$pb.TagNumber(11)
  void clearDeleted() => $_clearField(11);
}

class Sla extends $pb.GeneratedMessage {
  factory Sla({
    $core.String? firstResponseDueAt,
    $core.String? resolutionDueAt,
    $core.String? firstResponseAt,
    $core.bool? firstResponseBreached,
    $core.bool? resolutionBreached,
    $core.bool? breached,
  }) {
    final result = Sla._();
    if (firstResponseDueAt != null)
      result.firstResponseDueAt = firstResponseDueAt;
    if (resolutionDueAt != null) result.resolutionDueAt = resolutionDueAt;
    if (firstResponseAt != null) result.firstResponseAt = firstResponseAt;
    if (firstResponseBreached != null)
      result.firstResponseBreached = firstResponseBreached;
    if (resolutionBreached != null)
      result.resolutionBreached = resolutionBreached;
    if (breached != null) result.breached = breached;
    return result;
  }

  Sla._();

  factory Sla.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Sla()..mergeFromBuffer(data, registry);
  factory Sla.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Sla()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Sla',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: Sla.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'firstResponseDueAt')
    ..aOS(2, _omitFieldNames ? '' : 'resolutionDueAt')
    ..aOS(3, _omitFieldNames ? '' : 'firstResponseAt')
    ..aOB(4, _omitFieldNames ? '' : 'firstResponseBreached')
    ..aOB(5, _omitFieldNames ? '' : 'resolutionBreached')
    ..aOB(6, _omitFieldNames ? '' : 'breached')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Sla clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Sla copyWith(void Function(Sla) updates) =>
      super.copyWith((message) => updates(message as Sla)) as Sla;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Sla() / Sla.new instead')
  static Sla create() => Sla._();
  static $pb.GeneratedMessage $_createMessage() => Sla._();
  @$core.override
  Sla createEmptyInstance() => Sla._();
  @$core.pragma('dart2js:noInline')
  static Sla getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Sla>(Sla.$_createMessage);
  static Sla? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get firstResponseDueAt => $_getSZ(0);
  @$pb.TagNumber(1)
  set firstResponseDueAt($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFirstResponseDueAt() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstResponseDueAt() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get resolutionDueAt => $_getSZ(1);
  @$pb.TagNumber(2)
  set resolutionDueAt($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasResolutionDueAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearResolutionDueAt() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get firstResponseAt => $_getSZ(2);
  @$pb.TagNumber(3)
  set firstResponseAt($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFirstResponseAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstResponseAt() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get firstResponseBreached => $_getBF(3);
  @$pb.TagNumber(4)
  set firstResponseBreached($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFirstResponseBreached() => $_has(3);
  @$pb.TagNumber(4)
  void clearFirstResponseBreached() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get resolutionBreached => $_getBF(4);
  @$pb.TagNumber(5)
  set resolutionBreached($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasResolutionBreached() => $_has(4);
  @$pb.TagNumber(5)
  void clearResolutionBreached() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get breached => $_getBF(5);
  @$pb.TagNumber(6)
  set breached($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBreached() => $_has(5);
  @$pb.TagNumber(6)
  void clearBreached() => $_clearField(6);
}

class SlaResponse extends $pb.GeneratedMessage {
  factory SlaResponse({
    $core.String? firstResponseDueAt,
    $core.String? resolutionDueAt,
    $core.String? firstResponseAt,
    $core.bool? firstResponseBreached,
    $core.bool? resolutionBreached,
    $core.bool? breached,
  }) {
    final result = SlaResponse._();
    if (firstResponseDueAt != null)
      result.firstResponseDueAt = firstResponseDueAt;
    if (resolutionDueAt != null) result.resolutionDueAt = resolutionDueAt;
    if (firstResponseAt != null) result.firstResponseAt = firstResponseAt;
    if (firstResponseBreached != null)
      result.firstResponseBreached = firstResponseBreached;
    if (resolutionBreached != null)
      result.resolutionBreached = resolutionBreached;
    if (breached != null) result.breached = breached;
    return result;
  }

  SlaResponse._();

  factory SlaResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SlaResponse()..mergeFromBuffer(data, registry);
  factory SlaResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SlaResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SlaResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: SlaResponse.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'firstResponseDueAt')
    ..aOS(2, _omitFieldNames ? '' : 'resolutionDueAt')
    ..aOS(3, _omitFieldNames ? '' : 'firstResponseAt')
    ..aOB(4, _omitFieldNames ? '' : 'firstResponseBreached')
    ..aOB(5, _omitFieldNames ? '' : 'resolutionBreached')
    ..aOB(6, _omitFieldNames ? '' : 'breached')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SlaResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SlaResponse copyWith(void Function(SlaResponse) updates) =>
      super.copyWith((message) => updates(message as SlaResponse))
          as SlaResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SlaResponse() / SlaResponse.new instead')
  static SlaResponse create() => SlaResponse._();
  static $pb.GeneratedMessage $_createMessage() => SlaResponse._();
  @$core.override
  SlaResponse createEmptyInstance() => SlaResponse._();
  @$core.pragma('dart2js:noInline')
  static SlaResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SlaResponse>(
          SlaResponse.$_createMessage);
  static SlaResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get firstResponseDueAt => $_getSZ(0);
  @$pb.TagNumber(1)
  set firstResponseDueAt($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFirstResponseDueAt() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstResponseDueAt() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get resolutionDueAt => $_getSZ(1);
  @$pb.TagNumber(2)
  set resolutionDueAt($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasResolutionDueAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearResolutionDueAt() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get firstResponseAt => $_getSZ(2);
  @$pb.TagNumber(3)
  set firstResponseAt($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFirstResponseAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstResponseAt() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get firstResponseBreached => $_getBF(3);
  @$pb.TagNumber(4)
  set firstResponseBreached($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFirstResponseBreached() => $_has(3);
  @$pb.TagNumber(4)
  void clearFirstResponseBreached() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get resolutionBreached => $_getBF(4);
  @$pb.TagNumber(5)
  set resolutionBreached($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasResolutionBreached() => $_has(4);
  @$pb.TagNumber(5)
  void clearResolutionBreached() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get breached => $_getBF(5);
  @$pb.TagNumber(6)
  set breached($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBreached() => $_has(5);
  @$pb.TagNumber(6)
  void clearBreached() => $_clearField(6);
}

class StatsResult extends $pb.GeneratedMessage {
  factory StatsResult({
    $core.int? total,
    $core.int? open,
    $core.int? pending,
    $core.int? onHold,
    $core.int? resolved,
    $core.int? closed,
    $core.int? unassigned,
    $core.int? chats,
    $core.int? rated,
    $core.int? breached,
    $core.int? awaitingFirstResponse,
    $core.double? satisfaction,
  }) {
    final result = StatsResult._();
    if (total != null) result.total = total;
    if (open != null) result.open = open;
    if (pending != null) result.pending = pending;
    if (onHold != null) result.onHold = onHold;
    if (resolved != null) result.resolved = resolved;
    if (closed != null) result.closed = closed;
    if (unassigned != null) result.unassigned = unassigned;
    if (chats != null) result.chats = chats;
    if (rated != null) result.rated = rated;
    if (breached != null) result.breached = breached;
    if (awaitingFirstResponse != null)
      result.awaitingFirstResponse = awaitingFirstResponse;
    if (satisfaction != null) result.satisfaction = satisfaction;
    return result;
  }

  StatsResult._();

  factory StatsResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StatsResult()..mergeFromBuffer(data, registry);
  factory StatsResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StatsResult()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StatsResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: StatsResult.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'total')
    ..aI(2, _omitFieldNames ? '' : 'open')
    ..aI(3, _omitFieldNames ? '' : 'pending')
    ..aI(4, _omitFieldNames ? '' : 'onHold')
    ..aI(5, _omitFieldNames ? '' : 'resolved')
    ..aI(6, _omitFieldNames ? '' : 'closed')
    ..aI(7, _omitFieldNames ? '' : 'unassigned')
    ..aI(8, _omitFieldNames ? '' : 'chats')
    ..aI(9, _omitFieldNames ? '' : 'rated')
    ..aI(10, _omitFieldNames ? '' : 'breached')
    ..aI(11, _omitFieldNames ? '' : 'awaitingFirstResponse')
    ..aD(12, _omitFieldNames ? '' : 'satisfaction',
        fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatsResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatsResult copyWith(void Function(StatsResult) updates) =>
      super.copyWith((message) => updates(message as StatsResult))
          as StatsResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use StatsResult() / StatsResult.new instead')
  static StatsResult create() => StatsResult._();
  static $pb.GeneratedMessage $_createMessage() => StatsResult._();
  @$core.override
  StatsResult createEmptyInstance() => StatsResult._();
  @$core.pragma('dart2js:noInline')
  static StatsResult getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StatsResult>(
          StatsResult.$_createMessage);
  static StatsResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get total => $_getIZ(0);
  @$pb.TagNumber(1)
  set total($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotal() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotal() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get open => $_getIZ(1);
  @$pb.TagNumber(2)
  set open($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOpen() => $_has(1);
  @$pb.TagNumber(2)
  void clearOpen() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get pending => $_getIZ(2);
  @$pb.TagNumber(3)
  set pending($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPending() => $_has(2);
  @$pb.TagNumber(3)
  void clearPending() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get onHold => $_getIZ(3);
  @$pb.TagNumber(4)
  set onHold($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOnHold() => $_has(3);
  @$pb.TagNumber(4)
  void clearOnHold() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get resolved => $_getIZ(4);
  @$pb.TagNumber(5)
  set resolved($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasResolved() => $_has(4);
  @$pb.TagNumber(5)
  void clearResolved() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get closed => $_getIZ(5);
  @$pb.TagNumber(6)
  set closed($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasClosed() => $_has(5);
  @$pb.TagNumber(6)
  void clearClosed() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get unassigned => $_getIZ(6);
  @$pb.TagNumber(7)
  set unassigned($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUnassigned() => $_has(6);
  @$pb.TagNumber(7)
  void clearUnassigned() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get chats => $_getIZ(7);
  @$pb.TagNumber(8)
  set chats($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasChats() => $_has(7);
  @$pb.TagNumber(8)
  void clearChats() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get rated => $_getIZ(8);
  @$pb.TagNumber(9)
  set rated($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRated() => $_has(8);
  @$pb.TagNumber(9)
  void clearRated() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get breached => $_getIZ(9);
  @$pb.TagNumber(10)
  set breached($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasBreached() => $_has(9);
  @$pb.TagNumber(10)
  void clearBreached() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get awaitingFirstResponse => $_getIZ(10);
  @$pb.TagNumber(11)
  set awaitingFirstResponse($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAwaitingFirstResponse() => $_has(10);
  @$pb.TagNumber(11)
  void clearAwaitingFirstResponse() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get satisfaction => $_getN(11);
  @$pb.TagNumber(12)
  set satisfaction($core.double value) => $_setFloat(11, value);
  @$pb.TagNumber(12)
  $core.bool hasSatisfaction() => $_has(11);
  @$pb.TagNumber(12)
  void clearSatisfaction() => $_clearField(12);
}

class StatusRequest extends $pb.GeneratedMessage {
  factory StatusRequest({
    $core.String? ticketId,
    $core.String? status,
  }) {
    final result = StatusRequest._();
    if (ticketId != null) result.ticketId = ticketId;
    if (status != null) result.status = status;
    return result;
  }

  StatusRequest._();

  factory StatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StatusRequest()..mergeFromBuffer(data, registry);
  factory StatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StatusRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: StatusRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatusRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatusRequest copyWith(void Function(StatusRequest) updates) =>
      super.copyWith((message) => updates(message as StatusRequest))
          as StatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use StatusRequest() / StatusRequest.new instead')
  static StatusRequest create() => StatusRequest._();
  static $pb.GeneratedMessage $_createMessage() => StatusRequest._();
  @$core.override
  StatusRequest createEmptyInstance() => StatusRequest._();
  @$core.pragma('dart2js:noInline')
  static StatusRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StatusRequest>(
          StatusRequest.$_createMessage);
  static StatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);
}

class StatusResult extends $pb.GeneratedMessage {
  factory StatusResult({
    $core.String? ticket,
    $core.String? status,
    $core.bool? changed,
  }) {
    final result = StatusResult._();
    if (ticket != null) result.ticket = ticket;
    if (status != null) result.status = status;
    if (changed != null) result.changed = changed;
    return result;
  }

  StatusResult._();

  factory StatusResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StatusResult()..mergeFromBuffer(data, registry);
  factory StatusResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StatusResult()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StatusResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: StatusResult.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticket')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOB(3, _omitFieldNames ? '' : 'changed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatusResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatusResult copyWith(void Function(StatusResult) updates) =>
      super.copyWith((message) => updates(message as StatusResult))
          as StatusResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use StatusResult() / StatusResult.new instead')
  static StatusResult create() => StatusResult._();
  static $pb.GeneratedMessage $_createMessage() => StatusResult._();
  @$core.override
  StatusResult createEmptyInstance() => StatusResult._();
  @$core.pragma('dart2js:noInline')
  static StatusResult getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StatusResult>(
          StatusResult.$_createMessage);
  static StatusResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticket => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticket($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicket() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicket() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get changed => $_getBF(2);
  @$pb.TagNumber(3)
  set changed($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChanged() => $_has(2);
  @$pb.TagNumber(3)
  void clearChanged() => $_clearField(3);
}

class Tag extends $pb.GeneratedMessage {
  factory Tag({
    $core.String? id,
    $core.String? name,
    $core.String? slug,
    $core.String? colour,
  }) {
    final result = Tag._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (slug != null) result.slug = slug;
    if (colour != null) result.colour = colour;
    return result;
  }

  Tag._();

  factory Tag.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Tag()..mergeFromBuffer(data, registry);
  factory Tag.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Tag()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Tag',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: Tag.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'slug')
    ..aOS(4, _omitFieldNames ? '' : 'colour')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Tag clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Tag copyWith(void Function(Tag) updates) =>
      super.copyWith((message) => updates(message as Tag)) as Tag;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Tag() / Tag.new instead')
  static Tag create() => Tag._();
  static $pb.GeneratedMessage $_createMessage() => Tag._();
  @$core.override
  Tag createEmptyInstance() => Tag._();
  @$core.pragma('dart2js:noInline')
  static Tag getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Tag>(Tag.$_createMessage);
  static Tag? _defaultInstance;

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
  $core.String get slug => $_getSZ(2);
  @$pb.TagNumber(3)
  set slug($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSlug() => $_has(2);
  @$pb.TagNumber(3)
  void clearSlug() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get colour => $_getSZ(3);
  @$pb.TagNumber(4)
  set colour($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasColour() => $_has(3);
  @$pb.TagNumber(4)
  void clearColour() => $_clearField(4);
}

class TagList extends $pb.GeneratedMessage {
  factory TagList({
    $core.Iterable<Tag>? tags,
  }) {
    final result = TagList._();
    if (tags != null) result.tags.addAll(tags);
    return result;
  }

  TagList._();

  factory TagList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TagList()..mergeFromBuffer(data, registry);
  factory TagList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TagList()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TagList',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: TagList.$_createMessage)
    ..pPM<Tag>(1, _omitFieldNames ? '' : 'tags',
        subBuilder: Tag.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TagList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TagList copyWith(void Function(TagList) updates) =>
      super.copyWith((message) => updates(message as TagList)) as TagList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TagList() / TagList.new instead')
  static TagList create() => TagList._();
  static $pb.GeneratedMessage $_createMessage() => TagList._();
  @$core.override
  TagList createEmptyInstance() => TagList._();
  @$core.pragma('dart2js:noInline')
  static TagList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TagList>(TagList.$_createMessage);
  static TagList? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Tag> get tags => $_getList(0);
}

class TagRequest extends $pb.GeneratedMessage {
  factory TagRequest({
    $core.String? ticketId,
    $core.Iterable<$core.String>? tags,
  }) {
    final result = TagRequest._();
    if (ticketId != null) result.ticketId = ticketId;
    if (tags != null) result.tags.addAll(tags);
    return result;
  }

  TagRequest._();

  factory TagRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TagRequest()..mergeFromBuffer(data, registry);
  factory TagRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TagRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TagRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: TagRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..pPS(2, _omitFieldNames ? '' : 'tags')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TagRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TagRequest copyWith(void Function(TagRequest) updates) =>
      super.copyWith((message) => updates(message as TagRequest)) as TagRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TagRequest() / TagRequest.new instead')
  static TagRequest create() => TagRequest._();
  static $pb.GeneratedMessage $_createMessage() => TagRequest._();
  @$core.override
  TagRequest createEmptyInstance() => TagRequest._();
  @$core.pragma('dart2js:noInline')
  static TagRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TagRequest>(TagRequest.$_createMessage);
  static TagRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get tags => $_getList(1);
}

class TagResult extends $pb.GeneratedMessage {
  factory TagResult({
    $core.String? ticket,
    $core.Iterable<$core.String>? tags,
    $core.bool? changed,
  }) {
    final result = TagResult._();
    if (ticket != null) result.ticket = ticket;
    if (tags != null) result.tags.addAll(tags);
    if (changed != null) result.changed = changed;
    return result;
  }

  TagResult._();

  factory TagResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TagResult()..mergeFromBuffer(data, registry);
  factory TagResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TagResult()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TagResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: TagResult.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticket')
    ..pPS(2, _omitFieldNames ? '' : 'tags')
    ..aOB(3, _omitFieldNames ? '' : 'changed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TagResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TagResult copyWith(void Function(TagResult) updates) =>
      super.copyWith((message) => updates(message as TagResult)) as TagResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TagResult() / TagResult.new instead')
  static TagResult create() => TagResult._();
  static $pb.GeneratedMessage $_createMessage() => TagResult._();
  @$core.override
  TagResult createEmptyInstance() => TagResult._();
  @$core.pragma('dart2js:noInline')
  static TagResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TagResult>(TagResult.$_createMessage);
  static TagResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticket => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticket($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicket() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicket() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get tags => $_getList(1);

  @$pb.TagNumber(3)
  $core.bool get changed => $_getBF(2);
  @$pb.TagNumber(3)
  set changed($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChanged() => $_has(2);
  @$pb.TagNumber(3)
  void clearChanged() => $_clearField(3);
}

class Ticket extends $pb.GeneratedMessage {
  factory Ticket({
    $core.String? id,
    $core.String? reference,
    $core.String? kind,
    $core.String? subject,
    $core.String? status,
    $core.String? priority,
    AccountResponse? client,
    AccountResponse? assignee,
    CategoryRefResponse? category,
    $core.Iterable<$core.String>? tags,
    $core.String? dataJson,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? lastMessageAt,
    $core.String? resolvedAt,
    $core.String? closedAt,
    $core.int? rating,
    $core.String? ratingComment,
    SlaResponse? sla,
    $core.int? unread,
    $core.Iterable<ParticipantResponse>? participants,
    $core.String? slug,
  }) {
    final result = Ticket._();
    if (id != null) result.id = id;
    if (reference != null) result.reference = reference;
    if (kind != null) result.kind = kind;
    if (subject != null) result.subject = subject;
    if (status != null) result.status = status;
    if (priority != null) result.priority = priority;
    if (client != null) result.client = client;
    if (assignee != null) result.assignee = assignee;
    if (category != null) result.category = category;
    if (tags != null) result.tags.addAll(tags);
    if (dataJson != null) result.dataJson = dataJson;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (lastMessageAt != null) result.lastMessageAt = lastMessageAt;
    if (resolvedAt != null) result.resolvedAt = resolvedAt;
    if (closedAt != null) result.closedAt = closedAt;
    if (rating != null) result.rating = rating;
    if (ratingComment != null) result.ratingComment = ratingComment;
    if (sla != null) result.sla = sla;
    if (unread != null) result.unread = unread;
    if (participants != null) result.participants.addAll(participants);
    if (slug != null) result.slug = slug;
    return result;
  }

  Ticket._();

  factory Ticket.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Ticket()..mergeFromBuffer(data, registry);
  factory Ticket.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Ticket()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Ticket',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: Ticket.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'reference')
    ..aOS(3, _omitFieldNames ? '' : 'kind')
    ..aOS(4, _omitFieldNames ? '' : 'subject')
    ..aOS(5, _omitFieldNames ? '' : 'status')
    ..aOS(6, _omitFieldNames ? '' : 'priority')
    ..aOM<AccountResponse>(7, _omitFieldNames ? '' : 'client',
        subBuilder: AccountResponse.$_createMessage)
    ..aOM<AccountResponse>(8, _omitFieldNames ? '' : 'assignee',
        subBuilder: AccountResponse.$_createMessage)
    ..aOM<CategoryRefResponse>(9, _omitFieldNames ? '' : 'category',
        subBuilder: CategoryRefResponse.$_createMessage)
    ..pPS(10, _omitFieldNames ? '' : 'tags')
    ..aOS(11, _omitFieldNames ? '' : 'dataJson')
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..aOS(13, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(14, _omitFieldNames ? '' : 'lastMessageAt')
    ..aOS(15, _omitFieldNames ? '' : 'resolvedAt')
    ..aOS(16, _omitFieldNames ? '' : 'closedAt')
    ..aI(17, _omitFieldNames ? '' : 'rating')
    ..aOS(18, _omitFieldNames ? '' : 'ratingComment')
    ..aOM<SlaResponse>(19, _omitFieldNames ? '' : 'sla',
        subBuilder: SlaResponse.$_createMessage)
    ..aI(20, _omitFieldNames ? '' : 'unread')
    ..pPM<ParticipantResponse>(21, _omitFieldNames ? '' : 'participants',
        subBuilder: ParticipantResponse.$_createMessage)
    ..aOS(22, _omitFieldNames ? '' : 'slug')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Ticket clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Ticket copyWith(void Function(Ticket) updates) =>
      super.copyWith((message) => updates(message as Ticket)) as Ticket;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Ticket() / Ticket.new instead')
  static Ticket create() => Ticket._();
  static $pb.GeneratedMessage $_createMessage() => Ticket._();
  @$core.override
  Ticket createEmptyInstance() => Ticket._();
  @$core.pragma('dart2js:noInline')
  static Ticket getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Ticket>(Ticket.$_createMessage);
  static Ticket? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get kind => $_getSZ(2);
  @$pb.TagNumber(3)
  set kind($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasKind() => $_has(2);
  @$pb.TagNumber(3)
  void clearKind() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get subject => $_getSZ(3);
  @$pb.TagNumber(4)
  set subject($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSubject() => $_has(3);
  @$pb.TagNumber(4)
  void clearSubject() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get status => $_getSZ(4);
  @$pb.TagNumber(5)
  set status($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get priority => $_getSZ(5);
  @$pb.TagNumber(6)
  set priority($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPriority() => $_has(5);
  @$pb.TagNumber(6)
  void clearPriority() => $_clearField(6);

  @$pb.TagNumber(7)
  AccountResponse get client => $_getN(6);
  @$pb.TagNumber(7)
  set client(AccountResponse value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasClient() => $_has(6);
  @$pb.TagNumber(7)
  void clearClient() => $_clearField(7);
  @$pb.TagNumber(7)
  AccountResponse ensureClient() => $_ensure(6);

  @$pb.TagNumber(8)
  AccountResponse get assignee => $_getN(7);
  @$pb.TagNumber(8)
  set assignee(AccountResponse value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasAssignee() => $_has(7);
  @$pb.TagNumber(8)
  void clearAssignee() => $_clearField(8);
  @$pb.TagNumber(8)
  AccountResponse ensureAssignee() => $_ensure(7);

  @$pb.TagNumber(9)
  CategoryRefResponse get category => $_getN(8);
  @$pb.TagNumber(9)
  set category(CategoryRefResponse value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasCategory() => $_has(8);
  @$pb.TagNumber(9)
  void clearCategory() => $_clearField(9);
  @$pb.TagNumber(9)
  CategoryRefResponse ensureCategory() => $_ensure(8);

  @$pb.TagNumber(10)
  $pb.PbList<$core.String> get tags => $_getList(9);

  @$pb.TagNumber(11)
  $core.String get dataJson => $_getSZ(10);
  @$pb.TagNumber(11)
  set dataJson($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDataJson() => $_has(10);
  @$pb.TagNumber(11)
  void clearDataJson() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get updatedAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set updatedAt($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get lastMessageAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set lastMessageAt($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasLastMessageAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearLastMessageAt() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get resolvedAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set resolvedAt($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasResolvedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearResolvedAt() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get closedAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set closedAt($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasClosedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearClosedAt() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.int get rating => $_getIZ(16);
  @$pb.TagNumber(17)
  set rating($core.int value) => $_setSignedInt32(16, value);
  @$pb.TagNumber(17)
  $core.bool hasRating() => $_has(16);
  @$pb.TagNumber(17)
  void clearRating() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get ratingComment => $_getSZ(17);
  @$pb.TagNumber(18)
  set ratingComment($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasRatingComment() => $_has(17);
  @$pb.TagNumber(18)
  void clearRatingComment() => $_clearField(18);

  @$pb.TagNumber(19)
  SlaResponse get sla => $_getN(18);
  @$pb.TagNumber(19)
  set sla(SlaResponse value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasSla() => $_has(18);
  @$pb.TagNumber(19)
  void clearSla() => $_clearField(19);
  @$pb.TagNumber(19)
  SlaResponse ensureSla() => $_ensure(18);

  @$pb.TagNumber(20)
  $core.int get unread => $_getIZ(19);
  @$pb.TagNumber(20)
  set unread($core.int value) => $_setSignedInt32(19, value);
  @$pb.TagNumber(20)
  $core.bool hasUnread() => $_has(19);
  @$pb.TagNumber(20)
  void clearUnread() => $_clearField(20);

  @$pb.TagNumber(21)
  $pb.PbList<ParticipantResponse> get participants => $_getList(20);

  @$pb.TagNumber(22)
  $core.String get slug => $_getSZ(21);
  @$pb.TagNumber(22)
  set slug($core.String value) => $_setString(21, value);
  @$pb.TagNumber(22)
  $core.bool hasSlug() => $_has(21);
  @$pb.TagNumber(22)
  void clearSlug() => $_clearField(22);
}

class TicketList extends $pb.GeneratedMessage {
  factory TicketList({
    $core.Iterable<Ticket>? tickets,
    $core.int? total,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = TicketList._();
    if (tickets != null) result.tickets.addAll(tickets);
    if (total != null) result.total = total;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  TicketList._();

  factory TicketList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TicketList()..mergeFromBuffer(data, registry);
  factory TicketList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TicketList()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TicketList',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: TicketList.$_createMessage)
    ..pPM<Ticket>(1, _omitFieldNames ? '' : 'tickets',
        subBuilder: Ticket.$_createMessage)
    ..aI(2, _omitFieldNames ? '' : 'total')
    ..aI(3, _omitFieldNames ? '' : 'limit')
    ..aI(4, _omitFieldNames ? '' : 'offset')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TicketList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TicketList copyWith(void Function(TicketList) updates) =>
      super.copyWith((message) => updates(message as TicketList)) as TicketList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TicketList() / TicketList.new instead')
  static TicketList create() => TicketList._();
  static $pb.GeneratedMessage $_createMessage() => TicketList._();
  @$core.override
  TicketList createEmptyInstance() => TicketList._();
  @$core.pragma('dart2js:noInline')
  static TicketList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TicketList>(TicketList.$_createMessage);
  static TicketList? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Ticket> get tickets => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get offset => $_getIZ(3);
  @$pb.TagNumber(4)
  set offset($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOffset() => $_has(3);
  @$pb.TagNumber(4)
  void clearOffset() => $_clearField(4);
}

class TypingRequest extends $pb.GeneratedMessage {
  factory TypingRequest({
    $core.String? ticketId,
    $core.bool? typing,
  }) {
    final result = TypingRequest._();
    if (ticketId != null) result.ticketId = ticketId;
    if (typing != null) result.typing = typing;
    return result;
  }

  TypingRequest._();

  factory TypingRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TypingRequest()..mergeFromBuffer(data, registry);
  factory TypingRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TypingRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TypingRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: TypingRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..aOB(2, _omitFieldNames ? '' : 'typing')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TypingRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TypingRequest copyWith(void Function(TypingRequest) updates) =>
      super.copyWith((message) => updates(message as TypingRequest))
          as TypingRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TypingRequest() / TypingRequest.new instead')
  static TypingRequest create() => TypingRequest._();
  static $pb.GeneratedMessage $_createMessage() => TypingRequest._();
  @$core.override
  TypingRequest createEmptyInstance() => TypingRequest._();
  @$core.pragma('dart2js:noInline')
  static TypingRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TypingRequest>(
          TypingRequest.$_createMessage);
  static TypingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get typing => $_getBF(1);
  @$pb.TagNumber(2)
  set typing($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTyping() => $_has(1);
  @$pb.TagNumber(2)
  void clearTyping() => $_clearField(2);
}

class TypingResult extends $pb.GeneratedMessage {
  factory TypingResult({
    $core.String? ticket,
    $core.bool? typing,
  }) {
    final result = TypingResult._();
    if (ticket != null) result.ticket = ticket;
    if (typing != null) result.typing = typing;
    return result;
  }

  TypingResult._();

  factory TypingResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TypingResult()..mergeFromBuffer(data, registry);
  factory TypingResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TypingResult()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TypingResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: TypingResult.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticket')
    ..aOB(2, _omitFieldNames ? '' : 'typing')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TypingResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TypingResult copyWith(void Function(TypingResult) updates) =>
      super.copyWith((message) => updates(message as TypingResult))
          as TypingResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TypingResult() / TypingResult.new instead')
  static TypingResult create() => TypingResult._();
  static $pb.GeneratedMessage $_createMessage() => TypingResult._();
  @$core.override
  TypingResult createEmptyInstance() => TypingResult._();
  @$core.pragma('dart2js:noInline')
  static TypingResult getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TypingResult>(
          TypingResult.$_createMessage);
  static TypingResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticket => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticket($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicket() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicket() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get typing => $_getBF(1);
  @$pb.TagNumber(2)
  set typing($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTyping() => $_has(1);
  @$pb.TagNumber(2)
  void clearTyping() => $_clearField(2);
}

class UnreadResult extends $pb.GeneratedMessage {
  factory UnreadResult({
    $core.int? messages,
    $core.int? tickets,
  }) {
    final result = UnreadResult._();
    if (messages != null) result.messages = messages;
    if (tickets != null) result.tickets = tickets;
    return result;
  }

  UnreadResult._();

  factory UnreadResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UnreadResult()..mergeFromBuffer(data, registry);
  factory UnreadResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UnreadResult()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnreadResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: UnreadResult.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'messages')
    ..aI(2, _omitFieldNames ? '' : 'tickets')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnreadResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnreadResult copyWith(void Function(UnreadResult) updates) =>
      super.copyWith((message) => updates(message as UnreadResult))
          as UnreadResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UnreadResult() / UnreadResult.new instead')
  static UnreadResult create() => UnreadResult._();
  static $pb.GeneratedMessage $_createMessage() => UnreadResult._();
  @$core.override
  UnreadResult createEmptyInstance() => UnreadResult._();
  @$core.pragma('dart2js:noInline')
  static UnreadResult getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnreadResult>(
          UnreadResult.$_createMessage);
  static UnreadResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get messages => $_getIZ(0);
  @$pb.TagNumber(1)
  set messages($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessages() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessages() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get tickets => $_getIZ(1);
  @$pb.TagNumber(2)
  set tickets($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTickets() => $_has(1);
  @$pb.TagNumber(2)
  void clearTickets() => $_clearField(2);
}

class UnreadTicketRequest extends $pb.GeneratedMessage {
  factory UnreadTicketRequest({
    $core.String? ticketId,
  }) {
    final result = UnreadTicketRequest._();
    if (ticketId != null) result.ticketId = ticketId;
    return result;
  }

  UnreadTicketRequest._();

  factory UnreadTicketRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UnreadTicketRequest()..mergeFromBuffer(data, registry);
  factory UnreadTicketRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UnreadTicketRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnreadTicketRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: UnreadTicketRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnreadTicketRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnreadTicketRequest copyWith(void Function(UnreadTicketRequest) updates) =>
      super.copyWith((message) => updates(message as UnreadTicketRequest))
          as UnreadTicketRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use UnreadTicketRequest() / UnreadTicketRequest.new instead')
  static UnreadTicketRequest create() => UnreadTicketRequest._();
  static $pb.GeneratedMessage $_createMessage() => UnreadTicketRequest._();
  @$core.override
  UnreadTicketRequest createEmptyInstance() => UnreadTicketRequest._();
  @$core.pragma('dart2js:noInline')
  static UnreadTicketRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnreadTicketRequest>(
          UnreadTicketRequest.$_createMessage);
  static UnreadTicketRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);
}

class UnreadTicketResult extends $pb.GeneratedMessage {
  factory UnreadTicketResult({
    $core.String? ticket,
    $core.bool? changed,
    $core.int? unread,
    $core.String? lastReadAt,
  }) {
    final result = UnreadTicketResult._();
    if (ticket != null) result.ticket = ticket;
    if (changed != null) result.changed = changed;
    if (unread != null) result.unread = unread;
    if (lastReadAt != null) result.lastReadAt = lastReadAt;
    return result;
  }

  UnreadTicketResult._();

  factory UnreadTicketResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UnreadTicketResult()..mergeFromBuffer(data, registry);
  factory UnreadTicketResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UnreadTicketResult()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnreadTicketResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.support'),
      createEmptyInstance: UnreadTicketResult.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ticket')
    ..aOB(2, _omitFieldNames ? '' : 'changed')
    ..aI(3, _omitFieldNames ? '' : 'unread')
    ..aOS(4, _omitFieldNames ? '' : 'lastReadAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnreadTicketResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnreadTicketResult copyWith(void Function(UnreadTicketResult) updates) =>
      super.copyWith((message) => updates(message as UnreadTicketResult))
          as UnreadTicketResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UnreadTicketResult() / UnreadTicketResult.new instead')
  static UnreadTicketResult create() => UnreadTicketResult._();
  static $pb.GeneratedMessage $_createMessage() => UnreadTicketResult._();
  @$core.override
  UnreadTicketResult createEmptyInstance() => UnreadTicketResult._();
  @$core.pragma('dart2js:noInline')
  static UnreadTicketResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnreadTicketResult>(
          UnreadTicketResult.$_createMessage);
  static UnreadTicketResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticket => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticket($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicket() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicket() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get changed => $_getBF(1);
  @$pb.TagNumber(2)
  set changed($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChanged() => $_has(1);
  @$pb.TagNumber(2)
  void clearChanged() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get unread => $_getIZ(2);
  @$pb.TagNumber(3)
  set unread($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUnread() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnread() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastReadAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastReadAt($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLastReadAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastReadAt() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
