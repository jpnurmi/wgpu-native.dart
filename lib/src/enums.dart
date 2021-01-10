/// How edges should be handled in texture addressing.
enum AddressMode {
  /// Clamp the value to the edge of the texture
  ///
  /// -0.25 -> 0.0
  /// 1.25  -> 1.0
  clampToEdge,

  /// Repeat the texture in a tiling fashion
  ///
  /// -0.25 -> 0.75
  /// 1.25 -> 0.25
  repeat,

  /// Repeat the texture, mirroring it every repeat
  ///
  /// -0.25 -> 0.25
  /// 1.25 -> 0.75
  mirrorRepeat,
}

enum BindingType {
  uniformBuffer,
  storageBuffer,
  readonlyStorageBuffer,
  sampler,
  comparisonSampler,
  sampledTexture,
  readonlyStorageTexture,
  writeonlyStorageTexture
}

/// Alpha blend factor.
///
/// Alpha blending is very complicated: see the OpenGL or Vulkan spec for more information.
enum BlendFactor {
  zero,
  one,
  srcColor,
  oneMinusSrcColor,
  srcAlpha,
  oneMinusSrcAlpha,
  dstColor,
  oneMinusDstColor,
  dstAlpha,
  oneMinusDstAlpha,
  srcAlphaSaturated,
  blendColor,
  oneMinusBlendColor,
}

/// Alpha blend operation.
///
/// Alpha blending is very complicated: see the OpenGL or Vulkan spec for more information.
enum BlendOperation {
  add,
  subtract,
  reverseSubtract,
  min,
  max,
}

enum BufferMapAsyncStatus {
  success,
  error,
  unknown,
  contextLost,
}

enum DeviceType {
  /// Other.
  other,

  /// Integrated GPU with shared CPU/GPU memory.
  integratedGpu,

  /// Discrete GPU with separate CPU/GPU memory.
  discreteGpu,

  /// Virtual / Hosted.
  virtualGpu,

  /// CPU / Software Rendering.
  cpu
}

/// Comparison function used for depth and stencil operations.
enum CompareFunction {
  /// Invalid value, do not use
  undefined,

  /// Function never passes
  never,

  /// Function passes if new value less than existing value
  less,

  /// Function passes if new value is equal to existing value
  equal,

  /// Function passes if new value is less than or equal to existing value
  lessEqual,

  /// Function passes if new value is greater than existing value
  greater,

  /// Function passes if new value is not equal to existing value
  notEqual,

  /// Function passes if new value is greater than or equal to existing value
  greaterEqual,

  /// Function always passes
  always,
}

/// Type of faces to be culled.
enum CullMode {
  /// No faces should be culled
  none,

  /// Front faces should be culled
  front,

  /// Back faces should be culled
  back,
}

/// Texel mixing mode when sampling between texels.
enum FilterMode {
  /// Nearest neighbor sampling.
  ///
  /// This creates a pixelated effect when used as a mag filter
  nearest,

  /// Linear Interpolation
  ///
  /// This makes textures smooth but blurry when used as a mag filter.
  linear,
}

/// Winding order which classifies the "front" face.
enum FrontFace {
  /// Triangles with vertices in counter clockwise order are considered the front face.
  ///
  /// This is the default with right handed coordinate spaces.
  ccw,

  /// Triangles with vertices in clockwise order are considered the front face.
  ///
  /// This is the default with left handed coordinate spaces.
  cw,
}

/// Format of indices used with pipeline.
enum IndexFormat {
  /// Indices are 16 bit unsigned integers.
  uint16,

  /// Indices are 32 bit unsigned integers.
  uint32,
}

/// Rate that determines when vertex data is advanced.
enum InputStepMode {
  /// Input data is advanced every vertex. This is the standard value for vertex data.
  vertex,

  /// Input data is advanced every instance.
  instance,
}

/// Operation to perform to the output attachment at the start of a renderpass.
enum LoadOp {
  /// Clear the output attachment with the clear color. Clearing is faster than loading.
  clear,

  /// Do not clear output attachment.
  load,
}

enum LogLevel {
  off,
  error,
  warn,
  info,
  debug,
  trace,
}

/// Power Preference when choosing a physical adapter.
enum PowerPreference {
  /// Prefer low power when on battery, high performance when on mains.
  defaultPower,

