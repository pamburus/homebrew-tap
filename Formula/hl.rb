class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.31.1"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.31.1/hl-macos-x86_64.tar.gz"
      sha256 "ae55ebfb0a3f2980bfea0e0b01bf861d9c67ece6353930d7250146b63c1ff57a"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.31.1/hl-macos-arm64.tar.gz"
      sha256 "30f9ade4dfdeafed1b9330a8c02e5196a2ac431a280ae69e3bc277d985a89c14"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.31.1/hl-linux-x86_64-musl.tar.gz"
      sha256 "ae8c86ec6ff4b46a75249ff48a996cec5453429da88c8407865808cb60da14af"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.31.1/hl-linux-arm64-musl.tar.gz"
      sha256 "cb2ce6fde87735d813d51a0bd7f2b707a64fe990320ff5d0715efb3e66fb4615"

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
