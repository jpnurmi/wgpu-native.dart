import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart' as ffi;

import 'bindings.dart';
import 'callbacks.dart';
import 'dylib.dart';
import 'enums.dart';
import 'types.dart';

void wgpu_adapter_destroy(int adapter_id) {
  dylib.wgpu_adapter_destroy(adapter_id);
}

int wgpu_adapter_features(int adapter_id) {
  return dylib.wgpu_adapter_features(adapter_id);
}

/// Fills the given `info` struct with the adapter info.
///
/// # Safety
///
/// The field `info.name` is expected to point to a pre-allocated memory
/// location. This function is unsafe as there is no guarantee that the
/// pointer is valid and big enough to hold the adapter name.
CAdapterInfo wgpu_adapter_get_info(int adapter_id) {
  final ptr = ffi.allocate<WGPUCAdapterInfo>(); // ### TODO: dispose
  dylib.wgpu_adapter_get_info(adapter_id, ptr);
  return CAdapterInfo.fromNative(ptr);
}

CLimits wgpu_adapter_limits(int adapter_id) {
  final limits = dylib.wgpu_adapter_limits(adapter_id);
  return CLimits.fromNative(limits.addressOf); // ### TODO: temporary
}

int wgpu_adapter_request_device(
  int adapter_id,
  int features,
  CLimits limits,
  bool sharedValidation,
  String tracePath,
) {
  final cstr = ffi.Utf8.toUtf8(tracePath);
  final device = dylib.wgpu_adapter_request_device(
    adapter_id,
    features,
    limits.toNative(),
    sharedValidation,
    cstr.cast(),
  );
  ffi.free(cstr);
  return device;
}

void wgpu_bind_group_destroy(int bind_group_id) {
  dylib.wgpu_bind_group_destroy(bind_group_id);
}

void wgpu_bind_group_layout_destroy(int bind_group_layout_id) {
  dylib.wgpu_bind_group_destroy(bind_group_layout_id);
}

void wgpu_buffer_destroy(int buffer_id) {
  dylib.wgpu_buffer_destroy(buffer_id);
}

Uint8List wgpu_buffer_get_mapped_range(
  int buffer_id,
  int start,
  int size,
) {
  final array = dylib.wgpu_buffer_get_mapped_range(buffer_id, start, size);

  // ### TODO: length?
  var len = 0;
  while (array.elementAt(len) != ffi.nullptr) {
    ++len;
  }

  return dylib
      .wgpu_buffer_get_mapped_range(buffer_id, start, size)
      .asTypedList(len);
}

void wgpu_buffer_map_read_async(
  int buffer_id,
  int start,
  int size,
  BufferMapCallback callback,
) {
  void _callback(int status, ffi.Pointer<ffi.Uint8> user_data) {
    callback.call(BufferMapAsyncStatus.values[status]);
  }

  dylib.wgpu_buffer_map_write_async(
    buffer_id,
    start,
    size,
    ffi.Pointer.fromFunction(_callback),
    ffi.nullptr,
  );
}

void wgpu_buffer_unmap(int buffer_id) {
  dylib.wgpu_buffer_unmap(buffer_id);
}

void wgpu_command_buffer_destroy(int command_buffer_id) {
  dylib.wgpu_command_buffer_destroy(command_buffer_id);
}

/// # Safety
///
/// This function is unsafe because improper use may lead to memory
/// problems. For example, a double-free may occur if the function is called
/// twice on the same raw pointer.
ComputePass wgpu_command_encoder_begin_compute_pass(
  int encoder_id,
  ComputePassDescriptor desc,
) {
  final ptr = dylib.wgpu_command_encoder_begin_compute_pass(
    encoder_id,
    desc.toNative(),
  );
  return ComputePass.fromNative(ptr);
}

