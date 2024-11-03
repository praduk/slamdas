//
//  Generated code. Do not modify.
//  source: data.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class Cartesian extends $pb.GeneratedMessage {
  factory Cartesian({
    $fixnum.Int64? t,
    $core.double? x,
    $core.double? y,
    $core.double? z,
  }) {
    final $result = create();
    if (t != null) {
      $result.t = t;
    }
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    if (z != null) {
      $result.z = z;
    }
    return $result;
  }
  Cartesian._() : super();
  factory Cartesian.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Cartesian.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Cartesian', package: const $pb.PackageName(_omitMessageNames ? '' : 'praduslam'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 't')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'z', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Cartesian clone() => Cartesian()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Cartesian copyWith(void Function(Cartesian) updates) => super.copyWith((message) => updates(message as Cartesian)) as Cartesian;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Cartesian create() => Cartesian._();
  Cartesian createEmptyInstance() => create();
  static $pb.PbList<Cartesian> createRepeated() => $pb.PbList<Cartesian>();
  @$core.pragma('dart2js:noInline')
  static Cartesian getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Cartesian>(create);
  static Cartesian? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get t => $_getI64(0);
  @$pb.TagNumber(1)
  set t($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasT() => $_has(0);
  @$pb.TagNumber(1)
  void clearT() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get x => $_getN(1);
  @$pb.TagNumber(2)
  set x($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasX() => $_has(1);
  @$pb.TagNumber(2)
  void clearX() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get y => $_getN(2);
  @$pb.TagNumber(3)
  set y($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasY() => $_has(2);
  @$pb.TagNumber(3)
  void clearY() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get z => $_getN(3);
  @$pb.TagNumber(4)
  set z($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasZ() => $_has(3);
  @$pb.TagNumber(4)
  void clearZ() => clearField(4);
}

class Camera extends $pb.GeneratedMessage {
  factory Camera({
    $fixnum.Int64? t,
    $core.List<$core.int>? png,
  }) {
    final $result = create();
    if (t != null) {
      $result.t = t;
    }
    if (png != null) {
      $result.png = png;
    }
    return $result;
  }
  Camera._() : super();
  factory Camera.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Camera.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Camera', package: const $pb.PackageName(_omitMessageNames ? '' : 'praduslam'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 't')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'png', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Camera clone() => Camera()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Camera copyWith(void Function(Camera) updates) => super.copyWith((message) => updates(message as Camera)) as Camera;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Camera create() => Camera._();
  Camera createEmptyInstance() => create();
  static $pb.PbList<Camera> createRepeated() => $pb.PbList<Camera>();
  @$core.pragma('dart2js:noInline')
  static Camera getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Camera>(create);
  static Camera? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get t => $_getI64(0);
  @$pb.TagNumber(1)
  set t($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasT() => $_has(0);
  @$pb.TagNumber(1)
  void clearT() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get png => $_getN(1);
  @$pb.TagNumber(2)
  set png($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPng() => $_has(1);
  @$pb.TagNumber(2)
  void clearPng() => clearField(2);
}

class Recording extends $pb.GeneratedMessage {
  factory Recording({
    $core.Iterable<Cartesian>? gyro,
    $core.Iterable<Cartesian>? accel,
    $core.Iterable<Cartesian>? mag,
    $core.Iterable<Camera>? camera,
  }) {
    final $result = create();
    if (gyro != null) {
      $result.gyro.addAll(gyro);
    }
    if (accel != null) {
      $result.accel.addAll(accel);
    }
    if (mag != null) {
      $result.mag.addAll(mag);
    }
    if (camera != null) {
      $result.camera.addAll(camera);
    }
    return $result;
  }
  Recording._() : super();
  factory Recording.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Recording.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Recording', package: const $pb.PackageName(_omitMessageNames ? '' : 'praduslam'), createEmptyInstance: create)
    ..pc<Cartesian>(1, _omitFieldNames ? '' : 'gyro', $pb.PbFieldType.PM, subBuilder: Cartesian.create)
    ..pc<Cartesian>(2, _omitFieldNames ? '' : 'accel', $pb.PbFieldType.PM, subBuilder: Cartesian.create)
    ..pc<Cartesian>(3, _omitFieldNames ? '' : 'mag', $pb.PbFieldType.PM, subBuilder: Cartesian.create)
    ..pc<Camera>(4, _omitFieldNames ? '' : 'camera', $pb.PbFieldType.PM, subBuilder: Camera.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Recording clone() => Recording()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Recording copyWith(void Function(Recording) updates) => super.copyWith((message) => updates(message as Recording)) as Recording;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Recording create() => Recording._();
  Recording createEmptyInstance() => create();
  static $pb.PbList<Recording> createRepeated() => $pb.PbList<Recording>();
  @$core.pragma('dart2js:noInline')
  static Recording getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Recording>(create);
  static Recording? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Cartesian> get gyro => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<Cartesian> get accel => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<Cartesian> get mag => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<Camera> get camera => $_getList(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
