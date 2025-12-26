class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.7.4"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.7.4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "02cf7a8d7ae82b847f81250791071c8bebe24abb09ed119d7fdeb2b657f59f1e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3451cf1bc570af971defea7b9e6e513eb037f618063ac8b3345596520ba0d2bc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1fc15b7bc15ee72a57ec1a8127cbbbdeb27d3d0b680a392a27a5605497b8b47a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d4531d94fbbf87a03725d9fb4be10781f01c4019611295b85590b0e8086aeb7f"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.4/termframe-macos-x86_64.tar.gz"
      sha256 "7cbc39cf957ed216565b773a3cc314040905cbf6b00dee7961f0cd250b9896b6"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.4/termframe-macos-arm64.tar.gz"
      sha256 "1fc407badc13f7b9dd3fff31d04aebddf6a2c0394a467adc277e4675eb3c8d25"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.4/termframe-linux-x86_64-musl.tar.gz"
      sha256 "8292f2be3739d72962d2e369406bd5f4287bf545dd95ce246ccc4ce0b2422c64"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.4/termframe-linux-arm64-musl.tar.gz"
      sha256 "683b6582d92f3421c21e1949c2f0cd79d079f72904a4fe67b492aa513cb29cd5"

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
