class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.3.1"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.3.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5ea47365f18c3333f1e7d3389b3eebf222846212310c8ea7e90dbaf8d6c2f51d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "24b47aa3b14b804e4488639106feafda65831319cce0e4672979dd144a2f18a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a87bca0889c3310f20f75a18c628c531992118f904255c57ede2d99b47a39419"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.3.1/termframe-macos-x86_64.tar.gz"
      sha256 "07f7b61d64e6328b6bdbcf32c75a511577c7abcb2d955bc22e4c3a51a65e504d"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.3.1/termframe-macos-arm64.tar.gz"
      sha256 "2c1b4fae02ff6a5d31488d1a47649df5dd008574ee5ae1882bcbdc0a8533297f"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.3.1/termframe-linux-x86_64-musl.tar.gz"
      sha256 "dcc64f0c4c60818413ab4fbe7354d2bbe150f2eb937e904ef9249dc3609878c0"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.3.1/termframe-linux-arm64-musl.tar.gz"
      sha256 "b3b8b5ad5f7ad2761128163a6bb30cb9908882f25fc95d5af43ad73384471b23"

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
