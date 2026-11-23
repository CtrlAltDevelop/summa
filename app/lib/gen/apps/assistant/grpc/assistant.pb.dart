// This is a generated file - do not edit.
//
// Generated from apps/assistant/grpc/assistant.proto.

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

class AccountingHour extends $pb.GeneratedMessage {
  factory AccountingHour({
    $core.int? hour,
  }) {
    final result = AccountingHour._();
    if (hour != null) result.hour = hour;
    return result;
  }

  AccountingHour._();

  factory AccountingHour.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AccountingHour()..mergeFromBuffer(data, registry);
  factory AccountingHour.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AccountingHour()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AccountingHour',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.assistant'),
      createEmptyInstance: AccountingHour.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'hour')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccountingHour clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccountingHour copyWith(void Function(AccountingHour) updates) =>
      super.copyWith((message) => updates(message as AccountingHour))
          as AccountingHour;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AccountingHour() / AccountingHour.new instead')
  static AccountingHour create() => AccountingHour._();
  static $pb.GeneratedMessage $_createMessage() => AccountingHour._();
  @$core.override
  AccountingHour createEmptyInstance() => AccountingHour._();
  @$core.pragma('dart2js:noInline')
  static AccountingHour getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccountingHour>(
          AccountingHour.$_createMessage);
  static AccountingHour? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get hour => $_getIZ(0);
  @$pb.TagNumber(1)
  set hour($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHour() => $_has(0);
  @$pb.TagNumber(1)
  void clearHour() => $_clearField(1);
}

class Card extends $pb.GeneratedMessage {
  factory Card({
    $core.String? kind,
    $fixnum.Int64? amountMinor,
    $core.String? currency,
    $core.String? walletId,
    $core.String? toWalletId,
    $core.String? categoryId,
    $core.String? note,
    $core.String? occurredAt,
  }) {
    final result = Card._();
    if (kind != null) result.kind = kind;
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (currency != null) result.currency = currency;
    if (walletId != null) result.walletId = walletId;
    if (toWalletId != null) result.toWalletId = toWalletId;
    if (categoryId != null) result.categoryId = categoryId;
    if (note != null) result.note = note;
    if (occurredAt != null) result.occurredAt = occurredAt;
    return result;
  }

  Card._();

