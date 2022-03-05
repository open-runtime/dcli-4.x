import 'dart:io';

import '../../dcli_core.dart';

/// Extensions for the Platform class
extension PlatformEx on Platform {
  /// Returns the OS specific End Of Line (eol) character.
  /// On Windows this is '\r\n' on all other platforms
  /// it is '\n'.
  /// Usage: Platform().eol
  ///
  /// Note: you must import both:
  /// ```dart
  /// import 'dart:io';
  /// import 'package:dcli/dcli.dart';
  /// ```
  String get eol => DCliPlatform().isWindows ? '\r\n' : '\n';
}