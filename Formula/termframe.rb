class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.8.3"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.8.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "cd0b1b7e8c0742c579b1e90f553cd208c2b88f44494f083175faa27b70ebb17f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1ab8f915fdd038bda474038fe66079d923f236ff96a023b1aea4b10198b66cc9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c368282d06a66f58dc598e4f439fae041778464422f179337440dcb0bcbd0f81"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "06542058b4042b88ec4634a4c6c1e651ad2687887b51208e0a6fefd91eb46a2c"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.3/termframe-macos-x86_64.tar.gz"
      sha256 "3b808610fdc80bcaa163da3d5f211e7bfc10136e5eca451c6b1c9a4a7370914b"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.3/termframe-macos-arm64.tar.gz"
      sha256 "fd522e041747f8c0d3464168cbfd1ad649855b222e1011a9f51367536e989175"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.3/termframe-linux-x86_64-musl.tar.gz"
      sha256 "760302c17d8f5583d1ec8317b26f66d37aadd1ebb8e91ffbec03c69168c4dad3"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.3/termframe-linux-arm64-musl.tar.gz"
      sha256 "a6ad458d2a4d51dba7fbcc118261b388a7e37fa4bdaaa857f6a524cdc1afdcfd"

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
