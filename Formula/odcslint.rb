class Odcslint < Formula
  desc "A fast linter and fixer for Open Data Contract Standard (ODCS) contracts"
  homepage "https://github.com/feliblo/odcslint"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/odcslint/releases/download/v0.1.0/odcslint-aarch64-apple-darwin.tar.xz"
      sha256 "54857b74b4cfaa613e32ec349d726a5c65d683f7e69fa871bee3e588202b0178"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/odcslint/releases/download/v0.1.0/odcslint-x86_64-apple-darwin.tar.xz"
      sha256 "fc61b71a66cb5ef8d3b72d23aee1a08fffa82eedb96c53edd8a6e06f42b865f3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/odcslint/releases/download/v0.1.0/odcslint-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "74845f1de9121e4002a787066d5dc0ea5aabf22f932658d60b312b2a472100df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/odcslint/releases/download/v0.1.0/odcslint-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "beea0f20dc2a3d6dbff5c0c43e4cf6a299e2a8655075b94c5c1ffb697ec72a12"
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
