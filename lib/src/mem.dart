import 'dart:ffi';
import 'dart:io';

typedef Memset = Pointer<Void> Function(Pointer<Void>, int, int);
typedef MemsetC = Pointer<Void> Function(Pointer<Void>, Uint8, IntPtr);

typedef Memcpy = Pointer<Void> Function(Pointer<Void>, Pointer<Void>, int);
typedef MemcpyC = Pointer<Void> Function(Pointer<Void>, Pointer<Void>, IntPtr);

// Note that kernel32.dll is the correct name in both 32-bit and 64-bit.
final DynamicLibrary stdlib = Platform.isWindows
    ? DynamicLibrary.open('kernel32.dll')
    : DynamicLibrary.process();

Pointer<Void> memset(Pointer<Void> ptr, int value, int count) {
  final _memset = stdlib.lookupFunction<MemsetC, Memset>('memset');
  return _memset(ptr, value, count);
}

Pointer<Void> memcpy(Pointer<Void> dst, Pointer<Void> src, int count) {
  final _memcpy = stdlib.lookupFunction<MemcpyC, Memcpy>('memcpy');
  return _memcpy(dst, src, count);
}
