class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.31.2"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.31.2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0d5e5e8b813b1cde44b541add3c7a68de7d19539a64a1df6d55569c4963b2581"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cee1a9d76108e80a4e1a6ac1904543f059270b1a582a4fa2f3002b3debbac089"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ecb55e847a7334c13396c1a6eeb67f84120197956123755e12a2f2b4b1cd8213"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.31.2/hl-macos-x86_64.tar.gz"
      sha256 "06217dde5469d5b259c1fa0c139def180db72fda6b2239228c0bed59a77c5c62"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.31.2/hl-macos-arm64.tar.gz"
      sha256 "e020641e59efbf563688ea5a86a5a2631f5ac9be03f7ae8be080aa76fb29f9c2"

      define_method(:install) do
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

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.31.2/hl-linux-arm64-musl.tar.gz"
      sha256 "07324020aba075b5e927abb6141ba8dd73b5b38c00a6dc15d8ec77dcfd5b9acc"

      define_method(:install) do
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
