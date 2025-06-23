class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.5.3"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.5.3/termframe-macos-x86_64.tar.gz"
      sha256 "4c62819a47c6f0ae320a16bd2a2f203ae2075bc6fc1a1a727d258a6113eb3eee"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.5.3/termframe-macos-arm64.tar.gz"
      sha256 "9655276639ed8af636cf6bf5e908c05b91db580514d98f8fdb1f2bbf598cce72"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.5.3/termframe-linux-x86_64-musl.tar.gz"
      sha256 "ebec57fec5db70cb5f150d49248d7c2ad7f0bfde01aff501d23728a4359d43e1"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.5.3/termframe-linux-arm64-musl.tar.gz"
      sha256 "bd982b78691a77b67965793da4c0be3690cd9c8c0efc9544117428d37f2f8723"

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
