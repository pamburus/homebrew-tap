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
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.9.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fa9c233375c2064c7e6efa5390c1f3bd4e204141db5788f47756632d9f02e7ee"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c9658018bce3c8fdcfc7d07887cce053eefe2e27b18add209613a01b6fdc9524"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6fd82f9e0d6aeb2e148415eff5bc0f5f3ee2847397606453b0174999367bdfe4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6f964c158ce781f5a9ca62985117b3753681e2f28a6d06e586c441746321c3f8"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.9.1/termframe-macos-x86_64.tar.gz"
      sha256 "acde7bd8b0449195de73d853c0ab4fbc02563de4bf543f2f49c133f701d75926"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.9.1/termframe-macos-arm64.tar.gz"
      sha256 "21641caff0070c9d02fa9ec3c2ab7ebe241d6dbbe00fe8fbc176cc792f0068f5"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.9.1/termframe-linux-x86_64-musl.tar.gz"
      sha256 "30ee46984af8d089f31748592c45ac3d68b5200049183ee426cc5a3b8873653e"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.9.1/termframe-linux-arm64-musl.tar.gz"
      sha256 "4d4670e1e4c5e474f60001974f2cc18b91ca4b810b8373c1c3444cfe6559532f"

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