/// # Safety
///
/// This function is unsafe because improper use may lead to memory
/// problems. For example, a double-free may occur if the function is called
/// twice on the same raw pointer.
RenderPass wgpu_command_encoder_begin_render_pass(
  int encoder_id,
  RenderPassDescriptor desc,
) {
  final ptr = dylib.wgpu_command_encoder_begin_render_pass(
    encoder_id,
    desc.toNative(),
  );
  return RenderPass.fromNative(ptr);
}

void wgpu_command_encoder_copy_buffer_to_buffer(
  int command_encoder_id,
  int source,
  int source_offset,
  int destination,
  int destination_offset,
  int size,
) {
  dylib.wgpu_command_encoder_copy_buffer_to_buffer(
    command_encoder_id,
    source,
    source_offset,
    destination,
    destination_offset,
    size,
  );
}

void wgpu_command_encoder_copy_buffer_to_texture(
  int command_encoder_id,
  BufferCopyView source,
  TextureCopyView destination,
  Extent3D copy_size,
) {
  dylib.wgpu_command_encoder_copy_buffer_to_texture(
    command_encoder_id,
    source.toNative(),
    destination.toNative(),
    copy_size.toNative(),
  );
}

void wgpu_command_encoder_copy_texture_to_buffer(
  int command_encoder_id,
  TextureCopyView source,
  BufferCopyView destination,
  Extent3D copy_size,
) {
  dylib.wgpu_command_encoder_copy_texture_to_buffer(
    command_encoder_id,
    source.toNative(),
    destination.toNative(),
    copy_size.toNative(),
  );
}

void wgpu_command_encoder_copy_texture_to_texture(
  int command_encoder_id,
  TextureCopyView source,
  TextureCopyView destination,
  Extent3D copy_size,
) {
  dylib.wgpu_command_encoder_copy_texture_to_texture(
    command_encoder_id,
    source.toNative(),
    destination.toNative(),
    copy_size.toNative(),
  );
}

void wgpu_command_encoder_destroy(int command_encoder_id) {
  dylib.wgpu_command_encoder_destroy(command_encoder_id);
}

int wgpu_command_encoder_finish(int encoder_id, CommandBufferDescriptor desc) {
  return dylib.wgpu_command_encoder_finish(encoder_id, desc.toNative());
}

void wgpu_compute_pass_destroy(ComputePass pass) {
  dylib.wgpu_compute_pass_destroy(pass.toNative());
}

void wgpu_compute_pass_dispatch(
  ComputePass pass,
  int groups_x,
  int groups_y,
  int groups_z,
) {
  dylib.wgpu_compute_pass_dispatch(
    pass.toNative(),
    groups_x,
    groups_y,
    groups_z,
  );
}

void wgpu_compute_pass_dispatch_indirect(
  ComputePass pass,
  int buffer_id,
  int offset,
) {
  dylib.wgpu_compute_pass_dispatch_indirect(
    pass.toNative(),
    buffer_id,
    offset,
  );
}

void wgpu_compute_pass_end_pass(ComputePass pass) {
  dylib.wgpu_compute_pass_end_pass(pass.toNative());
}

void wgpu_compute_pass_insert_debug_marker(
  ComputePass pass,
  String label,
  int color,
) {
  final cstr = ffi.Utf8.toUtf8(label);
  dylib.wgpu_compute_pass_insert_debug_marker(
    pass.toNative(),
    cstr.cast(),
    color,
  );
  ffi.free(cstr);
}

void wgpu_compute_pass_pop_debug_group(ComputePass pass) {
  dylib.wgpu_compute_pass_pop_debug_group(pass.toNative());
}

void wgpu_compute_pass_push_debug_group(
  ComputePass pass,
  String label,
  int color,
) {
  final cstr = ffi.Utf8.toUtf8(label);
  dylib.wgpu_compute_pass_push_debug_group(
    pass.toNative(),
    cstr.cast(),
    color,
  );
  ffi.free(cstr);
}

