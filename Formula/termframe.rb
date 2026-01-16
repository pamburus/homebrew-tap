class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.7.5"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.7.5"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e49832461a3b1e632a8655ca5c3dc43f877477efaa73eb5dd537e4922e0a56fd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a6f4c094e26c4082a09c46253ef905503188c160ed9797b7bf469707ae1d8c56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8b84ee506bb62b4df9c348ac6ec7f31752d3baf4ab7f85c86355062afbbfc179"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4eee2de4c54ca739e32f0b0dbab209ac67fe0128abd65a830a50d4c1dc0417d5"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.5/termframe-macos-x86_64.tar.gz"
      sha256 "8bdedd8466b724946f2685fba712cf7e2f9a39f3bb7238cee10f6f3e44e247ef"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.5/termframe-macos-arm64.tar.gz"
      sha256 "664dfa3b04e1e0f3d21b75a17ffec42f03ddeb71f39e4bf0ab72b36fbe180b60"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.5/termframe-linux-x86_64-musl.tar.gz"
      sha256 "31091d8f57e57d5165f6eb5d52edf67caf2c18fa2f62d640b73359ffb2cd2da4"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.5/termframe-linux-arm64-musl.tar.gz"
      sha256 "07585692910be77331e62bf338a6f74d9d52a06a0273d22bfb2136fb5f8b069a"

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
