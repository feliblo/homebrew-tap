class Odcslint < Formula
  desc "A fast linter and fixer for Open Data Contract Standard (ODCS) contracts"
  homepage "https://github.com/feliblo/odcslint"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/odcslint/releases/download/v0.2.0/odcslint-aarch64-apple-darwin.tar.xz"
      sha256 "b1cf4ca0e6ed9795c43aeb468b2381404787f6ba44f9de978d634ca5f5678c5c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/odcslint/releases/download/v0.2.0/odcslint-x86_64-apple-darwin.tar.xz"
      sha256 "b0295374d67fd9c52cd2609380e82a26b9392519a6267a4b42a593b7a4cbfa8f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/odcslint/releases/download/v0.2.0/odcslint-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6879320295ba1e51995272eb17795cf533ebfe3c96ad15245833e496859437db"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/odcslint/releases/download/v0.2.0/odcslint-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "db220aadc7adbc060fc1ce27d69e600cfd5a769f63c0ff013bb6a5a2b0b3b018"
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
