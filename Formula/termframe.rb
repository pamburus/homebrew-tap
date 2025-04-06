class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.5.1"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.5.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a09f239ddbeaafe39bcccf880dce1a363c0d7903eb8d66de05027e619b9c6c1a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "02ec2ddffc5fd731a9e0eb1aa99a0854e1bc811e01d2575a5d3f1c1e9a67ca7b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f3d6556136e98108839af529a2cd80f938f0c7684051cf413c898a564be0924d"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.5.1/termframe-macos-x86_64.tar.gz"
      sha256 "591d3b27494164f46ed5a6fb239a08c99fe6755daf1c106ebd371f67ed9345a9"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.5.1/termframe-macos-arm64.tar.gz"
      sha256 "f29577fe4478d8feb4689dcb8c73df16e914aa718f7c3652ff8edd953f870d4e"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.5.1/termframe-linux-x86_64-musl.tar.gz"
      sha256 "8eefa2029640730898bf08163bb7cde764923b3662bc67ef15e47c3a953810e9"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.5.1/termframe-linux-arm64-musl.tar.gz"
      sha256 "518cff1dcf786f6dd081f8b2582f57b3b197a26921b0b9fa80e47fbf6f1def81"

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
