class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.2.0"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "13c0232664cd1ecee4eebbb560704a098ab2c641ec2002d45ddd0ed52c2d4b25"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "28de88c51692a0866dd06af9c6dd95085634b831aed5d1552690b21216598324"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cecdc2f2f3c4ed3ccdf0d45d50271208518abaa7d100294de6577d9a4dd9b3ec"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.2.0/termframe-macos-x86_64.tar.gz"
      sha256 "26c564c9d93de28d62dc28373bd74e35863cb455997579e969cfc399bfa76ba1"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.2.0/termframe-macos-arm64.tar.gz"
      sha256 "0767c1a8caac51685cf2c198b1c811ca5267956c69eea6526e1bc95d9ca5f0fc"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.2.0/termframe-linux-x86_64-musl.tar.gz"
      sha256 "f35653b236f0a71dfcccf8d8085ac66bd801fdc482babf448932da5b3a2e6cef"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.2.0/termframe-linux-arm64-musl.tar.gz"
      sha256 "e64e3525c89245f756d5e8e04e636993680bb4ac57a75a4f4d65244d8b27de7f"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/termframe --version")
  end
end
