class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.6.8"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.6.8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "be05977818d4af3e822655c531b8aa99692ba0e688a779f9486f5c7921f1ceac"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "34597209a8400d45b8f46d617601a73e929b8eeca52f2df3bda1b015da14b3da"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f97fc2cec646054558b7a0125eac7262e27193674273b1bfdc249beffbdc17da"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.8/termframe-macos-x86_64.tar.gz"
      sha256 "107794a0ec5af8ce1b00dd9b165f2dac0caec5b6c48d928836fad27dd079e933"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.8/termframe-macos-arm64.tar.gz"
      sha256 "bc1b4626a7d697829058e215bc309a1ccc3db25462aa2ce78b7bf315dc318674"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.8/termframe-linux-x86_64-musl.tar.gz"
      sha256 "6370f524fc804455052ae98d33db9068b06574b182876831e3c2d4cd9c970f04"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.8/termframe-linux-arm64-musl.tar.gz"
      sha256 "ec1a648434dddb0c198b6402909bc49ed08f16d6c29e896d7039802f8146d644"

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
