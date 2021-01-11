import 'dart:ffi' as ffi;

import 'package:dylib/dylib.dart';

import 'bindings.dart';

LibWGPU? _dylib;
LibWGPU get dylib {
  return _dylib ??= LibWGPU(ffi.DynamicLibrary.open(
    resolveDylibPath(
      'wgpu_native',
      dartDefine: 'LIBWGPU_PATH',
      environmentVariable: 'LIBWGPU_PATH',
    ),
  ));
}
