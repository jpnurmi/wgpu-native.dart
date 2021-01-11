import 'dart:ffi';
import 'dart:io';

typedef Memset = Pointer Function(Pointer, int, int);
typedef MemsetC = Pointer Function(Pointer, Uint8, IntPtr);

typedef Memcpy = Pointer Function(Pointer, Pointer, int);
typedef MemcpyC = Pointer Function(Pointer, Pointer, IntPtr);

typedef Memcmp = int Function(Pointer, Pointer, int);
typedef MemcmpC = Int32 Function(Pointer, Pointer, IntPtr);

// ### TODO: vcruntime dll version & mode (debug vs. release)
final DynamicLibrary stdlib = Platform.isWindows
    ? DynamicLibrary.open('vcruntime140.dll')
    : DynamicLibrary.process();

Pointer memset(Pointer ptr, int value, int count) {
  final _memset = stdlib.lookupFunction<MemsetC, Memset>('memset');
  return _memset(ptr, value, count);
}

Pointer memcpy(Pointer dst, Pointer src, int count) {
  final _memcpy = stdlib.lookupFunction<MemcpyC, Memcpy>('memcpy');
  return _memcpy(dst, src, count);
}

int memcmp(Pointer ptr1, Pointer ptr2, int count) {
  final _memcmp = stdlib.lookupFunction<MemcmpC, Memcmp>('memcmp');
  return _memcmp(ptr1, ptr2, count);
}
