class Odcslint < Formula
  desc "A fast linter and fixer for Open Data Contract Standard (ODCS) contracts"
  homepage "https://github.com/feliblo/odcslint"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/odcslint/releases/download/v0.3.0/odcslint-aarch64-apple-darwin.tar.xz"
      sha256 "cc002e1fc943aaec00b9f35f8831e47ba0dd384be5a52d4ef2d433cea56008c8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/odcslint/releases/download/v0.3.0/odcslint-x86_64-apple-darwin.tar.xz"
      sha256 "c6b59fb3badcf8836605a417ff456a3c9ad9ce8d605956062a86131d99231646"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/odcslint/releases/download/v0.3.0/odcslint-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "678ab3e7fdc3b18108923c730f15b815e6d145e57f90adde57cdbfb430f818f4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/odcslint/releases/download/v0.3.0/odcslint-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "03135ef69ed9af8a55979340f45ac1b1020b977a9843320a1a9bcfa06757ea17"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "odcslint"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "odcslint"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "odcslint"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "odcslint"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
