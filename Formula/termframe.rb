class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.6.1"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.6.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b0221ee0f54f735a8782e32ddc5fcbf7e18e82dcb08024c0b5f6fa5e375b8bca"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d25e85abde87f95253bac1d4fc4ab172007dcd6433a8d26a3a50b92a957e0f9a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cccebb4a24de9e63e8ef985330c636c5e287f1747855f11d73eab66f793dc3f6"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.1/termframe-macos-x86_64.tar.gz"
      sha256 "d57d9aa7d33507ab1f343bffa9f66389d966584f9b142ccf2457bf311ecb84c9"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.1/termframe-macos-arm64.tar.gz"
      sha256 "57a3a25688b6b94088502e6b346a7212ee2a1461b1d0b5b15b03836239e9a69d"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.1/termframe-linux-x86_64-musl.tar.gz"
      sha256 "5129f0053f9875e72dcbd762f4c0a7913cdea2822e2f3b2ff6f6de53b1dbba00"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.1/termframe-linux-arm64-musl.tar.gz"
      sha256 "9359603950a961a2b82e7f49c72592a36d699ba4ba048abacc38fafa09b7db29"

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
