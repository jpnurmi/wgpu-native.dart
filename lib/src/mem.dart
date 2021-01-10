import 'dart:ffi';
import 'dart:io';

typedef Memset = Pointer Function(Pointer, int, int);
typedef MemsetC = Pointer Function(Pointer, Uint8, IntPtr);

typedef Memcpy = Pointer Function(Pointer, Pointer, int);
typedef MemcpyC = Pointer Function(Pointer, Pointer, IntPtr);

// Note that kernel32.dll is the correct name in both 32-bit and 64-bit.
final DynamicLibrary stdlib = Platform.isWindows
    ? DynamicLibrary.open('kernel32.dll')
    : DynamicLibrary.process();

Pointer memset(Pointer ptr, int value, int count) {
  final _memset = stdlib.lookupFunction<MemsetC, Memset>('memset');
  return _memset(ptr, value, count);
}

Pointer memcpy(Pointer dst, Pointer src, int count) {
  final _memcpy = stdlib.lookupFunction<MemcpyC, Memcpy>('memcpy');
  return _memcpy(dst, src, count);
}
