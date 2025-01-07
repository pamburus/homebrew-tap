class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.30.2"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.30.2/hl-macos-x86_64.tar.gz"
      sha256 "7c5613ce5c6d7010a38a11a6eb1f6a23fd807aa3f259101db4b751c27826f441"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.30.2/hl-macos-arm64.tar.gz"
      sha256 "75986f0fc2907c7036c387d485b1fc7dfcc58a379bf6cb3be4d43eb9a5205ad0"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.30.2/hl-linux-x86_64-musl.tar.gz"
      sha256 "c49fff052b11ecb1ec704c7167dfaa704bfe4a6f65c0532afefb2a7b5bd9556a"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.30.2/hl-linux-arm64-musl.tar.gz"
      sha256 "97a019829b6b6f16d52d811705b14d0e8d012b154877431c16150d2666864038"

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
