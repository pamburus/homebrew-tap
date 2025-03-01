class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.30.4"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.30.4/hl-macos-x86_64.tar.gz"
      sha256 "d6b71aefa11436ca8ad51979c746143a46fb66b66f5cae63b6a0d19e94686305"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.30.4/hl-macos-arm64.tar.gz"
      sha256 "8e301107038f37b1d27918b77c348458c9b58e934f42341ccd901b88642ab3b9"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.30.4/hl-linux-x86_64-musl.tar.gz"
      sha256 "fe0b86220e1ccaad75fd8898254efac0a39e61ff187bfa6e68b43fe17859ae7a"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.30.4/hl-linux-arm64-musl.tar.gz"
      sha256 "199e130f14392716297b77a77ef471c024a324b1530c5c095ce4240946c35e96"

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
