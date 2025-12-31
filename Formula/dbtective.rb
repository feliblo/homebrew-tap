class Dbtective < Formula
  desc "A Rust-powered linter and detective for dbt metadata best practices"
  homepage "https://github.com/feliblo/dbtective"
  version "0.1.30"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.30/dbtective-aarch64-apple-darwin.tar.xz"
      sha256 "027c8c107f917cfe01f6e2bc84176f3f3f4bb7feeb4ca077c540281cc26e2b69"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.30/dbtective-x86_64-apple-darwin.tar.xz"
      sha256 "15221fa4e3e1880f5f69245b513b5cbb3e1e6a2af41c1de311e7fe09f125fcf4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.30/dbtective-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "914b8502b5ca398e732e6f3c4372ae1952eae3d9fb4430342c4ee4755a0e5fb5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.30/dbtective-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "efd2675af2bcf8c1edc9a8239aed1d76f06a558e52fc214aed87c6370382ab93"
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
