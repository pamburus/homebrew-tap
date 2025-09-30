class Fd < Formula
  desc "Fast, user-friendly, and open-source alternative to find"
  homepage "https://github.com/sharkdp/fd"
  license "MIT"
  head "https://github.com/sharkdp/fd.git", branch: "master"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "991a648a58870230af9547c1ae33e72cb5c5199a622fe5e540e162d6dba82d48"

      define_method(:install) do
        bin.install "hl"
        (man1/"fd.1").write Utils.safe_popen_read(bin/"fd", "--help")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "ae6327ba8c9a487cd63edd8bddd97da0207887a66d61e067dfe80c1430c5ae36"

      define_method(:install) do
        bin.install "fd"
        (man1/"fd.1").write Utils.safe_popen_read(bin/"fd", "--help")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d9bfa25ec28624545c222992e1b00673b7c9ca5eb15393c40369f10b28f9c932"

      define_method(:install) do
        bin.install "fd"
        (man1/"fd.1").write Utils.safe_popen_read(bin/"fd", "--help")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4e8e596646d047d904f2c5ca74b39dccc69978b6e1fb101094e534b0b59c1bb0"

      define_method(:install) do
        bin.install "fd"
        (man1/"fd.1").write Utils.safe_popen_read(bin/"fd", "--help")
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fd --version")
  end
end
