class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.29.10"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.29.10"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8d0feb9c900f44be587d7e9f9b38e78ef3620551d6374037358c1b270808d09b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2d02feb63736d758a16d869d10368f94b4b96af7df4f764ffd371f575b0e3f93"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.29.10/hl-macos-x86_64.tar.gz"
      sha256 "7399d344e9ba11f36ace0289e80baba060cbfd8d6c57aa7eefb54861c48675d3"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.29.10/hl-macos-arm64.tar.gz"
      sha256 "1d4bd13432c16e54e7b44ffdb8ccd68202fe5d82d8db85d315d05243d5d580a1"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.29.10/hl-linux-x86_64-musl.tar.gz"
      sha256 "9e6b3e69e2c8a174d7ce214e805d8fca2354007624ce83345443bee5329f5a29"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.29.10/hl-linux-arm64-musl.tar.gz"
      sha256 "3c159ca519872932e9dceed1ae984f0d4889439ba5bc2d1b704ef447c0eb72fe"

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
