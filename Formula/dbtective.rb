class Dbtective < Formula
  desc "A Rust-powered linter and detective for dbt metadata best practices"
  homepage "https://github.com/feliblo/dbtective"
  version "0.3.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/dbtective/releases/download/v0.3.4/dbtective-aarch64-apple-darwin.tar.xz"
      sha256 "dda7df566cb69841c8f0bfe0c0eae1064490143ac7cf83748a3d39dbfaf8e917"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/dbtective/releases/download/v0.3.4/dbtective-x86_64-apple-darwin.tar.xz"
      sha256 "905c93e79046a8557303f9bba566855aeb73ef115110435e38c469dc229bcc25"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feliblo/dbtective/releases/download/v0.3.4/dbtective-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2dcb5500bd724f1027595f1258bf3e72617d8b80643f705e9b7f47fedc109fb4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feliblo/dbtective/releases/download/v0.3.4/dbtective-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0cc44c4c68e93c591b865a436e3b980b22842e95b4a8ec156528530b4e36c095"
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
