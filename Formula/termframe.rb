class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.6.3"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.6.3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "667cbd6f0f9b3c24390c4fe26520f7398bfdc463a2f609eb0866992ebb5c80dd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8441a27c15e6afe24dcf6b13a47960f10a5665424c7d63da756bd99b8150b84e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fd5762c169419f285d39a31208442101f4a6a8fa7f0b3bb0a6aef22d6fffcfa5"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.3/termframe-macos-x86_64.tar.gz"
      sha256 "39a302c37cf00704b05619594aa385c8d16b2b3da8aed0ced2b35baedd70a338"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.3/termframe-macos-arm64.tar.gz"
      sha256 "a20081e91064018d4fdbfb56be00bf749b559948545e2f0da07a6f9e1b248868"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.3/termframe-linux-x86_64-musl.tar.gz"
      sha256 "00d8a5bda532d2c5863fa175c0b9ab393ca20727bfdeb7c50e48ffa1e955026d"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.3/termframe-linux-arm64-musl.tar.gz"
      sha256 "834de269245cde95a165c7314d54fc96a0b858c6be6bec09ea1fca164b241b0a"

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
