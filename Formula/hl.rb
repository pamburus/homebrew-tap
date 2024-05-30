class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.29.5"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.29.5/hl-macos-x86_64.tar.gz"
      sha256 "588cd38071d6e66b6a04d69a5f43aea706e0802d73aba3c08a1aaba1d439001f"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
        man.install "man1"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.29.5/hl-macos-arm64.tar.gz"
      sha256 "a51fe10426489748d57d58f2e323b5cf91efeeca400f8a817bbc35837953b8d2"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
        man.install "man1"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.29.5/hl-linux-x86_64-musl.tar.gz"
      sha256 "ace202cad3c4cd7a80596427b06c059c6831610b8dd4a90ee9dc103dce38e8ae"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
        man.install "man1"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.29.5/hl-linux-arm64-musl.tar.gz"
      sha256 "a2f431275f72330bcfff03e165b6a789593dc9f11013a84770d304372ac60c1b"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
        man.install "man1"
      end
    end
  end

  test do
    system "#{bin}/hl", "--version"
  end
end
