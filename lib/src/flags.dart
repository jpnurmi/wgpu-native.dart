/// Backends supported by wgpu.
abstract class Backend {
  static const int empty = 0;
  static const int vulkan = 1;
  static const int metal = 2;
  static const int dx12 = 3;
  static const int dx11 = 4;
  static const int gl = 5;
  static const int browserWebGpu = 6;
}

/// Different ways that you can use a buffer.
///
/// The usages determine what kind of memory the buffer is allocated from and what
/// actions the buffer can partake in.
abstract class BufferUsage {
  /// Allow a buffer to be mapped for reading using [`Buffer::map_async`] + [`Buffer::get_mapped_range`].
  /// This does not include creating a buffer with [`BufferDescriptor::mapped_at_creation`] set.
  ///
  /// If [`Features::MAPPABLE_PRIMARY_BUFFERS`] isn't enabled, the only other usage a buffer
  /// may have is COPY_DST.
  static const int mapRead = 1;

  /// Allow a buffer to be mapped for writing using [`Buffer::map_async`] + [`Buffer::get_mapped_range_mut`].
  /// This does not include creating a buffer with `mapped_at_creation` set.
  ///
  /// If [`Features::MAPPABLE_PRIMARY_BUFFERS`] feature isn't enabled, the only other usage a buffer
  /// may have is COPY_SRC.
  static const int mapWrite = 2;

  /// Allow a buffer to be the source buffer for a [`CommandEncoder::copy_buffer_to_buffer`] or [`CommandEncoder::copy_buffer_to_texture`]
  /// operation.
  static const int copySrc = 4;

  /// Allow a buffer to be the source buffer for a [`CommandEncoder::copy_buffer_to_buffer`], [`CommandEncoder::copy_buffer_to_texture`],
  /// or [`Queue::write_buffer`] operation.
  static const int copyDst = 8;

  /// Allow a buffer to be the index buffer in a draw operation.
  static const int index = 16;

  /// Allow a buffer to be the vertex buffer in a draw operation.
  static const int vertex = 32;

  /// Allow a buffer to be a [`BindingType::UniformBuffer`] inside a bind group.
  static const int uniform = 64;

  /// Allow a buffer to be a [`BindingType::StorageBuffer`] inside a bind group.
  static const int storage = 128;

  /// Allow a buffer to be the indirect buffer in an indirect draw call.
  static const int indirect = 256;
}

/// Color write mask. Disabled color channels will not be written to.
abstract class ColorWrite {
  /// Enable red channel writes
  static const int red = 1;

  /// Enable green channel writes
  static const int green = 2;

  /// Enable blue channel writes
  static const int blue = 4;

  /// Enable alpha channel writes
  static const int alpha = 8;

  /// Enable red, green, and blue channel writes
  static const int color = 7;

  /// Enable writes to all channels.
  static const int all = 15;
}

/// Features that are not guaranteed to be supported.
///
/// These are either part of the webgpu standard, or are extension features supported by
/// wgpu when targeting native.
///
/// If you want to use a feature, you need to first verify that the adapter supports
/// the feature. If the adapter does not support the feature, requesting a device with it enabled
/// will panic.
abstract class Features {
  /// Webgpu only allows the MAP_READ and MAP_WRITE buffer usage to be matched with
  /// COPY_DST and COPY_SRC respectively. This removes this requirement.
  ///
  /// This is only beneficial on systems that share memory between CPU and GPU. If enabled
  /// on a system that doesn't, this can severely hinder performance. Only use if you understand
  /// the consequences.
  ///
  /// Supported platforms:
  /// - All
  ///
  /// This is a native only feature.
  static const int MAPPABLE_PRIMARY_BUFFERS = 65536;

  /// Allows the user to create uniform arrays of sampled textures in shaders:
  ///
  /// eg. `uniform texture2D textures[10]`.
  ///
  /// This capability allows them to exist and to be indexed by compile time constant
  /// values.
  ///
  /// Supported platforms:
  /// - DX12
  /// - Metal (with MSL 2.0+ on macOS 10.13+)
  /// - Vulkan
  ///
  /// This is a native only feature.
  static const int SAMPLED_TEXTURE_BINDING_ARRAY = 131072;

  /// Allows shaders to index sampled texture arrays with dynamically uniform values:
  ///
  /// eg. `texture_array[uniform_value]`
  ///
  /// This capability means the hardware will also support SAMPLED_TEXTURE_BINDING_ARRAY.
  ///
  /// Supported platforms:
  /// - DX12
  /// - Metal (with MSL 2.0+ on macOS 10.13+)
  /// - Vulkan's shaderSampledImageArrayDynamicIndexing feature
  ///
  /// This is a native only feature.
  static const int SAMPLED_TEXTURE_ARRAY_DYNAMIC_INDEXING = 262144;

