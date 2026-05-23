class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.36.2"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.36.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2a7d5b4762d4ce1d7d621241eddefd39a2870cc3489aaa5893cd3fdab8c62282"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f228dd71300d4eabdbfadb4d04a4199889665d5726169f4c7cd93b7695ca9d68"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a9a0a749b56e82e156de02c75352ed9bd75868a5be78006c0d67b808239b73f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "62975793d92eb80bbefd4719abdd9e8fda091e97294babdd5f1da2f70f89e770"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.36.2/hl-macos-x86_64.tar.gz"
      sha256 "d3c3821f74a5fdfc9a81361684365cb4f5c925f1e40c5e5baad3c4b6e34b0919"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.36.2/hl-macos-arm64.tar.gz"
      sha256 "826e6d1b1a048ec5d96007f421805fe7ae650ff92ee720ea4d9f0b5a247ff69b"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.36.2/hl-linux-x86_64-musl.tar.gz"
      sha256 "a89c9861bc3d1892f54247ddea75642b39a4f75bc3fc49b7022c4ce54c6962b7"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.36.2/hl-linux-arm64-musl.tar.gz"
      sha256 "758f5add3113cccc527300429386e7638b72fc4365e1bb38ab1e93a1a4b26bdd"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hl --version")
  end
end
