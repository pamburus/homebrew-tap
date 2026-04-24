class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.8.4"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.8.4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fd100a7ebc2a6493f4c3326c7f912caaf0e4d8748b26d8438b0d6e8911becc13"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c40edf611c9ad7e30bdc3636ff8c50569a718fa2559b47a6533b70a886b4bc70"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e208a2cea3a41f25b2c6c1dd91e9c889e8289f43ed151f987da4b18990e26b6d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8e805d47c112163529b3b5554f24eba690a879315bb3f6bbc4e8e83f09e6acb1"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.4/termframe-macos-x86_64.tar.gz"
      sha256 "70f11aacd538065b8a4e414d94d968c42a3d63e2b7c707abf3e8e1c582b80f8d"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.4/termframe-macos-arm64.tar.gz"
      sha256 "97714a0f0a3383f719b46a6d5a49e0c326b05082226a74824fb463b8ea86c745"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.4/termframe-linux-x86_64-musl.tar.gz"
      sha256 "e386c36364c6947a88f41259e1ae3da7ac6308b5232c81344aedb29c047a2e83"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.4/termframe-linux-arm64-musl.tar.gz"
      sha256 "cae317110428b63926e66980bc34837c9d82bf86d2873d7b2d06543023d83e56"

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