  /// Adapter that uses the least possible power. This is often an integerated GPU.
  lowPower,

  /// Adapter that has the highest performance. This is often a discrete GPU.
  highPerformance,
}

/// Behavior of the presentation engine based on frame rate.
enum PresentMode {
  /// The presentation engine does **not** wait for a vertical blanking period and
  /// the request is presented immediately. This is a low-latency presentation mode,
  /// but visible tearing may be observed. Will fallback to `Fifo` if unavailable on the
  /// selected  platform and backend. Not optimal for mobile.
  immediate,

  /// The presentation engine waits for the next vertical blanking period to update
  /// the current image, but frames may be submitted without delay. This is a low-latency
  /// presentation mode and visible tearing will **not** be observed. Will fallback to `Fifo`
  /// if unavailable on the selected platform and backend. Not optimal for mobile.
  mailbox,

  /// The presentation engine waits for the next vertical blanking period to update
  /// the current image. The framerate will be capped at the display refresh rate,
  /// corresponding to the `VSync`. Tearing cannot be observed. Optimal for mobile.
  fifo,
}

/// Primitive type the input mesh is composed of.
enum PrimitiveTopology {
  /// Vertex data is a list of points. Each vertex is a new point.
  pointList,

  /// Vertex data is a list of lines. Each pair of vertices composes a new line.
  ///
  /// Vertices `0 1 2 3` create two lines `0 1` and `2 3`
  lineList,

  /// Vertex data is a strip of lines. Each set of two adjacent vertices form a line.
  ///
  /// Vertices `0 1 2 3` create three lines `0 1`, `1 2`, and `2 3`.
  lineStrip,

  /// Vertex data is a list of triangles. Each set of 3 vertices composes a new triangle.
  ///
  /// Vertices `0 1 2 3 4 5` create two triangles `0 1 2` and `3 4 5`
  triangleList,

  /// Vertex data is a triangle strip. Each set of three adjacent vertices form a triangle.
  ///
  /// Vertices `0 1 2 3 4 5` creates four triangles `0 1 2`, `2 1 3`, `3 2 4`, and `4 3 5`
  triangleStrip,
}

enum SType {
  invalid,
  surfaceDescriptorFromMetalLayer,
  surfaceDescriptorFromWindowsHWND,
  surfaceDescriptorFromXlib,
  surfaceDescriptorFromHTMLCanvasId,
  shaderModuleSPIRVDescriptor,
  shaderModuleWGSLDescriptor,
}

extension _STypePlaceholder on SType {
  /// Placeholder value until real value can be determined
  int get anisotropicFiltering => 268435456;
}

/// Operation to perform on the stencil value.
enum StencilOperation {
  /// Keep stencil value unchanged.
  keep,

  /// Set stencil value to zero.
  zero,

  /// Replace stencil value with value provided in most recent call to [`RenderPass::set_stencil_reference`].
  replace,

  /// Bitwise inverts stencil value.
  invert,

  /// Increments stencil value by one, clamping on overflow.
  incrementClamp,

  /// Decrements stencil value by one, clamping on underflow.
  decrementClamp,

  /// Increments stencil value by one, wrapping on overflow.
  incrementWrap,

  /// Decrements stencil value by one, wrapping on underflow.
  decrementWrap,
}

/// Operation to perform to the output attachment at the end of a renderpass.
enum StoreOp {
  /// Clear the render target. If you don't care about the contents of the target, this can be faster.
  clear,

  /// Store the result of the renderpass.
  store,
}

/// Status of the recieved swapchain image.
enum SwapChainStatus {
  good,
  suboptimal,
  timeout,
  outdated,
  lost,
  outOfMemory,
}

/// Kind of data the texture holds.
enum TextureAspect {
  /// Depth, Stencil, and Color.
  all,

  /// Stencil.
  stencilOnly,

  /// Depth.
  depthOnly,
}

/// Type of data shaders will read from a texture.
///
/// Only relevant for [`BindingType::SampledTexture`] bindings. See [`TextureFormat`] for more information.
enum TextureComponentType {
  /// They see it as a floating point number `texture1D`, `texture2D` etc
  float,

  /// They see it as a signed integer `itexture1D`, `itexture2D` etc
  sint,

