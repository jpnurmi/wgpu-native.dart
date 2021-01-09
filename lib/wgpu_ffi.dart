library wgpu_ffi;

import 'src/dylib.dart';

int wgpu_get_version() => dylib.wgpu_get_version();
