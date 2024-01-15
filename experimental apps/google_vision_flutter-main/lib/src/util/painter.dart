import 'dart:convert';
import 'dart:typed_data';

import 'package:color/color.dart';
import 'package:google_vision/google_vision.dart' show SerializableImage;
import 'package:image/image.dart' as img;
import 'package:universal_io/io.dart';

/// The Painter class represents the space by which a supplied image can be
/// modified.
class Painter extends SerializableImage {
  final Uint8List encodedBytes;

  final String content;

  img.Image? _decodedBytes;

  Painter(this.encodedBytes)
      : content = base64Encode(encodedBytes),
        _decodedBytes = img.decodeImage(encodedBytes);

  int get height => _decodedBytes!.height;

  int get width => _decodedBytes!.width;

  factory Painter.fromFilePath(String filePath) =>
      Painter.fromFile(File(filePath));

  factory Painter.fromFile(File imageFile) =>
      Painter(imageFile.readAsBytesSync());

  factory Painter.fromDecodedImage(img.Image image) =>
      Painter(Uint8List.fromList(img.encodeJpg(image).toList()));

  factory Painter.fromBase64(String encodedImage) =>
      Painter(base64Decode(encodedImage));

  factory Painter.fromJson(Map<String, dynamic> json) =>
      Painter.fromBase64(json['content'] as String);

  @override
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'content': base64Encode(encodedBytes)};

  /// Draw a rectangle on the underlying image.
  void drawRectangle(int x1, int y1, int x2, int y2, String color,
      {num thickness = 1}) {
    img.drawRect(
      _decodedBytes!,
      x1: x1,
      y1: y1,
      x2: x2,
      y2: y2,
      color: _toRgbColor(RgbColor.name(color)),
    );
  }

  /// Draw a line on the underlying image.
  void drawLine(int x1, int y1, int x2, int y2, String color,
      {bool antialias = false, num thickness = 1}) {
    img.drawLine(
      _decodedBytes!,
      x1: x1,
      y1: y1,
      x2: x2,
      y2: x2,
      color: _toRgbColor(RgbColor.name(color)),
    );
  }

  /// Draw text on the underlying image.
  void drawString(int x, int y, String text, String color) {
    img.drawString(
      _decodedBytes!,
      text,
      font: img.arial14,
      x: x,
      y: y,
      color: _toRgbColor(RgbColor.name(color)),
    );
  }

  /// Crop the underlying image.
  Painter copyCrop(int x, int y, int w, int h) => Painter.fromDecodedImage(
        img.copyCrop(
          _decodedBytes!,
          x: x,
          y: y,
          width: w,
          height: h,
        ),
      );

  /// Write the image as a jpeg to the specified destination.
  Future<void> writeAsJpeg(String filePath) async =>
      File(filePath).writeAsBytes(img.encodeJpg(_decodedBytes!));

  @override
  String toString() => jsonEncode(toJson());

  img.ColorRgb8 _toRgbColor(Color color) => img.ColorRgb8(
        color.toRgbColor().r as int,
        color.toRgbColor().g as int,
        color.toRgbColor().b as int,
      );
}