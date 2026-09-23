class Dbtective < Formula
  desc "A Rust-powered linter and detective for dbt metadata best practices"
  homepage "https://github.com/feliblo/dbtective"
  version "0.3.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/dbtective/releases/download/v0.3.5/dbtective-aarch64-apple-darwin.tar.xz"
      sha256 "f586759c0eabf86b39c0c9e7e6ab84801d3241e9ea690f6607d7d768b4f78b63"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/dbtective/releases/download/v0.3.5/dbtective-x86_64-apple-darwin.tar.xz"
      sha256 "0737e41326f6f594a35b5c4149820d719b24919cdf30cab6526ace10d746d6dd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/dbtective/releases/download/v0.3.5/dbtective-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "59ef8872b7da1476cf4b017104d243ac2756ec15852c0b95144bd9f6aad72b5d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/dbtective/releases/download/v0.3.5/dbtective-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b85bec81c83555444f8e5ab390b5b17e72e4f551fd3f31feec039d28a200109a"
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
      bin.install "dbtective"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dbtective"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dbtective"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dbtective"
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
