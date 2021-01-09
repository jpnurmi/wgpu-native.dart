/// Buffer-Texture copies must have [`bytes_per_row`] aligned to this number.
///
/// This doesn't apply to [`Queue::write_texture`].
///
/// [`bytes_per_row`]: TextureDataLayout::bytes_per_row
const int kCopyBytesPerRowAlignment = 256;

const int kDesiredNumFrames = 3;

const int kMaxAnisotropy = 16;

const int kMaxColorTargets = 4;

const int kMaxMipLevels = 16;

const int kMaxVertexBuffers = 16;
