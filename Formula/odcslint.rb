class Odcslint < Formula
  desc "A fast linter and fixer for Open Data Contract Standard (ODCS) contracts"
  homepage "https://github.com/feliblo/odcslint"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/odcslint/releases/download/v0.3.1/odcslint-aarch64-apple-darwin.tar.xz"
      sha256 "06a10ae1499f791d79b74609e8d4aa5aa849f61d25fd3c58152e3f998027b29a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/odcslint/releases/download/v0.3.1/odcslint-x86_64-apple-darwin.tar.xz"
      sha256 "03e0be570d06741c7924ade23a7ffe2f72fdb70295b2707660a85d8c1c54e385"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/odcslint/releases/download/v0.3.1/odcslint-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "92c82901d07b06b893449f6e6ccc7dd53bd6f251a1708d7a9b633a1ad6fec586"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/odcslint/releases/download/v0.3.1/odcslint-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0a059ed46251ae30494425fa7d5833307799f3a234bac0998a36051ace4dcdd7"
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
