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
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.9.2"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "1fce0c758f43e5f3d101e1c81c6b4a8bff621e6602e34a8c5fb5048f3a02f059"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "f3851cc84729b1bc77676167075d9e41e664d4f09f954d064dd6becbb98b1e56"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "fd217a1c1749dae8459663d64dee599120802ce3171131b409b081d1d029c413"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "4239feb1cefd6715eba6ab83f56441dfaa6a33828acbc82dd775f8e8edd7c8f8"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.9.2/termframe-macos-x86_64.tar.gz"
      sha256 "97c28e70472edc77aeb2fcf913287a5d5af3f318b4b87f2912c0164186e2778f"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.9.2/termframe-macos-arm64.tar.gz"
      sha256 "b2d59f9431284c36415cbaf087db6edfb473e6b699e0dbcb9d9537241cbdfc4e"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.9.2/termframe-linux-x86_64-musl.tar.gz"
      sha256 "453e843197530e7152d32d1d0c82cd8c61bd8999db8ede99a526d674eecdf922"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.9.2/termframe-linux-arm64-musl.tar.gz"
      sha256 "497ff2bc65c7547c9c06df1dadb66677d9296370a1bada11ce0523c1f83a0b6b"

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