/// # Safety
///
/// This function is unsafe as there is no guarantee that the given pointer is
/// valid for `offset_length` elements.
void wgpu_compute_pass_set_bind_group(
  ComputePass pass,
  int index,
  int bind_group_id,
  Uint32List offsets,
) {
  // ### TODO: avoid copy... (https://github.com/dart-lang/ffi/issues/31)
  final array = ffi.allocate<ffi.Uint32>(count: offsets.length);
  array.asTypedList(offsets.length).setAll(0, offsets);

  dylib.wgpu_compute_pass_set_bind_group(
    pass.toNative(),
    index,
    bind_group_id,
    array,
    offsets.length,
  );

  ffi.free(array);
}

void wgpu_compute_pass_set_pipeline(ComputePass pass, int pipeline_id) {
  dylib.wgpu_compute_pass_set_pipeline(pass.toNative(), pipeline_id);
}

void wgpu_compute_pipeline_destroy(int compute_pipeline_id) {
  dylib.wgpu_compute_pipeline_destroy(compute_pipeline_id);
}

// int wgpu_create_surface_from_android(
//   ffi.Pointer<ffi.Void> a_native_window,
// ) {
// }

// int wgpu_create_surface_from_metal_layer(
//   ffi.Pointer<ffi.Void> layer,
// ) {
// }

// int wgpu_create_surface_from_wayland(
//   ffi.Pointer<ffi.Void> surface,
//   ffi.Pointer<ffi.Void> display,
// ) {
// }

// int wgpu_create_surface_from_windows_hwnd(
//   ffi.Pointer<ffi.Void> _hinstance,
//   ffi.Pointer<ffi.Void> hwnd,
// ) {
// }

// int wgpu_create_surface_from_xlib(
//   ffi.Pointer<ffi.Pointer<ffi.Void>> display,
//   int window,
// ) {
// }

int wgpu_device_create_bind_group(int device_id, BindGroupDescriptor desc) {
  return dylib.wgpu_device_create_bind_group(device_id, desc.toNative());
}

int wgpu_device_create_bind_group_layout(
  int device_id,
  BindGroupLayoutDescriptor desc,
) {
  return dylib.wgpu_device_create_bind_group_layout(device_id, desc.toNative());
}

int wgpu_device_create_buffer(int device_id, BufferDescriptor desc) {
  return dylib.wgpu_device_create_buffer(device_id, desc.toNative());
}

int wgpu_device_create_command_encoder(
  int device_id,
  CommandEncoderDescriptor desc,
) {
  return dylib.wgpu_device_create_command_encoder(device_id, desc.toNative());
}

int wgpu_device_create_compute_pipeline(
  int device_id,
  ComputePipelineDescriptor desc,
) {
  return dylib.wgpu_device_create_compute_pipeline(device_id, desc.toNative());
}

int wgpu_device_create_pipeline_layout(
  int device_id,
  PipelineLayoutDescriptor desc,
) {
  return dylib.wgpu_device_create_pipeline_layout(device_id, desc.toNative());
}

RenderBundleEncoder wgpu_device_create_render_bundle_encoder(
  int device_id,
  RenderBundleEncoderDescriptor desc,
) {
  final ptr = dylib.wgpu_device_create_render_bundle_encoder(
    device_id,
    desc.toNative(),
  );
  return RenderBundleEncoder.fromNative(ptr);
}

int wgpu_device_create_render_pipeline(
  int device_id,
  RenderPipelineDescriptor desc,
) {
  return dylib.wgpu_device_create_render_pipeline(
    device_id,
    desc.toNative(),
  );
}

int wgpu_device_create_sampler(int device_id, SamplerDescriptor desc) {
  return dylib.wgpu_device_create_sampler(device_id, desc.toNative());
}

int wgpu_device_create_shader_module(
  int device_id,
  ShaderSource source,
) {
  return dylib.wgpu_device_create_shader_module(
    device_id,
    source.toNative().ref,
  );
}

int wgpu_device_create_swap_chain(
  int device_id,
  int surface_id,
  SwapChainDescriptor desc,
) {
  return dylib.wgpu_device_create_swap_chain(
    device_id,
    surface_id,
    desc.toNative(),
  );
}

