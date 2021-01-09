import 'package:wgpu_ffi/wgpu_ffi.dart';
import 'package:test/test.dart';

void main() {
  group('bindings', () {
    test('wgpu_get_version', () {
      expect(wgpu_get_version(), isPositive);
    });
  });
}
