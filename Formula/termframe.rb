class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.5.2"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.5.2/termframe-macos-x86_64.tar.gz"
      sha256 "6d9e573cfe39eb64dc8598d6abc46590c9d49f10b1563ed7d497ffb819c6505d"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.5.2/termframe-macos-arm64.tar.gz"
      sha256 "6ba1761e0f1477ff55431a61548a9db46c69b6be39c67964eb1023e84e91c523"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.5.2/termframe-linux-x86_64-musl.tar.gz"
      sha256 "fb8601cdfccf089bf79547ac559b1457bbc6ea26c6090e70a98ed263cf4a051a"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.5.2/termframe-linux-arm64-musl.tar.gz"
      sha256 "e4802bdabc03c9918d65ee34c421c4a92a7e940395d0540d7327aeac268b46dd"

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
