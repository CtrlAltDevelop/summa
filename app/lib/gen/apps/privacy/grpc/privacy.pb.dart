// This is a generated file - do not edit.
//
// Generated from apps/privacy/grpc/privacy.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ChatRetention extends $pb.GeneratedMessage {
  factory ChatRetention({
    $core.int? days,
  }) {
    final result = ChatRetention._();
    if (days != null) result.days = days;
    return result;
  }

  ChatRetention._();

  factory ChatRetention.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatRetention()..mergeFromBuffer(data, registry);
  factory ChatRetention.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatRetention()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatRetention',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.privacy'),
      createEmptyInstance: ChatRetention.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'days')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatRetention clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatRetention copyWith(void Function(ChatRetention) updates) =>
      super.copyWith((message) => updates(message as ChatRetention))
          as ChatRetention;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChatRetention() / ChatRetention.new instead')
  static ChatRetention create() => ChatRetention._();
  static $pb.GeneratedMessage $_createMessage() => ChatRetention._();
  @$core.override
  ChatRetention createEmptyInstance() => ChatRetention._();
  @$core.pragma('dart2js:noInline')
  static ChatRetention getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatRetention>(
          ChatRetention.$_createMessage);
  static ChatRetention? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get days => $_getIZ(0);
  @$pb.TagNumber(1)
  set days($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDays() => $_has(0);
  @$pb.TagNumber(1)
  void clearDays() => $_clearField(1);
}

class DeleteConfirmation extends $pb.GeneratedMessage {
  factory DeleteConfirmation({
    $core.String? confirmation,
  }) {
    final result = DeleteConfirmation._();
    if (confirmation != null) result.confirmation = confirmation;
    return result;
  }

  DeleteConfirmation._();

  factory DeleteConfirmation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteConfirmation()..mergeFromBuffer(data, registry);
  factory DeleteConfirmation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteConfirmation()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteConfirmation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.privacy'),
      createEmptyInstance: DeleteConfirmation.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'confirmation')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteConfirmation clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteConfirmation copyWith(void Function(DeleteConfirmation) updates) =>
      super.copyWith((message) => updates(message as DeleteConfirmation))
          as DeleteConfirmation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DeleteConfirmation() / DeleteConfirmation.new instead')
  static DeleteConfirmation create() => DeleteConfirmation._();
  static $pb.GeneratedMessage $_createMessage() => DeleteConfirmation._();
  @$core.override
  DeleteConfirmation createEmptyInstance() => DeleteConfirmation._();
  @$core.pragma('dart2js:noInline')
  static DeleteConfirmation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteConfirmation>(
          DeleteConfirmation.$_createMessage);
  static DeleteConfirmation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get confirmation => $_getSZ(0);
  @$pb.TagNumber(1)
  set confirmation($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConfirmation() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfirmation() => $_clearField(1);
}

class PrivacySettings extends $pb.GeneratedMessage {
  factory PrivacySettings({
    $core.int? chatRetentionDays,
  }) {
    final result = PrivacySettings._();
    if (chatRetentionDays != null) result.chatRetentionDays = chatRetentionDays;
    return result;
  }

  PrivacySettings._();

  factory PrivacySettings.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PrivacySettings()..mergeFromBuffer(data, registry);
  factory PrivacySettings.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PrivacySettings()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PrivacySettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'config.privacy'),
      createEmptyInstance: PrivacySettings.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'chatRetentionDays')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PrivacySettings clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PrivacySettings copyWith(void Function(PrivacySettings) updates) =>
      super.copyWith((message) => updates(message as PrivacySettings))
          as PrivacySettings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PrivacySettings() / PrivacySettings.new instead')
  static PrivacySettings create() => PrivacySettings._();
  static $pb.GeneratedMessage $_createMessage() => PrivacySettings._();
  @$core.override
  PrivacySettings createEmptyInstance() => PrivacySettings._();
  @$core.pragma('dart2js:noInline')
  static PrivacySettings getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PrivacySettings>(
          PrivacySettings.$_createMessage);
  static PrivacySettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get chatRetentionDays => $_getIZ(0);
  @$pb.TagNumber(1)
  set chatRetentionDays($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatRetentionDays() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatRetentionDays() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