  /// They see it as a unsigned integer `utexture1D`, `utexture2D` etc
  uint,
}

/// Dimensionality of a texture.
enum TextureDimension {
  /// 1D texture
  d1,

  /// 2D texture
  d2,

  /// 3D texture
  d3,
}

/// Underlying texture data format.
///
/// If there is a conversion in the format (such as srgb -> linear), The conversion listed is for
/// loading from texture in a shader. When writing to the texture, the opposite conversion takes place.
enum TextureFormat {
  /// Red channel only. 8 bit integer per channel. [0, 255] converted to/from float [0, 1] in shader.
  r8Unorm,

  /// Red channel only. 8 bit integer per channel. [-127, 127] converted to/from float [-1, 1] in shader.
  r8Snorm,

  /// Red channel only. 8 bit integer per channel. Unsigned in shader.
  r8Uint,

  /// Red channel only. 8 bit integer per channel. Signed in shader.
  r8Sint,

  /// Red channel only. 16 bit integer per channel. Unsigned in shader.
  r16Uint,

  /// Red channel only. 16 bit integer per channel. Signed in shader.
  r16Sint,

  /// Red channel only. 16 bit float per channel. Float in shader.
  r16Float,

  /// Red and green channels. 8 bit integer per channel. [0, 255] converted to/from float [0, 1] in shader.
  rg8Unorm,

  /// Red and green channels. 8 bit integer per channel. [-127, 127] converted to/from float [-1, 1] in shader.
  rg8Snorm,

  /// Red and green channels. 8 bit integer per channel. Unsigned in shader.
  rg8Uint,

  /// Red and green channel s. 8 bit integer per channel. Signed in shader.
  rg8Sint,

  /// Red channel only. 32 bit integer per channel. Unsigned in shader.
  r32Uint,

  /// Red channel only. 32 bit integer per channel. Signed in shader.
  r32Sint,

  /// Red channel only. 32 bit float per channel. Float in shader.
  r32Float,

  /// Red and green channels. 16 bit integer per channel. Unsigned in shader.
  rg16Uint,

  /// Red and green channels. 16 bit integer per channel. Signed in shader.
  rg16Sint,

  /// Red and green channels. 16 bit float per channel. Float in shader.
  rg16Float,

  /// Red, green, blue, and alpha channels. 8 bit integer per channel. [0, 255] converted to/from float [0, 1] in shader.
  rgba8Unorm,

  /// Red, green, blue, and alpha channels. 8 bit integer per channel. Srgb-color [0, 255] converted to/from linear-color float [0, 1] in shader.
  rgba8UnormSrgb,

  /// Red, green, blue, and alpha channels. 8 bit integer per channel. [-127, 127] converted to/from float [-1, 1] in shader.
  rgba8Snorm,

  /// Red, green, blue, and alpha channels. 8 bit integer per channel. Unsigned in shader.
  rgba8Uint,

  /// Red, green, blue, and alpha channels. 8 bit integer per channel. Signed in shader.
  rgba8Sint,

  /// Blue, green, red, and alpha channels. 8 bit integer per channel. [0, 255] converted to/from float [0, 1] in shader.
  bgra8Unorm,

  /// Blue, green, red, and alpha channels. 8 bit integer per channel. Srgb-color [0, 255] converted to/from linear-color float [0, 1] in shader.
  bgra8UnormSrgb,

  /// Red, green, blue, and alpha channels. 10 bit integer for RGB channels, 2 bit integer for alpha channel. [0, 1023] ([0, 3] for alpha) converted to/from float [0, 1] in shader.
  rgb10a2Unorm,

  /// Red, green, and blue channels. 11 bit float with no sign bit for RG channels. 10 bit float with no sign bti for blue channel. Float in shader.
  rg11b10Float,

  /// Red and green channels. 32 bit integer per channel. Unsigned in shader.
  rg32Uint,

  /// Red and green channels. 32 bit integer per channel. Signed in shader.
  rg32Sint,

  /// Red and green channels. 32 bit float per channel. Float in shader.
  rg32Float,

  /// Red, green, blue, and alpha channels. 16 bit integer per channel. Unsigned in shader.
  rgba16Uint,

  /// Red, green, blue, and alpha channels. 16 bit integer per channel. Signed in shader.
  rgba16Sint,