int wgpu_device_create_texture(int device_id, TextureDescriptor desc) {
  return dylib.wgpu_device_create_texture(device_id, desc.toNative());
}

void wgpu_device_destroy(int device_id) {
  dylib.wgpu_device_destroy(device_id);
}

int wgpu_device_features(int device_id) {
  return dylib.wgpu_device_features(device_id);
}

int wgpu_device_get_default_queue(int device_id) {
  return dylib.wgpu_device_get_default_queue(device_id);
}

CLimits wgpu_device_limits(int device_id) {
  final limits = dylib.wgpu_device_limits(device_id);
  return CLimits.fromNative(limits.addressOf); // ### TODO: temporary
}

void wgpu_device_poll(int device_id, bool force_wait) {
  dylib.wgpu_device_poll(device_id, force_wait);
}

int wgpu_get_version() => dylib.wgpu_get_version();

void wgpu_pipeline_layout_destroy(int pipeline_layout_id) {
  dylib.wgpu_pipeline_layout_destroy(pipeline_layout_id);
}

/// # Safety
///
/// This function is unsafe as there is no guarantee that the given `command_buffers`
/// pointer is valid for `command_buffers_length` elements.
void wgpu_queue_submit(
  int queue_id,
  Uint64List command_buffers,
) {
  // ### TODO: avoid copy... (https://github.com/dart-lang/ffi/issues/31)
  final array = ffi.allocate<ffi.Uint64>(count: command_buffers.length);
  array.asTypedList(command_buffers.length).setAll(0, command_buffers);

  dylib.wgpu_queue_submit(
    queue_id,
    array,
    command_buffers.length,
  );

  ffi.free(array);
}

/// # Safety
///
/// This function is unsafe as there is no guarantee that the given `data`
/// pointer is valid for `data_length` elements.
void wgpu_queue_write_buffer(
  int queue_id,
  int buffer_id,
  int buffer_offset,
  Uint8List data,
) {
  // ### TODO: avoid copy...
  // https://github.com/dart-lang/ffi/issues/31
  final array = ffi.allocate<ffi.Uint8>(count: data.length);
  array.asTypedList(data.length).setAll(0, data);

  dylib.wgpu_queue_write_buffer(
    queue_id,
    buffer_id,
    buffer_offset,
    array,
    data.length,
  );

  ffi.free(array);
}

/// # Safety
///
/// This function is unsafe as there is no guarantee that the given `data`
/// pointer is valid for `data_length` elements.
void wgpu_queue_write_texture(
  int queue_id,
  TextureCopyView texture,
  Uint8List data,
  TextureDataLayout data_layout,
  Extent3D size,
) {
  // ### TODO: avoid copy... (https://github.com/dart-lang/ffi/issues/31)
  final array = ffi.allocate<ffi.Uint8>(count: data.length);
  array.asTypedList(data.length).setAll(0, data);

  dylib.wgpu_queue_write_texture(
    queue_id,
    texture.toNative(),
    array,
    data.length,
    data_layout.toNative(),
    size.toNative(),
  );

  ffi.free(array);
}

void wgpu_render_bundle_destroy(int render_bundle_id) {
  dylib.wgpu_render_bundle_destroy(render_bundle_id);
}

void wgpu_render_bundle_draw(
  RenderBundleEncoder bundle,
  int vertex_count,
  int instance_count,
  int first_vertex,
  int first_instance,
) {
  dylib.wgpu_render_bundle_draw(
    bundle.toNative(),
    vertex_count,
    instance_count,
    first_vertex,
    first_instance,
  );
}

void wgpu_render_bundle_draw_indexed(
  RenderBundleEncoder bundle,
  int index_count,
  int instance_count,
  int first_index,
  int base_vertex,
  int first_instance,
) {
  dylib.wgpu_render_bundle_draw_indexed(
    bundle.toNative(),
    index_count,
    instance_count,
    first_index,
    base_vertex,
    first_instance,
  );
}

