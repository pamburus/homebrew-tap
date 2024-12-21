class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.30.0"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.30.0/hl-macos-x86_64.tar.gz"
      sha256 "51d19327016a7cfe81e20b4064e9d1f67abf2a6974f53a713c8fc8071daca145"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.30.0/hl-macos-arm64.tar.gz"
      sha256 "496a59c9dd11bfa696a025383b3e6b0cef1dadb8fefdfab0f0fdfae9e2a4a8b8"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.30.0/hl-linux-x86_64-musl.tar.gz"
      sha256 "2df5f0a3f257822b5064fca7b6bccf7317e0e3273018bd1872e30ff6c627e20e"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.30.0/hl-linux-arm64-musl.tar.gz"
      sha256 "e622fec41de019ad172107511b6b5acbdb6d5e2d5fbeaf3e1655c0c5ba742f42"

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
