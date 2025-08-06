class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.6.0"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.6.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ddcdfc7a717c51f09568e75a1cac02117ee3ee82599af5941346735d1ba74d0b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6d13c0c77b21c0a0508dbf5556b42edc1c42f7acd10dde8f5ba962c69486a9fd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e69078c4fb10bf1a75cc8f6cd0a52fd8aff6cab9c885c2c9cbe1f5f339f8259e"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.0/termframe-macos-x86_64.tar.gz"
      sha256 "0d1fe91bc9cddaefcc53ec10c660854d61fdb5590f35d1c746a68be8ba4220ad"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.0/termframe-macos-arm64.tar.gz"
      sha256 "f56725e52bd0caf46d2c2ab07124ebe812534bce64b1674130a27eaefafbf5bf"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.0/termframe-linux-x86_64-musl.tar.gz"
      sha256 "31db0855242ff30ac0e00f2d5c10322d1ad308ee8790b488df9c69ebc01963fe"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.0/termframe-linux-arm64-musl.tar.gz"
      sha256 "efdf844ed48c740fbf85b3385594b6102db2ea57e70c30eae6f8ecb5d2078784"

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