void wgpu_render_bundle_draw_indirect(
  RenderBundleEncoder bundle,
  int buffer_id,
  int offset,
) {
  dylib.wgpu_render_bundle_draw_indirect(bundle.toNative(), buffer_id, offset);
}

int wgpu_render_bundle_encoder_finish(
  RenderBundleEncoder bundle_encoder_id,
  String label,
) {
  final cstr = ffi.Utf8.toUtf8(label);
  final ret = dylib.wgpu_render_bundle_encoder_finish(
    bundle_encoder_id.toNative(),
    cstr.cast(),
  );
  ffi.free(cstr);
  return ret;
}

void wgpu_render_bundle_insert_debug_marker(
  RenderBundleEncoder bundle,
  String label,
) {
  final cstr = ffi.Utf8.toUtf8(label);
  dylib.wgpu_render_bundle_insert_debug_marker(bundle.toNative(), cstr.cast());
  ffi.free(cstr);
}

void wgpu_render_bundle_pop_debug_group(RenderBundleEncoder bundle) {
  dylib.wgpu_render_bundle_pop_debug_group(bundle.toNative());
}

void wgpu_render_bundle_push_debug_group(
  RenderBundleEncoder bundle,
  String label,
) {
  final cstr = ffi.Utf8.toUtf8(label);
  dylib.wgpu_render_bundle_push_debug_group(bundle.toNative(), cstr.cast());
  ffi.free(cstr);
}

/// # Safety
///
/// This function is unsafe as there is no guarantee that the given pointer is
/// valid for `offset_length` elements.
void wgpu_render_bundle_set_bind_group(
  RenderBundleEncoder bundle,
  int index,
  int bind_group_id,
  Uint32List offsets,
) {
  // ### TODO: avoid copy... (https://github.com/dart-lang/ffi/issues/31)
  final array = ffi.allocate<ffi.Uint32>(count: offsets.length);
  array.asTypedList(offsets.length).setAll(0, offsets);

  dylib.wgpu_render_bundle_set_bind_group(
    bundle.toNative(),
    index,
    bind_group_id,
    array,
    offsets.length,
  );

  ffi.free(array);
}

void wgpu_render_bundle_set_index_buffer(
  RenderBundleEncoder bundle,
  int buffer_id,
  int offset,
  Option_BufferSize size,
) {
  dylib.wgpu_render_bundle_set_index_buffer(
    bundle.toNative(),
    buffer_id,
    offset,
    size.toNative().ref,
  );
}

void wgpu_render_bundle_set_pipeline(
  RenderBundleEncoder bundle,
  int pipeline_id,
) {
  dylib.wgpu_render_bundle_set_pipeline(bundle.toNative(), pipeline_id);
}

void wgpu_render_bundle_set_vertex_buffer(
  RenderBundleEncoder bundle,
  int slot,
  int buffer_id,
  int offset,
  Option_BufferSize size,
) {
  dylib.wgpu_render_bundle_set_vertex_buffer(
    bundle.toNative(),
    slot,
    buffer_id,
    offset,
    size.toNative().ref,
  );
}

void wgpu_render_pass_bundle_indexed_indirect(
  RenderBundleEncoder bundle,
  int buffer_id,
  int offset,
) {
  dylib.wgpu_render_pass_bundle_indexed_indirect(
    bundle.toNative(),
    buffer_id,
    offset,
  );
}

void wgpu_render_pass_destroy(RenderPass pass) {
  dylib.wgpu_render_pass_destroy(pass.toNative());
}

void wgpu_render_pass_draw(
  RenderPass pass,
  int vertex_count,
  int instance_count,
  int first_vertex,
  int first_instance,
) {
  dylib.wgpu_render_pass_draw(
    pass.toNative(),
    vertex_count,
    instance_count,
    first_vertex,
    first_instance,
  );
}

void wgpu_render_pass_draw_indexed(
  RenderPass pass,
  int index_count,
  int instance_count,
  int first_index,
  int base_vertex,
  int first_instance,
) {
  dylib.wgpu_render_pass_draw_indexed(
    pass.toNative(),
    index_count,
    instance_count,
    first_index,
    base_vertex,
    first_instance,
  );
}

