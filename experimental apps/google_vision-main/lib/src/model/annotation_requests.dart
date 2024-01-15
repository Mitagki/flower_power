import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'annotation_request.dart';

part 'annotation_requests.g.dart';

/// Request for performing Google Cloud Vision API tasks over a user-provided
/// image, with user-requested features, and with context information.
@JsonSerializable(explicitToJson: true)
class AnnotationRequests {
  final List<AnnotationRequest> requests;

  AnnotationRequests({
    required this.requests,
  });

  factory AnnotationRequests.fromJson(Map<String, dynamic> json) =>
      _$AnnotationRequestsFromJson(json);

  Map<String, dynamic> toJson() => _$AnnotationRequestsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
