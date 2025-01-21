class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.30.3"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.30.3/hl-macos-x86_64.tar.gz"
      sha256 "232b28d41726fb83ddeff1fbe6df6297fc26970b6edf968199b34384ed884301"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.30.3/hl-macos-arm64.tar.gz"
      sha256 "dc05948ce70858c701bdc4c3418d65930dca8157389155bccb3a0f6acc0bbb0f"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.30.3/hl-linux-x86_64-musl.tar.gz"
      sha256 "08623b0b4a93ae22d853debd06a6d1e6675f3fec9e0d9856b2c858da293bc5f8"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.30.3/hl-linux-arm64-musl.tar.gz"
      sha256 "26d13f4c3a980d61c1128ebde9c02d9e6b9f6879758507c27147ff7a81004db3"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  test do
    system "#{bin}/hl", "--version"
  end
end
