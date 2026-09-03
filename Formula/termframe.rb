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
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.8.8"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "609ff4ba89ab4b3b023163ad66b44cc34f5e1d63bdd8af04401c0b2c6ac5d4cc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "897a407216fa8c03c7eebe6e925a9fbaae2456209d86cdf51c19792be854ef50"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a5b114fd9057a7b19ff494eca86a4999f6faa4c7a9429d5bb80d2edf874dcdf7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "30493199a3a863c0d396b515565cfa146424d30f505346e6792a500fb278215b"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.8/termframe-macos-x86_64.tar.gz"
      sha256 "577d59ea24e28aa1538581d133d0eea3a3ad225e53a11cc6fa2a3199dafadc07"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.8/termframe-macos-arm64.tar.gz"
      sha256 "b3d6f4eab84021d1c14e4914f4698c387e8fe61181b527372424fe8c44399325"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.8/termframe-linux-x86_64-musl.tar.gz"
      sha256 "ba7b191256c8418f8d89ddd0ed77558cddd850e2cbce2b5df6fe2e120e934d54"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.8/termframe-linux-arm64-musl.tar.gz"
      sha256 "63a8372c479a6a5e80c9ab14691ba669c69ade73de03d0b2cbebbac9182c05d6"

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