void wgpu_render_pass_draw_indexed_indirect(
  RenderPass pass,
  int buffer_id,
  int offset,
) {
  dylib.wgpu_render_pass_draw_indexed_indirect(
    pass.toNative(),
    buffer_id,
    offset,
  );
}

void wgpu_render_pass_draw_indirect(
  RenderPass pass,
  int buffer_id,
  int offset,
) {
  dylib.wgpu_render_pass_draw_indirect(pass.toNative(), buffer_id, offset);
}

/// # Safety
///
/// This function is unsafe because improper use may lead to memory
/// problems. For example, a double-free may occur if the function is called
/// twice on the same raw pointer.
void wgpu_render_pass_end_pass(RenderPass pass) {
  dylib.wgpu_render_pass_end_pass(pass.toNative());
}

void wgpu_render_pass_insert_debug_marker(
  RenderPass pass,
  String label,
  int color,
) {
  final cstr = ffi.Utf8.toUtf8(label);
  dylib.wgpu_render_pass_insert_debug_marker(
    pass.toNative(),
    cstr.cast(),
    color,
  );
  ffi.free(cstr);
}

void wgpu_render_pass_multi_draw_indexed_indirect(
  RenderPass pass,
  int buffer_id,
  int offset,
  int count,
) {
  dylib.wgpu_render_pass_multi_draw_indexed_indirect(
    pass.toNative(),
    buffer_id,
    offset,
    count,
  );
}

void wgpu_render_pass_multi_draw_indexed_indirect_count(
  RenderPass pass,
  int buffer_id,
  int offset,
  int count_buffer_id,
  int count_buffer_offset,
  int max_count,
) {
  dylib.wgpu_render_pass_multi_draw_indexed_indirect_count(
    pass.toNative(),
    buffer_id,
    offset,
    count_buffer_id,
    count_buffer_offset,
    max_count,
  );
}

void wgpu_render_pass_multi_draw_indirect(
  RenderPass pass,
  int buffer_id,
  int offset,
  int count,
) {
  dylib.wgpu_render_pass_multi_draw_indirect(
    pass.toNative(),
    buffer_id,
    offset,
    count,
  );
}

void wgpu_render_pass_multi_draw_indirect_count(
  RenderPass pass,
  int buffer_id,
  int offset,
  int count_buffer_id,
  int count_buffer_offset,
  int max_count,
) {
  dylib.wgpu_render_pass_multi_draw_indirect_count(
    pass.toNative(),
    buffer_id,
    offset,
    count_buffer_id,
    count_buffer_offset,
    max_count,
  );
}

void wgpu_render_pass_pop_debug_group(
  RenderPass pass,
) {
  dylib.wgpu_render_pass_pop_debug_group(pass.toNative());
}

void wgpu_render_pass_push_debug_group(
  RenderPass pass,
  String label,
  int color,
) {
  final cstr = ffi.Utf8.toUtf8(label);
  dylib.wgpu_render_pass_push_debug_group(pass.toNative(), cstr.cast(), color);
  ffi.free(cstr);
}

/// # Safety
///
/// This function is unsafe as there is no guarantee that the given pointer is
/// valid for `offset_length` elements.
void wgpu_render_pass_set_bind_group(
  RenderPass pass,
  int index,
  int bind_group_id,
  Uint32List offsets,
) {
  // ### TODO: avoid copy... (https://github.com/dart-lang/ffi/issues/31)
  final array = ffi.allocate<ffi.Uint32>(count: offsets.length);
  array.asTypedList(offsets.length).setAll(0, offsets);

  dylib.wgpu_render_pass_set_bind_group(
    pass.toNative(),
    index,
    bind_group_id,
    array,
    offsets.length,
  );

  ffi.free(array);
}

