class Dbtective < Formula
  desc "A Rust-powered linter and detective for dbt metadata best practices"
  homepage "https://github.com/feliblo/dbtective"
  version "0.1.17"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.17/dbtective-aarch64-apple-darwin.tar.xz"
      sha256 "db601a124ea9d9aab7019a88a7ef2106e63e18cda2223fa2504c5b6c4fdf21ae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.17/dbtective-x86_64-apple-darwin.tar.xz"
      sha256 "d1e59ebe1e1af2259b1e7e186d9819c1578db9c04897038c64b002b7e48838cb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.17/dbtective-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ee3a0f67afd149a26a75e9ce7276f963615b213866f88be6715899705a7f981f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.17/dbtective-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8b6ce84f265b68b08ea68c09d4375d6974b0e0898f9b4fc43a93eb3f17a9cc80"
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
