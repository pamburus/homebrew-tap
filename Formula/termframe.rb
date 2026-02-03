class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.8.0"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.8.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c00338b9559e14f0a1311c15154da9cf417e6b7ba602fe98e986cd087b2f6679"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "96c0f4d67c979a230474e73af5e39b520b4346b8563ab2cc413f2e0adec3baab"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "34636f6bb724adc334e389f35e594d24856f9751d7161a384a52ca1286e2c5e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f7203752dc48c795dcf75d7d6c9897e841b27c9b3763297f76a57ead8dd7aaa3"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.0/termframe-macos-x86_64.tar.gz"
      sha256 "f45ec908bd566e0f68681ee1a8771da6ec3432e7dee9573f1104e9e69f884d18"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.0/termframe-macos-arm64.tar.gz"
      sha256 "09e1ca69e5c85b97c02c4f3e1ffc24149d849daa69385707eaad1ef66017387e"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.0/termframe-linux-x86_64-musl.tar.gz"
      sha256 "371c62c0d6d7216b048da9083a40183b50ffc32a8db5f814e5aa6033cc498175"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.0/termframe-linux-arm64-musl.tar.gz"
      sha256 "4d5bd0bb7ab0d0933390483c6864904fe71a92b80baa344ae4658bf42e04d5a7"

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
