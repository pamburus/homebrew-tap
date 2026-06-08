class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.8.6"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.8.6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "133ffc0a106b5339ad15907b2d2d06cafbff4fc69989bcf8880d4d12be3b7527"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e8ed0007d521ed9b9c3c5e944f27a0c7ed6069e5b8b9f7d1a42f6c0ae9143c2d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2eccd58f18dca529b44313472820cff20db80700c6c2de74043074d2d5e67983"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3311b11c503fe59d910d867eb19c7381d3be2443045d9ca1a1dc6752c7465293"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.6/termframe-macos-x86_64.tar.gz"
      sha256 "5f7a9d972ea38850099ec33c0300a1143a09ad6396224594794103145a410e7a"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.6/termframe-macos-arm64.tar.gz"
      sha256 "a358e2d4b403f524d7b1a891e390726371d07dd565c633b9fe3cfeccd240753d"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.6/termframe-linux-x86_64-musl.tar.gz"
      sha256 "05ee5f290d24ecd5ebab2332dd180f9477784830cb11a2a87fb0cc848c626af7"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.6/termframe-linux-arm64-musl.tar.gz"
      sha256 "6766d2a7340c66881f061b1b65fb5a2286b2e4881a274bfc074c28a9b3f7625d"

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
