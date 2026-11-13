class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.10.1"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "59e81b545cf22e26b366344a7ccfd477d348e6565acaf7e8363f20f7d86f969b"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "689e609c2ce3042833094913a4424f6a740edcbab98fa52ff570b22d961b8253"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "f78d2aa8eefac049a8bbb1e27af2ef7c142157415d7ab4fcc514ebaa84ab617d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "7611421651dccf5f6c8573d5b52398029deed4388acdfe65a73f98393f10fb28"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.10.1/termframe-macos-x86_64.tar.gz"
      sha256 "e15ad5c2097a18df8147d092962ce70d24683076b4e7bafca79e58688b0e1e51"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.10.1/termframe-macos-arm64.tar.gz"
      sha256 "5eca199789346988349b04869c4392ea6909f210a7db29f323b13a9e95cebcce"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.10.1/termframe-linux-x86_64-musl.tar.gz"
      sha256 "6531eb5ed242d29499a9b5035110d0fdb8b0d002691552bf05a87675a475039e"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.10.1/termframe-linux-arm64-musl.tar.gz"
      sha256 "af30ff204f14c995bbd1283570d2775344e19b99306f679d4456e2ff84b5cdf7"

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
