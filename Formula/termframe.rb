class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.3.0"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f795010242517dda28fd7d2a617e1969eee9c14b1b3e7d352a5e32d48bd9bd66"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0955b863e2b4e8d0f8b2f00d4cf339c7b0982a74b087bbebc9620b5a1c73ed08"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "605eaca97c7357ceaed50dcb60d62e05b4f3c88f986fb530533a6ad4d8050d80"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.3.0/termframe-macos-x86_64.tar.gz"
      sha256 "ec5df8673ec45cecf0e58ad3f90a7bf5302ff38c33856da87f97fe59f32799da"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.3.0/termframe-macos-arm64.tar.gz"
      sha256 "f82d1907ffb58e90ba198a7e91fa701ab1437e1700f8436909c7823ba38d2014"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.3.0/termframe-linux-x86_64-musl.tar.gz"
      sha256 "07037f17b4648274806f2a1144710d0ee37ee2958602f12b3be9756a07c04356"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.3.0/termframe-linux-arm64-musl.tar.gz"
      sha256 "7bde0cd12e83c857f791dc2308edc1d885dde8c61fb32c29c2669a5f55c5ddcf"

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
