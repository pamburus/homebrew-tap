class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.7.2"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.7.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b7689e73e9aa274fa4c52c019d7c8b7ff7521a4cbd6048bad21dbbc8b98585c2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "17f0bc44275ddd514248f09b8f399120289580e469fdea6b501e73e16f0426a6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2592373b572c0b7a0a43dec199465777bb61f614a63872c1564a886e0af271f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d0c9cb74f6b8ffda3e07b96f19d7f21a3b113700a7c3ac9a680f8ed7de990739"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.2/termframe-macos-x86_64.tar.gz"
      sha256 "8a3ade5dee4f4aff7cf7654da5045164d68eba0b30728ff6bf46e6760e7b9625"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.2/termframe-macos-arm64.tar.gz"
      sha256 "fee3e5c0262da79a7e80d27c37af199ceebd836f04b491e7371076586fc996e3"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.2/termframe-linux-x86_64-musl.tar.gz"
      sha256 "759525223e2d39c1103cda6bc1f95f52dd6a71524a0ee7e66f2bb1f72d46a813"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.2/termframe-linux-arm64-musl.tar.gz"
      sha256 "ae8ced3442786bb830909f929100e9c3f36c5cc2d671de91e405d49ab5bfa3fc"

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
