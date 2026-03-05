class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.8.2"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.8.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a19ad0345b90c9d690c51dc29fb7bcc1278e1749815d51b52d58a3c01753af79"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6d354052f279845cb3509326b6dc76a826c5ccda7bdfec68b655eabdb85febe7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "523c867d988479b673c7818359f2b970b6e4fc0a92361034491b0830dd0ccb0b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a9d8d20860ac21254b03bfae9074190f2ab43c02f8327d134eb0924e638fe347"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.2/termframe-macos-x86_64.tar.gz"
      sha256 "e242d7556d5e6e2eaf972194a601ebbe4b78b845f251699081227c0c03914b32"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.2/termframe-macos-arm64.tar.gz"
      sha256 "5ebf67f05b339535b522c3eab5e9bbedbc729246bd7bbd6186741b6ef4a8e30e"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.2/termframe-linux-x86_64-musl.tar.gz"
      sha256 "ffdab6542e742632ba58e0735f77e25f705be62db3003f7760f6e6bdbeba076a"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.2/termframe-linux-arm64-musl.tar.gz"
      sha256 "a51b38780d9eb81217b7df5db8bb940dc5b51278838d1c6f46a0780b7963f406"

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
