class Dbtective < Formula
  desc "A Rust-powered linter and detective for dbt metadata best practices"
  homepage "https://github.com/feliblo/dbtective"
  version "0.1.12"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.12/dbtective-aarch64-apple-darwin.tar.xz"
      sha256 "4708437f1ae4e4e0505b2b3ed2864dc690732168e07194c59ba953026a876b7b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.12/dbtective-x86_64-apple-darwin.tar.xz"
      sha256 "5e99bb52d8334a5391a5e91e5afe719864dc2e8fd614fde9a4ad9916096b7b70"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.12/dbtective-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2df1182314530c08990e21e14e59c252828b88d0e9c42a2b7af9bbc7234c4e56"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.12/dbtective-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c218837c858cc3262ab090c09dd20ea9047e1b8d30aca921f23abaf1841c5dc7"
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
