class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.9.3"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "55f778e57bddd2900943800babb9a8a4414e83b4f99866ffad9556a216595f71"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "242dae0cdf4912b29f13fcb3fb31f74a0f0ea14e4c1ceb6f8fff59bc6e12e298"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "6599668c8e646f2a47573a2ac6aa645a04d0704584d284855b0dbabf74c3d5b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "914ac3a9ef55784943c3c31fe05d573179e42dc67a613e814764892982e6ef19"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.9.3/termframe-macos-x86_64.tar.gz"
      sha256 "5e3c54671771ec4986d1ec8b0d075c785cea9b282bc0eb1e04fa789404ef56d0"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.9.3/termframe-macos-arm64.tar.gz"
      sha256 "d7c958ed9e4c10bb4345bec5e40e94fa0bddc997804e7320ece6404693104e09"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.9.3/termframe-linux-x86_64-musl.tar.gz"
      sha256 "0f6a0302a96b091149606475a42d9cd4057ccdc9522d25b0c91e8e50bc525b00"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.9.3/termframe-linux-arm64-musl.tar.gz"
      sha256 "84501081340adb778e5ec2647fcea83d80626fa7b27604c6fc5f1a4a836904e8"

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
