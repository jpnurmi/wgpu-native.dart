import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:dylib/dylib.dart';

import 'bindings.dart';

LibWGPU? _dylib;
LibWGPU get dylib {
  return _dylib ??= LibWGPU(ffi.DynamicLibrary.open(
    resolveDylibPath(
      'wgpu_native',
      path: Directory.current.path,
      dartDefine: 'libwgpu-path',
      environmentVariable: 'LIBWGPU_PATH',
    ),
  ));
}