  factory Card.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Card()..mergeFromBuffer(data, registry);
  factory Card.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Card()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Card',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.assistant'),
      createEmptyInstance: Card.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'kind')
    ..aInt64(2, _omitFieldNames ? '' : 'amountMinor')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'walletId')
    ..aOS(5, _omitFieldNames ? '' : 'toWalletId')
    ..aOS(6, _omitFieldNames ? '' : 'categoryId')
    ..aOS(7, _omitFieldNames ? '' : 'note')
    ..aOS(8, _omitFieldNames ? '' : 'occurredAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Card clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Card copyWith(void Function(Card) updates) =>
      super.copyWith((message) => updates(message as Card)) as Card;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Card() / Card.new instead')
  static Card create() => Card._();
  static $pb.GeneratedMessage $_createMessage() => Card._();
  @$core.override
  Card createEmptyInstance() => Card._();
  @$core.pragma('dart2js:noInline')
  static Card getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Card>(Card.$_createMessage);
  static Card? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get kind => $_getSZ(0);
  @$pb.TagNumber(1)
  set kind($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amountMinor => $_getI64(1);
  @$pb.TagNumber(2)
  set amountMinor($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmountMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountMinor() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get walletId => $_getSZ(3);
  @$pb.TagNumber(4)
  set walletId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasWalletId() => $_has(3);
  @$pb.TagNumber(4)
  void clearWalletId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get toWalletId => $_getSZ(4);
  @$pb.TagNumber(5)
  set toWalletId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasToWalletId() => $_has(4);
  @$pb.TagNumber(5)
  void clearToWalletId() => $_clearField(5);

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
  $core.String get occurredAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set occurredAt($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasOccurredAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearOccurredAt() => $_clearField(8);
}

class CardLink extends $pb.GeneratedMessage {
  factory CardLink({
    $core.String? last4,
    $core.String? walletId,
  }) {
    final result = CardLink._();
    if (last4 != null) result.last4 = last4;
    if (walletId != null) result.walletId = walletId;
    return result;
  }

  CardLink._();

  factory CardLink.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CardLink()..mergeFromBuffer(data, registry);
  factory CardLink.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CardLink()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CardLink',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.assistant'),
      createEmptyInstance: CardLink.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'last4')
    ..aOS(2, _omitFieldNames ? '' : 'walletId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CardLink clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CardLink copyWith(void Function(CardLink) updates) =>
      super.copyWith((message) => updates(message as CardLink)) as CardLink;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CardLink() / CardLink.new instead')
  static CardLink create() => CardLink._();
  static $pb.GeneratedMessage $_createMessage() => CardLink._();
  @$core.override
  CardLink createEmptyInstance() => CardLink._();
  @$core.pragma('dart2js:noInline')
  static CardLink getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CardLink>(CardLink.$_createMessage);
  static CardLink? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get last4 => $_getSZ(0);
  @$pb.TagNumber(1)
  set last4($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLast4() => $_has(0);
  @$pb.TagNumber(1)
  void clearLast4() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get walletId => $_getSZ(1);
  @$pb.TagNumber(2)
  set walletId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWalletId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWalletId() => $_clearField(2);
}

class ChatReply extends $pb.GeneratedMessage {
  factory ChatReply({
    $core.Iterable<Message>? messages,
  }) {
    final result = ChatReply._();
    if (messages != null) result.messages.addAll(messages);
    return result;
  }

  ChatReply._();

  factory ChatReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatReply()..mergeFromBuffer(data, registry);
  factory ChatReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatReply',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.assistant'),
      createEmptyInstance: ChatReply.$_createMessage)
    ..pPM<Message>(1, _omitFieldNames ? '' : 'messages',
        subBuilder: Message.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatReply copyWith(void Function(ChatReply) updates) =>
      super.copyWith((message) => updates(message as ChatReply)) as ChatReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChatReply() / ChatReply.new instead')
  static ChatReply create() => ChatReply._();
  static $pb.GeneratedMessage $_createMessage() => ChatReply._();
  @$core.override
  ChatReply createEmptyInstance() => ChatReply._();
  @$core.pragma('dart2js:noInline')
  static ChatReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatReply>(ChatReply.$_createMessage);
  static ChatReply? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Message> get messages => $_getList(0);
}

class DigestReply extends $pb.GeneratedMessage {
  factory DigestReply({
    $core.int? accountingHour,
    $core.int? entriesToday,
    $core.int? uncategorizedToday,
    $core.int? dueQuestions,
    $core.int? lowBalanceWarnings,
    $core.bool? shouldRemind,
  }) {
    final result = DigestReply._();
    if (accountingHour != null) result.accountingHour = accountingHour;
    if (entriesToday != null) result.entriesToday = entriesToday;
    if (uncategorizedToday != null)
      result.uncategorizedToday = uncategorizedToday;
    if (dueQuestions != null) result.dueQuestions = dueQuestions;
    if (lowBalanceWarnings != null)
      result.lowBalanceWarnings = lowBalanceWarnings;
    if (shouldRemind != null) result.shouldRemind = shouldRemind;
    return result;
  }

  DigestReply._();

  factory DigestReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DigestReply()..mergeFromBuffer(data, registry);
  factory DigestReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DigestReply()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DigestReply',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.assistant'),
      createEmptyInstance: DigestReply.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'accountingHour')
    ..aI(2, _omitFieldNames ? '' : 'entriesToday')
    ..aI(3, _omitFieldNames ? '' : 'uncategorizedToday')
    ..aI(4, _omitFieldNames ? '' : 'dueQuestions')
    ..aI(5, _omitFieldNames ? '' : 'lowBalanceWarnings')
    ..aOB(6, _omitFieldNames ? '' : 'shouldRemind')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DigestReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DigestReply copyWith(void Function(DigestReply) updates) =>
      super.copyWith((message) => updates(message as DigestReply))
          as DigestReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DigestReply() / DigestReply.new instead')
  static DigestReply create() => DigestReply._();
  static $pb.GeneratedMessage $_createMessage() => DigestReply._();
  @$core.override
  DigestReply createEmptyInstance() => DigestReply._();
  @$core.pragma('dart2js:noInline')
  static DigestReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DigestReply>(
          DigestReply.$_createMessage);
  static DigestReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get accountingHour => $_getIZ(0);
  @$pb.TagNumber(1)
  set accountingHour($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountingHour() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountingHour() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get entriesToday => $_getIZ(1);
  @$pb.TagNumber(2)
  set entriesToday($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEntriesToday() => $_has(1);
  @$pb.TagNumber(2)
  void clearEntriesToday() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get uncategorizedToday => $_getIZ(2);
  @$pb.TagNumber(3)
  set uncategorizedToday($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUncategorizedToday() => $_has(2);
  @$pb.TagNumber(3)
  void clearUncategorizedToday() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get dueQuestions => $_getIZ(3);
  @$pb.TagNumber(4)
  set dueQuestions($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDueQuestions() => $_has(3);
  @$pb.TagNumber(4)
  void clearDueQuestions() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get lowBalanceWarnings => $_getIZ(4);
  @$pb.TagNumber(5)
  set lowBalanceWarnings($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLowBalanceWarnings() => $_has(4);
  @$pb.TagNumber(5)
  void clearLowBalanceWarnings() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get shouldRemind => $_getBF(5);
  @$pb.TagNumber(6)
  set shouldRemind($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasShouldRemind() => $_has(5);
  @$pb.TagNumber(6)
  void clearShouldRemind() => $_clearField(6);
}

class HistoryQuery extends $pb.GeneratedMessage {
  factory HistoryQuery({
    $core.int? limit,
  }) {
    final result = HistoryQuery._();
    if (limit != null) result.limit = limit;
    return result;
  }

  HistoryQuery._();

  factory HistoryQuery.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HistoryQuery()..mergeFromBuffer(data, registry);
  factory HistoryQuery.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HistoryQuery()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HistoryQuery',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.assistant'),
      createEmptyInstance: HistoryQuery.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'limit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HistoryQuery clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HistoryQuery copyWith(void Function(HistoryQuery) updates) =>
      super.copyWith((message) => updates(message as HistoryQuery))
          as HistoryQuery;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use HistoryQuery() / HistoryQuery.new instead')
  static HistoryQuery create() => HistoryQuery._();
  static $pb.GeneratedMessage $_createMessage() => HistoryQuery._();
  @$core.override
  HistoryQuery createEmptyInstance() => HistoryQuery._();
  @$core.pragma('dart2js:noInline')
  static HistoryQuery getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HistoryQuery>(
          HistoryQuery.$_createMessage);
  static HistoryQuery? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);
}

class Message extends $pb.GeneratedMessage {
  factory Message({
    $core.String? id,
    $core.String? role,
    $core.String? text,
    $core.String? createdAt,
    Card? card,
    $core.bool? cardPresent,
  }) {
    final result = Message._();
    if (id != null) result.id = id;
    if (role != null) result.role = role;
    if (text != null) result.text = text;
    if (createdAt != null) result.createdAt = createdAt;
    if (card != null) result.card = card;
    if (cardPresent != null) result.cardPresent = cardPresent;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.assistant'),
      createEmptyInstance: Message.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'role')
    ..aOS(3, _omitFieldNames ? '' : 'text')
    ..aOS(4, _omitFieldNames ? '' : 'createdAt')
    ..aOM<Card>(6, _omitFieldNames ? '' : 'card',
        subBuilder: Card.$_createMessage)
    ..aOB(7, _omitFieldNames ? '' : 'cardPresent')
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
  $core.String get role => $_getSZ(1);
  @$pb.TagNumber(2)
  set role($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearRole() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get text => $_getSZ(2);
  @$pb.TagNumber(3)
  set text($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasText() => $_has(2);
  @$pb.TagNumber(3)
  void clearText() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get createdAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set createdAt($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => $_clearField(4);

  @$pb.TagNumber(6)
  Card get card => $_getN(4);
  @$pb.TagNumber(6)
  set card(Card value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCard() => $_has(4);
  @$pb.TagNumber(6)
  void clearCard() => $_clearField(6);
  @$pb.TagNumber(6)
  Card ensureCard() => $_ensure(4);

  @$pb.TagNumber(7)
  $core.bool get cardPresent => $_getBF(5);
  @$pb.TagNumber(7)
  set cardPresent($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(7)
  $core.bool hasCardPresent() => $_has(5);
  @$pb.TagNumber(7)
  void clearCardPresent() => $_clearField(7);
}

class MessageSend extends $pb.GeneratedMessage {
  factory MessageSend({
    $core.String? text,
    $core.String? clientMutationId,
  }) {
    final result = MessageSend._();
    if (text != null) result.text = text;
    if (clientMutationId != null) result.clientMutationId = clientMutationId;
    return result;
  }

  MessageSend._();

  factory MessageSend.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessageSend()..mergeFromBuffer(data, registry);
  factory MessageSend.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessageSend()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MessageSend',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.assistant'),
      createEmptyInstance: MessageSend.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..aOS(2, _omitFieldNames ? '' : 'clientMutationId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessageSend clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessageSend copyWith(void Function(MessageSend) updates) =>
      super.copyWith((message) => updates(message as MessageSend))
          as MessageSend;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MessageSend() / MessageSend.new instead')
  static MessageSend create() => MessageSend._();
  static $pb.GeneratedMessage $_createMessage() => MessageSend._();
  @$core.override
  MessageSend createEmptyInstance() => MessageSend._();
  @$core.pragma('dart2js:noInline')
  static MessageSend getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MessageSend>(
          MessageSend.$_createMessage);
  static MessageSend? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get clientMutationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set clientMutationId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasClientMutationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearClientMutationId() => $_clearField(2);
}

class SmsCard extends $pb.GeneratedMessage {
  factory SmsCard({
    $core.String? ignored,
    $core.String? kind,
    $fixnum.Int64? amountMinor,
    $core.String? currency,
    $core.String? walletId,
    $core.String? confidence,
    $core.String? occurredAt,
    $core.bool? balancePresent,
    $fixnum.Int64? balanceMinor,
    $core.String? last4,
    $core.String? categoryId,
    $core.Iterable<$core.String>? suggestedCategoryIds,
    $core.String? duplicateEntryId,
  }) {
    final result = SmsCard._();
    if (ignored != null) result.ignored = ignored;
    if (kind != null) result.kind = kind;
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (currency != null) result.currency = currency;
    if (walletId != null) result.walletId = walletId;
    if (confidence != null) result.confidence = confidence;
    if (occurredAt != null) result.occurredAt = occurredAt;
    if (balancePresent != null) result.balancePresent = balancePresent;
    if (balanceMinor != null) result.balanceMinor = balanceMinor;
    if (last4 != null) result.last4 = last4;
    if (categoryId != null) result.categoryId = categoryId;
    if (suggestedCategoryIds != null)
      result.suggestedCategoryIds.addAll(suggestedCategoryIds);
    if (duplicateEntryId != null) result.duplicateEntryId = duplicateEntryId;
    return result;
  }

  SmsCard._();

  factory SmsCard.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SmsCard()..mergeFromBuffer(data, registry);
  factory SmsCard.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SmsCard()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SmsCard',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.assistant'),
      createEmptyInstance: SmsCard.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ignored')
    ..aOS(2, _omitFieldNames ? '' : 'kind')
    ..aInt64(3, _omitFieldNames ? '' : 'amountMinor')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'walletId')
    ..aOS(6, _omitFieldNames ? '' : 'confidence')
    ..aOS(7, _omitFieldNames ? '' : 'occurredAt')
    ..aOB(8, _omitFieldNames ? '' : 'balancePresent')
    ..aInt64(9, _omitFieldNames ? '' : 'balanceMinor')
    ..aOS(10, _omitFieldNames ? '' : 'last4')
    ..aOS(11, _omitFieldNames ? '' : 'categoryId')
    ..pPS(12, _omitFieldNames ? '' : 'suggestedCategoryIds')
    ..aOS(13, _omitFieldNames ? '' : 'duplicateEntryId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsCard clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsCard copyWith(void Function(SmsCard) updates) =>
      super.copyWith((message) => updates(message as SmsCard)) as SmsCard;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SmsCard() / SmsCard.new instead')
  static SmsCard create() => SmsCard._();
  static $pb.GeneratedMessage $_createMessage() => SmsCard._();
  @$core.override
  SmsCard createEmptyInstance() => SmsCard._();
  @$core.pragma('dart2js:noInline')
  static SmsCard getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SmsCard>(SmsCard.$_createMessage);
  static SmsCard? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ignored => $_getSZ(0);
  @$pb.TagNumber(1)
  set ignored($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIgnored() => $_has(0);
  @$pb.TagNumber(1)
  void clearIgnored() => $_clearField(1);

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
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get walletId => $_getSZ(4);
  @$pb.TagNumber(5)
  set walletId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasWalletId() => $_has(4);
  @$pb.TagNumber(5)
  void clearWalletId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get confidence => $_getSZ(5);
  @$pb.TagNumber(6)
  set confidence($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasConfidence() => $_has(5);
  @$pb.TagNumber(6)
  void clearConfidence() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get occurredAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set occurredAt($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasOccurredAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearOccurredAt() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get balancePresent => $_getBF(7);
  @$pb.TagNumber(8)
  set balancePresent($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasBalancePresent() => $_has(7);
  @$pb.TagNumber(8)
  void clearBalancePresent() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get balanceMinor => $_getI64(8);
  @$pb.TagNumber(9)
  set balanceMinor($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasBalanceMinor() => $_has(8);
  @$pb.TagNumber(9)
  void clearBalanceMinor() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get last4 => $_getSZ(9);
  @$pb.TagNumber(10)
  set last4($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasLast4() => $_has(9);
  @$pb.TagNumber(10)
  void clearLast4() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get categoryId => $_getSZ(10);
  @$pb.TagNumber(11)
  set categoryId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCategoryId() => $_has(10);
  @$pb.TagNumber(11)
  void clearCategoryId() => $_clearField(11);

  @$pb.TagNumber(12)
  $pb.PbList<$core.String> get suggestedCategoryIds => $_getList(11);

  @$pb.TagNumber(13)
  $core.String get duplicateEntryId => $_getSZ(12);
  @$pb.TagNumber(13)
  set duplicateEntryId($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasDuplicateEntryId() => $_has(12);
  @$pb.TagNumber(13)
  void clearDuplicateEntryId() => $_clearField(13);
}

class SmsText extends $pb.GeneratedMessage {
  factory SmsText({
    $core.String? text,
  }) {
    final result = SmsText._();
    if (text != null) result.text = text;
    return result;
  }

  SmsText._();

  factory SmsText.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SmsText()..mergeFromBuffer(data, registry);
  factory SmsText.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SmsText()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SmsText',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'config.assistant'),
      createEmptyInstance: SmsText.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsText clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SmsText copyWith(void Function(SmsText) updates) =>
      super.copyWith((message) => updates(message as SmsText)) as SmsText;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SmsText() / SmsText.new instead')
  static SmsText create() => SmsText._();
  static $pb.GeneratedMessage $_createMessage() => SmsText._();
  @$core.override
  SmsText createEmptyInstance() => SmsText._();
  @$core.pragma('dart2js:noInline')
  static SmsText getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SmsText>(SmsText.$_createMessage);
  static SmsText? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
