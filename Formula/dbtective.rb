class Dbtective < Formula
  desc "A Rust-powered linter and detective for dbt metadata best practices"
  homepage "https://github.com/feliblo/dbtective"
  version "0.1.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.10/dbtective-aarch64-apple-darwin.tar.xz"
      sha256 "78b1ca18aa719b13fffd15fd238d5017a0a069ffeb47bacfc6057da39a02e867"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.10/dbtective-x86_64-apple-darwin.tar.xz"
      sha256 "0de590130ac97663a646a6fb19ac0d29a78f2b3c03d538c719a3c957983efa59"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.10/dbtective-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9a65680e0b870dff3ba618d4419f9662a90dd8485cfc7d1368e1b6152fea02d9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.10/dbtective-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f3ab52b093725346184bfe023a8f1b30aa17cee56e169dee124cb35b13b204ab"
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
    bin.install "dbtective" if OS.mac? && Hardware::CPU.arm?
    bin.install "dbtective" if OS.mac? && Hardware::CPU.intel?
    bin.install "dbtective" if OS.linux? && Hardware::CPU.arm?
    bin.install "dbtective" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
