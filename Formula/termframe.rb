class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.8.1"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.8.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "60800be073c0a24f8618311431c39fdf93dd7c33b9a214724d554d0fd0dcdf1a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bd3ee8354a32635dbef20600916db835ee540fbc8a7af8b32068082cb67f14b7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0ecaaf18749852243c84d6e78c8c8112673a412ab57d3007da3aac4ef7766104"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "29c75cd65c1c52296c7c076d9229b59721986559120ac28fc53110c131d1c357"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.1/termframe-macos-x86_64.tar.gz"
      sha256 "543cae480bcfcd973b5c6cc086622c0c74d2521d096e8a46db3361cb10718753"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.1/termframe-macos-arm64.tar.gz"
      sha256 "36ea02d1b91840745cbc2d616b9abd421aacf726746efe4854a0e9859e3089d8"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.1/termframe-linux-x86_64-musl.tar.gz"
      sha256 "d57ea724e6ae2574e6a80c3779b23d7f2dad837012c5a6ece4d612b731076af3"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.1/termframe-linux-arm64-musl.tar.gz"
      sha256 "3f0b6886f004a80bb32ffe29ee4962d79cbb5e373b98ea0a56910bfe46ac513d"

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
