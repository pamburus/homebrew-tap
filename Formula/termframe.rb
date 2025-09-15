class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.6.2"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.2/termframe-macos-x86_64.tar.gz"
      sha256 "d31af865b32e570f790b4cb062df53a69f20d5f40994206eed0af9f80aec40b5"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.2/termframe-macos-arm64.tar.gz"
      sha256 "fcb2170c2976e7f46b2d8fa1d8df19db923e2adefb989320a930feb93125b37a"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.2/termframe-linux-x86_64-musl.tar.gz"
      sha256 "e343932972537f2d4e31d9025df86683f9f4e58aab117fcd57c777cc36ebb535"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.2/termframe-linux-arm64-musl.tar.gz"
      sha256 "70e96eb39681c2645b09d15f259a5284c419c99741ae59cbcbdd33c89ae8d3fd"

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
