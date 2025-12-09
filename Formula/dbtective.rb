class Dbtective < Formula
  desc "A Rust-powered linter and detective for dbt metadata best practices"
  homepage "https://github.com/feliblo/dbtective"
  version "0.1.15"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.15/dbtective-aarch64-apple-darwin.tar.xz"
      sha256 "cb9b04f20cd6635ce80ec576038b465090fc161d553dbd3eaf4cb09473758512"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.15/dbtective-x86_64-apple-darwin.tar.xz"
      sha256 "910be1761cac804e4f10e00aedc8f1dfe974c5aa54fad440249d81129234a175"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.15/dbtective-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f11c1fa14c26d3ba15be5dc5bcf0857f04a1b184cbc4d74d0cc5c0876aeefb24"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/dbtective/releases/download/v0.1.15/dbtective-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2ec8bb82b5bfcc0e0170e85ed32488314ec2f7d352802d631545883ab84f65e8"
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
