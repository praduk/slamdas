//
//  Generated code. Do not modify.
//  source: data.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use cartesianDescriptor instead')
const Cartesian$json = {
  '1': 'Cartesian',
  '2': [
    {'1': 't', '3': 1, '4': 1, '5': 3, '10': 't'},
    {'1': 'x', '3': 2, '4': 1, '5': 1, '10': 'x'},
    {'1': 'y', '3': 3, '4': 1, '5': 1, '10': 'y'},
    {'1': 'z', '3': 4, '4': 1, '5': 1, '10': 'z'},
  ],
};

/// Descriptor for `Cartesian`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cartesianDescriptor = $convert.base64Decode(
    'CglDYXJ0ZXNpYW4SDAoBdBgBIAEoA1IBdBIMCgF4GAIgASgBUgF4EgwKAXkYAyABKAFSAXkSDA'
    'oBehgEIAEoAVIBeg==');

@$core.Deprecated('Use cameraDescriptor instead')
const Camera$json = {
  '1': 'Camera',
  '2': [
    {'1': 't', '3': 1, '4': 1, '5': 3, '10': 't'},
    {'1': 'png', '3': 2, '4': 1, '5': 12, '10': 'png'},
  ],
};

/// Descriptor for `Camera`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraDescriptor = $convert.base64Decode(
    'CgZDYW1lcmESDAoBdBgBIAEoA1IBdBIQCgNwbmcYAiABKAxSA3BuZw==');

@$core.Deprecated('Use recordingDescriptor instead')
const Recording$json = {
  '1': 'Recording',
  '2': [
    {'1': 'gyro', '3': 1, '4': 3, '5': 11, '6': '.praduslam.Cartesian', '10': 'gyro'},
    {'1': 'accel', '3': 2, '4': 3, '5': 11, '6': '.praduslam.Cartesian', '10': 'accel'},
    {'1': 'mag', '3': 3, '4': 3, '5': 11, '6': '.praduslam.Cartesian', '10': 'mag'},
    {'1': 'camera', '3': 4, '4': 3, '5': 11, '6': '.praduslam.Camera', '10': 'camera'},
  ],
};

/// Descriptor for `Recording`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordingDescriptor = $convert.base64Decode(
    'CglSZWNvcmRpbmcSKAoEZ3lybxgBIAMoCzIULnByYWR1c2xhbS5DYXJ0ZXNpYW5SBGd5cm8SKg'
    'oFYWNjZWwYAiADKAsyFC5wcmFkdXNsYW0uQ2FydGVzaWFuUgVhY2NlbBImCgNtYWcYAyADKAsy'
    'FC5wcmFkdXNsYW0uQ2FydGVzaWFuUgNtYWcSKQoGY2FtZXJhGAQgAygLMhEucHJhZHVzbGFtLk'
    'NhbWVyYVIGY2FtZXJh');

