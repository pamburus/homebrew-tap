class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.6.4"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.6.4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a2fadccfef6c8fb651285bd83b160c05ebe40f29766f1c05082462b2131f2de3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "94e32562721e13b53fb8c2c693fe14856fe04562787e709a7d00f5d1d5d54e24"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "45fc6cf36618e0e13d47c2e5603788fc9d661bd79e86454f07c9c6da0d552501"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.4/termframe-macos-x86_64.tar.gz"
      sha256 "8c209f3d4f5fc150f3a5e97c4b911e78b46b74411d2de44ffcf8fa398ea55cad"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.4/termframe-macos-arm64.tar.gz"
      sha256 "8ce816540cfb2a7026ece4e7bbe5b1a3ea9c5b7aac0ab180d7c72c3fb3082cd0"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.4/termframe-linux-x86_64-musl.tar.gz"
      sha256 "5f4bf5f83f5437501ff3a4cd24bc70493f89a93b8938696b0a93eb7388da77f1"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.4/termframe-linux-arm64-musl.tar.gz"
      sha256 "b943f8b7f56010cdab2df9118b204d616fce51e62b8aa2cf9326d11ad037e836"

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