  /// Allows shaders to index sampled texture arrays with dynamically non-uniform values:
  ///
  /// eg. `texture_array[vertex_data]`
  ///
  /// In order to use this capability, the corresponding GLSL extension must be enabled like so:
  ///
  /// `#extension GL_EXT_nonuniform_qualifier : require`
  ///
  /// HLSL does not need any extension.
  ///
  /// This capability means the hardware will also support SAMPLED_TEXTURE_ARRAY_DYNAMIC_INDEXING
  /// and SAMPLED_TEXTURE_BINDING_ARRAY.
  ///
  /// Supported platforms:
  /// - DX12
  /// - Metal (with MSL 2.0+ on macOS 10.13+)
  /// - Vulkan 1.2+ (or VK_EXT_descriptor_indexing)'s shaderSampledImageArrayNonUniformIndexing feature)
  ///
  /// This is a native only feature.
  static const int SAMPLED_TEXTURE_ARRAY_NON_UNIFORM_INDEXING = 524288;

  /// Allows the user to create unsized uniform arrays of bindings:
  ///
  /// eg. `uniform texture2D textures[]`.
  ///
  /// If this capability is supported, SAMPLED_TEXTURE_ARRAY_NON_UNIFORM_INDEXING is very likely
  /// to also be supported
  ///
  /// Supported platforms:
  /// - DX12
  /// - Vulkan 1.2+ (or VK_EXT_descriptor_indexing)'s runtimeDescriptorArray feature
  ///
  /// This is a native only feature.
  static const int UNSIZED_BINDING_ARRAY = 1048576;

  /// Allows the user to call [`RenderPass::multi_draw_indirect`] and [`RenderPass::multi_draw_indexed_indirect`].
  ///
  /// Allows multiple indirect calls to be dispatched from a single buffer.
  ///
  /// Supported platforms:
  /// - DX12
  /// - Metal
  /// - Vulkan
  ///
  /// This is a native only feature.
  static const int MULTI_DRAW_INDIRECT = 2097152;

  /// Allows the user to call [`RenderPass::multi_draw_indirect_count`] and [`RenderPass::multi_draw_indexed_indirect_count`].
  ///
  /// This allows the use of a buffer containing the actual number of draw calls.
  ///
  /// Supported platforms:
  /// - DX12
  /// - Vulkan 1.2+ (or VK_KHR_draw_indirect_count)
  ///
  /// This is a native only feature.
  static const int MULTI_DRAW_INDIRECT_COUNT = 4194304;

  /// Features which are part of the upstream webgpu standard
  static const int ALL_WEBGPU = 65535;

  /// Features that require activating the unsafe feature flag
  // ### TODO: static const BigInt ALL_UNSAFE = 18446462598732840960;

  /// Features that are only available when targeting native (not web)
  // ### TODO: static const BigInt ALL_NATIVE = 18446744073709486080;
}

/// Describes the shader stages that a binding will be visible from.
///
/// These can be combined so something that is visible from both vertex and fragment shaders can be defined as:
///
/// `ShaderStage.vertex | ShaderStage.fragment`
abstract class ShaderStage {
  /// Binding is not visible from any shader stage
  static const int none = 0;

  /// Binding is visible from the vertex shader of a render pipeline
  static const int vertex = 1;

  /// Binding is visible from the fragment shader of a render pipeline
  static const int fragment = 2;

  /// Binding is visible from the compute shader of a compute pipeline
  static const int compute = 4;
}

/// Different ways that you can use a texture.
///
/// The usages determine what kind of memory the texture is allocated from and what
/// actions the texture can partake in.
abstract class TextureUsage {
  /// Allows a texture to be the source in a [`CommandEncoder::copy_texture_to_buffer`] or
  /// [`CommandEncoder::copy_texture_to_texture`] operation.
  static const int copySrc = 1;

  /// Allows a texture to be the destination in a  [`CommandEncoder::copy_texture_to_buffer`],
  /// [`CommandEncoder::copy_texture_to_texture`], or [`Queue::write_texture`] operation.
  static const int copyDst = 2;

  /// Allows a texture to be a [`BindingType::SampledTexture`] in a bind group.
  static const int sampled = 4;

  /// Allows a texture to be a [`BindingType::StorageTexture`] in a bind group.
  static const int storage = 8;

  /// Allows a texture to be a output attachment of a renderpass.
  static const int outputAttachment = 16;
}
