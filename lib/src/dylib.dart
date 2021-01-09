import 'dart:ffi' as ffi;

import 'package:dylib/dylib.dart';

import 'bindings.dart';

LibWGPU? _dylib;
LibWGPU get dylib => _dylib ??= LibWGPU(
    ffi.DynamicLibrary.open(resolveDylibPath('wgpu_native', 'LIBWGPU_PATH')));
