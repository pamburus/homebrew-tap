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
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.10.2"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "202878bf14077bf8614feb21340285a125927725cc1a39afcdee32ec6c539f98"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "164fc028e6bcb2dbc761f9a2ebf53e9e420a076128b098613eef816cc57fa5aa"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "1987203da65f27209a0a843451a12693ee5a6cd82d1db87189086aa71f520c40"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "cd197d46b18ca8232eb5fbdaaf1e3d028f8009ab6ed5d423d4162270bea8ab2c"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.10.2/termframe-macos-x86_64.tar.gz"
      sha256 "fa4151a38583ed2fd4cafd5ddb25c0164c534b60be1b6cad3f247b5cbe275959"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.10.2/termframe-macos-arm64.tar.gz"
      sha256 "d2637e3efe47f621a7b0a6c7a67fd38d01479600d4e5937f46f6127356ff6ed1"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.10.2/termframe-linux-x86_64-musl.tar.gz"
      sha256 "ab36a0fa387d761e7a82a88d9f65396de0e59245c2ea2071b111fa098639015d"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.10.2/termframe-linux-arm64-musl.tar.gz"
      sha256 "bef3897e2b622e3fd31956c05b6cff376a9619af5b5264928b1cd9c63f331871"

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
