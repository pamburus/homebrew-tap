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
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.10.3"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "b5c09d429a7cbb46b64b574e3bb5705447fd03687c0ed23d163a22397e9fd7dc"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "5f026d2ac4ce910fe2a73b7cf87012994cc86df4d1f11110ccb8e8e4d1ffd0e7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "2a74c497cdde72f1bb8ba7d6649a1e788bd4c5dc443a38936bbeb1f213afe5bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "40c591a634062e814f0d84a998614181fc992b3e115b113f2cae67a6c719e769"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.10.3/termframe-macos-x86_64.tar.gz"
      sha256 "8538d4fd05a8a630b2434879ee1ec60386c25b5ca4d5fa967cb96eefb45dc7c3"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.10.3/termframe-macos-arm64.tar.gz"
      sha256 "9efe1f77ad47cc9761d7d3e9b9dfb4db12f312d2c76f1c6a4a206ee541c2da82"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.10.3/termframe-linux-x86_64-musl.tar.gz"
      sha256 "9d52820ae306ab4b8fe82b9d7ac9c60300347fe9361c03452947a89cfa7ba44e"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.10.3/termframe-linux-arm64-musl.tar.gz"
      sha256 "e010b494faa438586c80bca920348a07bf64004f506c5735c7286697de1de854"

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
