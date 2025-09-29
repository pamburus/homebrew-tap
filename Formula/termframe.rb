class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.6.3"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

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
