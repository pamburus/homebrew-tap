class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.5.0"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "318e14c365d8d752f3412bd28115b6aef969ca579f601c597dc73fa81cd746e5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "758540fb1b688fc0a19782ee2e8d93b80d533e87994319cdf95765f023c55dd2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4b2c5ad71687d63bc0e074ca7ba5e611e7106a1483518f15f09680295b8b8235"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.5.0/termframe-macos-x86_64.tar.gz"
      sha256 "9e78c347b55227986f60830a18f6d5be964d5474f6911c999f3d9b83d2a88a4b"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.5.0/termframe-macos-arm64.tar.gz"
      sha256 "d35d4cc313697360b4fb20b1ac90697d0d643ff80c8207823d4e83c915a9b409"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.5.0/termframe-linux-x86_64-musl.tar.gz"
      sha256 "ce1eb946658ef72d16e0d4df45f45ab1169e1194964d9200fe5e45ed265dcc84"

      def install
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.5.0/termframe-linux-arm64-musl.tar.gz"
      sha256 "64b9bad0bc3eb8a05202ddd5f12bb8e6b3115592827b01ce9523caddb8fe354f"

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
