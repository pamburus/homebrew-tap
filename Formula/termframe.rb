class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.4.2"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.4.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d83e7985d633ce4278b31a7f1a11750ba2f3854fc5bbe1716b7eea3b785e8446"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4cc34fdf04a7a0306296c8ceb0fd9ab14097949deb1d0518c0b06c6751c31762"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ce4c497dfc775eececacef551e2548ca35a6448008328a36aad3e328b0466668"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.4.2/termframe-macos-x86_64.tar.gz"
      sha256 "9c5049276e57b68d6f089d25ccad84e62b6bd35d83149c68a225e951d334ad9c"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.4.2/termframe-macos-arm64.tar.gz"
      sha256 "56f005dcc377b0ec3c6b14778d4654cd1606b93e20084129e814a277363bd145"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.4.2/termframe-linux-x86_64-musl.tar.gz"
      sha256 "9dc944b2df73987527fdc46cb75841c453b8a8e9e9a4f2d123a502629d95afdd"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.4.2/termframe-linux-arm64-musl.tar.gz"
      sha256 "8909b978e592ccb543cc3415636cc06100de74abde1b6a4070accdf48c209273"

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
