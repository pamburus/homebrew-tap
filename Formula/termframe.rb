class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.6.5"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.6.5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a09193b1373ecc3038c88eb542ef32fce5238e40b63c62d6ac82d0b24d14dbf8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "25b6c07cc7940a102bef67a7892f88d084e65cfb61849def268090a4831d9298"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "adab2a57929fe161d598766835f1b5e1feedf9c12ccc78b038ae768b8d115a06"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.5/termframe-macos-x86_64.tar.gz"
      sha256 "574a38dca8324b6870ad7a88282a53da837e30267f283a0d74dd6b803aca795c"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.5/termframe-macos-arm64.tar.gz"
      sha256 "2bd5de54db7a4d248d5323e749b9648fb426443c18d55351a6b8eb95d603c6b3"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.5/termframe-linux-x86_64-musl.tar.gz"
      sha256 "4c27ac79d155f04768e05f6a2a7b17c5d6af5cc09a05c5a6ffbb30973066886b"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.5/termframe-linux-arm64-musl.tar.gz"
      sha256 "3c7e664d17d006826ca02138da2a4ae25839364762ef522772cc8f5d0ae02d51"

      define_method(:install) do
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