void wgpu_render_pass_set_blend_color(RenderPass pass, Color color) {
  dylib.wgpu_render_pass_set_blend_color(pass.toNative(), color.toNative());
}

void wgpu_render_pass_set_index_buffer(
  RenderPass pass,
  int buffer_id,
  int offset,
  Option_BufferSize size,
) {
  dylib.wgpu_render_pass_set_index_buffer(
    pass.toNative(),
    buffer_id,
    offset,
    size.toNative().ref,
  );
}

void wgpu_render_pass_set_pipeline(RenderPass pass, int pipeline_id) {
  dylib.wgpu_render_pass_set_pipeline(pass.toNative(), pipeline_id);
}

void wgpu_render_pass_set_scissor_rect(
  RenderPass pass,
  int x,
  int y,
  int w,
  int h,
) {
  dylib.wgpu_render_pass_set_scissor_rect(pass.toNative(), x, y, w, h);
}

void wgpu_render_pass_set_stencil_reference(RenderPass pass, int value) {
  dylib.wgpu_render_pass_set_stencil_reference(pass.toNative(), value);
}

void wgpu_render_pass_set_vertex_buffer(
  RenderPass pass,
  int slot,
  int buffer_id,
  int offset,
  Option_BufferSize size,
) {
  dylib.wgpu_render_pass_set_vertex_buffer(
    pass.toNative(),
    slot,
    buffer_id,
    offset,
    size.toNative().ref,
  );
}

void wgpu_render_pass_set_viewport(
  RenderPass pass,
  double x,
  double y,
  double w,
  double h,
  double depth_min,
  double depth_max,
) {
  dylib.wgpu_render_pass_set_viewport(
    pass.toNative(),
    x,
    y,
    w,
    h,
    depth_min,
    depth_max,
  );
}

void wgpu_render_pipeline_destroy(int render_pipeline_id) {
  dylib.wgpu_render_pipeline_destroy(render_pipeline_id);
}

/// # Safety
///
/// This function is unsafe as it calls an unsafe extern callback.
void wgpu_request_adapter_async(
  RequestAdapterOptions desc,
  int mask,
  bool allow_unsafe,
  RequestAdapterCallback callback,
) {
  void _callback(int adapter_id, ffi.Pointer<ffi.Void> user_data) {
    callback.call(adapter_id);
  }

  dylib.wgpu_request_adapter_async(
    desc.toNative(),
    mask,
    allow_unsafe,
    ffi.Pointer.fromFunction(_callback),
    ffi.nullptr,
  );
}

void wgpu_sampler_destroy(int sampler_id) {
  dylib.wgpu_sampler_destroy(sampler_id);
}

void wgpu_set_log_callback(LogCallback callback) {
  void _callback(int level, ffi.Pointer<ffi.Int8> cstr) {
    final msg = ffi.Utf8.fromUtf8(cstr.cast());
    callback.call(level, msg);
  }

  dylib.wgpu_set_log_callback(ffi.Pointer.fromFunction(_callback));
}

int wgpu_set_log_level(int level) => dylib.wgpu_set_log_level(level);

void wgpu_shader_module_destroy(int shader_module_id) {
  dylib.wgpu_shader_module_destroy(shader_module_id);
}

SwapChainOutput wgpu_swap_chain_get_next_texture(int swap_chain_id) {
  final ptr = dylib.wgpu_swap_chain_get_next_texture(swap_chain_id);
  return SwapChainOutput.fromNative(ptr.addressOf); // ### TODO: temporary
}

void wgpu_swap_chain_present(int swap_chain_id) {
  dylib.wgpu_swap_chain_present(swap_chain_id);
}

int wgpu_texture_create_view(int texture_id, TextureViewDescriptor desc) {
  return dylib.wgpu_texture_create_view(texture_id, desc.toNative());
}

void wgpu_texture_destroy(int texture_id) {
  dylib.wgpu_texture_destroy(texture_id);
}

void wgpu_texture_view_destroy(int texture_view_id) {
  dylib.wgpu_texture_view_destroy(texture_view_id);
}
