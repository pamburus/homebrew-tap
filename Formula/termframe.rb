class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.4.0"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.4.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "66aad0ff0adbef49cc86bf51e08bd9aea1d8ad4e96974b8034f4ab8ac2aa56e2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "07e5ee99c7d761658690d612f784db4e4b85123d8caece8cbfebf577d53f3e11"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ffe40ac018e867bbc34705a989646633ed5006eb30124cc6e5b87d404529e4a1"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.4.0/termframe-macos-x86_64.tar.gz"
      sha256 "ab912d115e744ca419cd00fbeafa8f7915da99c6ee5ddd75cb57629bec302404"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.4.0/termframe-macos-arm64.tar.gz"
      sha256 "f1469dceb27d180c7a09952a85048916b4a9df338e24c944521d689513258569"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.4.0/termframe-linux-x86_64-musl.tar.gz"
      sha256 "ed05bd95913e20db2a73993d37c93ab0f67fe7e73eaf79e7ab41b61045fb67f0"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.4.0/termframe-linux-arm64-musl.tar.gz"
      sha256 "85ba7f250330fb428fa997c2336ca464b27661f04c3e98d8a0d5875b88d65d36"

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
