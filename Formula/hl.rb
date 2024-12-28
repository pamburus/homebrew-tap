class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.30.1"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.30.1/hl-macos-x86_64.tar.gz"
      sha256 "73727af69f269fb50799b1cb88f684969b431986797e50aa99481b3704fdf679"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.30.1/hl-macos-arm64.tar.gz"
      sha256 "84a28eeff18e44c979c2622f730f2024b94195afc65ef06256dd0a796087c3f7"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.30.1/hl-linux-x86_64-musl.tar.gz"
      sha256 "e6831080fa0302bc46b15be8f0493463ed979a3fe59cf7812931816b8c231e29"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.30.1/hl-linux-arm64-musl.tar.gz"
      sha256 "658d3033d6973f7162a96a3604e0e0f37ccb3c6500de3cbe3ea3bacc9eabaf10"

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
