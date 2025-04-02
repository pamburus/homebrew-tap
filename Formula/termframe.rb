class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.4.3"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.4.3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ec12cf18d5c5c83f4dc71a5ec4110cf1e2a31332ce853674f7eb2424ad2eef5a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f6ada340d1528073cf58e4c31f92f8b69b643d0a492e9d1417a3906017cf7779"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "827aa3dd0a84c0a7db74a8f79821708b38ef227aff93d3bf3444964e20a1f1a1"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.4.3/termframe-macos-x86_64.tar.gz"
      sha256 "fb853ea9a5f8a298c084f85b4b4d969196c9987ee917afe6303216c4bdc2b80a"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.4.3/termframe-macos-arm64.tar.gz"
      sha256 "b16e988d9106d501d4e628aec5f14a061eecb8ff31263a88cc831a0a3a07b3d4"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.4.3/termframe-linux-x86_64-musl.tar.gz"
      sha256 "51674d9e07cdb753838d6d33ce702823e1c1c39c6caf4ac44456ccb7df10c271"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.4.3/termframe-linux-arm64-musl.tar.gz"
      sha256 "32eaf86f8ce6ce5a3ae3a9a5c32ce8b9f9d12ae5eccd7608f0b2febf34f26ffb"

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
