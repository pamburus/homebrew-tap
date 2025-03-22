class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.1.1"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d0bbdde008adf445caf484c3b4fb3e4213c7d8c0b96e2d75f2a8d66805c9df72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "113d0470eb15cbcd9b5bee026067a64ea262bfe6b531cf0fbeefa038e7e00ebe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "56a0464666d3d5372ea2016b3e10fdf8beb67acf4ef939e45fc41b378efef6ca"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.1.1/termframe-macos-x86_64.tar.gz"
      sha256 "1ff61fc8ff519e1e9de9e49ac92c13a3cc830b22c06f389fb6e9f003b16a743f"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.1.1/termframe-macos-arm64.tar.gz"
      sha256 "a9a0ee915f399674bd100ebbdc93f6d02a4c894a8285f13401ccad6dc7150baa"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.1.1/termframe-linux-x86_64-musl.tar.gz"
      sha256 "a556770f8238acc240a9ccb729d28b9e13c4f9f118a8da62592d29571d1d97e1"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.1.1/termframe-linux-arm64-musl.tar.gz"
      sha256 "c04d4690382afce3109ec7e6da6ee678ed5ef53387d0bb5ede4c8d15bb12c771"

      def install
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