  /// Red, green, blue, and alpha channels. 16 bit float per channel. Float in shader.
  rgba16Float,

  /// Red, green, blue, and alpha channels. 32 bit integer per channel. Unsigned in shader.
  rgba32Uint,

  /// Red, green, blue, and alpha channels. 32 bit integer per channel. Signed in shader.
  rgba32Sint,

  /// Red, green, blue, and alpha channels. 32 bit float per channel. Float in shader.
  rgba32Float,

  /// Special depth format with 32 bit floating point depth.
  depth32Float,

  /// Special depth format with at least 24 bit integer depth.
  depth24Plus,

  /// Special depth/stencil format with at least 24 bit integer depth and 8 bits integer stencil.
  depth24PlusStencil8,
}

/// Dimensions of a particular texture view.
enum TextureViewDimension {
  /// A one dimensional texture. `texture1D` in glsl shaders.
  d1,

  /// A two dimensional texture. `texture2D` in glsl shaders.
  d2,

  /// A two dimensional array texture. `texture2DArray` in glsl shaders.
  d2Array,

  /// A cubemap texture. `textureCube` in glsl shaders.
  cube,

  /// A cubemap array texture. `textureCubeArray` in glsl shaders.
  cubeArray,

  /// A three dimensional texture. `texture3D` in glsl shaders.
  d3,
}

/// Vertex Format for a Vertex Attribute (input).
enum VertexFormat {
  /// Two unsigned bytes (u8). `uvec2` in shaders.
  uchar2,

  /// Four unsigned bytes (u8). `uvec4` in shaders.
  uchar4,

  /// Two signed bytes (i8). `ivec2` in shaders.
  char2,

  /// Four signed bytes (i8). `ivec4` in shaders.
  char4,

  /// Two unsigned bytes (u8). [0, 255] converted to float [0, 1] `vec2` in shaders.
  uchar2Norm,

  /// Four unsigned bytes (u8). [0, 255] converted to float [0, 1] `vec4` in shaders.
  uchar4Norm,

  /// Two signed bytes (i8). [-127, 127] converted to float [-1, 1] `vec2` in shaders.
  char2Norm,

  /// Four signed bytes (i8). [-127, 127] converted to float [-1, 1] `vec4` in shaders.
  char4Norm,

  /// Two unsigned shorts (u16). `uvec2` in shaders.
  ushort2,

  /// Four unsigned shorts (u16). `uvec4` in shaders.
  ushort4,

  /// Two unsigned shorts (i16). `ivec2` in shaders.
  short2,

  /// Four unsigned shorts (i16). `ivec4` in shaders.
  short4,

  /// Two unsigned shorts (u16). [0, 65535] converted to float [0, 1] `vec2` in shaders.
  ushort2Norm,

  /// Four unsigned shorts (u16). [0, 65535] converted to float [0, 1] `vec4` in shaders.
  ushort4Norm,

  /// Two signed shorts (i16). [-32767, 32767] converted to float [-1, 1] `vec2` in shaders.
  short2Norm,

  /// Four signed shorts (i16). [-32767, 32767] converted to float [-1, 1] `vec4` in shaders.
  short4Norm,

  /// Two half-precision floats (no Rust equiv). `vec2` in shaders.
  half2,

  /// Four half-precision floats (no Rust equiv). `vec4` in shaders.
  half4,

  /// One single-precision float (f32). `float` in shaders.
  float,

  /// Two single-precision floats (f32). `vec2` in shaders.
  float2,

  /// Three single-precision floats (f32). `vec3` in shaders.
  float3,

  /// Four single-precision floats (f32). `vec4` in shaders.
  float4,

  /// One unsigned int (u32). `uint` in shaders.
  uint,

  /// Two unsigned ints (u32). `uvec2` in shaders.
  uint2,

  /// Three unsigned ints (u32). `uvec3` in shaders.
  uint3,

  /// Four unsigned ints (u32). `uvec4` in shaders.
  uint4,

  /// One signed int (i32). `int` in shaders.
  int,

  /// Two signed ints (i32). `ivec2` in shaders.
  int2,

  /// Three signed ints (i32). `ivec3` in shaders.
  int3,

  /// Four signed ints (i32). `ivec4` in shaders.
  int4,
}
