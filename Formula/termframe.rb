class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.7.7"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.7.7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "21bb31382449a31871f6249bcbe12067c198d7d619c1d59c2c805f79c6b8d1a8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b79c93bb9281fe9c84690107846ca0b3218baa660a017217cfeedd7326ca8878"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e399a2f51e401cd0b2cda36171c81fd1bc869b53e2066e017c32319681c6a409"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c13ed58f02c48fb36f1612026d206a5d70a901f297293f3e297df6eaf7d64e4e"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.7/termframe-macos-x86_64.tar.gz"
      sha256 "9c55eed40319c78bac2eba1791e9f05ab700632fa4f3796e8f22ca3a4ab07391"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.7/termframe-macos-arm64.tar.gz"
      sha256 "c587d0969a8fdada7ce644ef623955656a8c77b059089e8561823226830d4495"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.7/termframe-linux-x86_64-musl.tar.gz"
      sha256 "d97a2bf28d53378fa6278b3ee21e315983a0aea3f1350d0b5ec1ae650c96497f"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.7/termframe-linux-arm64-musl.tar.gz"
      sha256 "8ea2221b4b9ece827166f00fb15b4774fea1a507d4f38acdf2d5de7ab32e4448"

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
