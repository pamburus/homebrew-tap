class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.31.2"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.31.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2b96cbcccb6591b95a6608ffb838430645df9d0e5258a47b4ab9553ae637be6a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "18db5e6eba9c447d3d92db90ea5dacafbd32972e69840a54a8ea6739bd956b3d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fab5e5c86cd2403156bc0d1e56555fa5ae00e59aa4c1a0c2ace33f7731378616"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.31.2/hl-macos-x86_64.tar.gz"
      sha256 "06217dde5469d5b259c1fa0c139def180db72fda6b2239228c0bed59a77c5c62"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.31.2/hl-macos-arm64.tar.gz"
      sha256 "e020641e59efbf563688ea5a86a5a2631f5ac9be03f7ae8be080aa76fb29f9c2"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.31.2/hl-linux-x86_64-musl.tar.gz"
      sha256 "738851e5b3ea23c51b1d484715cdc7f8eab343f20c569066e8124b36ac7934ef"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.31.2/hl-linux-arm64-musl.tar.gz"
      sha256 "07324020aba075b5e927abb6141ba8dd73b5b38c00a6dc15d8ec77dcfd5b9acc"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hl --version")
  end
end
