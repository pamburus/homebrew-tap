class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.1.0"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.1.0/termframe-macos-x86_64.tar.gz"
      sha256 "c21f175549e953f94adf481d40cee8d04aef5d9b9de44f0116c7cdf3333393ce"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.1.0/termframe-macos-arm64.tar.gz"
      sha256 "e1186333da81f0478a8bf6ae0c8dfd94bfb9c5b33e15fe66dad0ad87e863c458"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.1.0/termframe-linux-x86_64-musl.tar.gz"
      sha256 "f94db354ea42fa248862f4c44d56f8558ddda3901846b0b051f41152ba977931"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.1.0/termframe-linux-arm64-musl.tar.gz"
      sha256 "b6337f776814013255e80e184b8b3ee94d249ad303ae360a1efd0dc1b3fa96b4"

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
