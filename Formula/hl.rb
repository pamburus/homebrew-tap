class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.35.2"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.35.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "25f3aca865f7f50803a9ecae178156fbd5c3bbc9dd7cd63987aca081b745f606"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "365a5df610b9d04acdaa66738667750b640c35448dc112d9c1acb32cd6aaa549"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2e144c50daf0540e3604be5a660445e249cf46431208985179c39918f7b63810"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7819b51eab1bf5e43988824be98661a83ab272852f4b9602066eb3899309d9b9"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.35.2/hl-macos-x86_64.tar.gz"
      sha256 "5107d7b1d91c7ba630b126b9967996559222ff1d90302acad6fec9e487a0c695"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.35.2/hl-macos-arm64.tar.gz"
      sha256 "42f6e5feffc094b41053bfa560cc8d9faee6de78664cd595bfa37f92c72a4845"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.35.2/hl-linux-x86_64-musl.tar.gz"
      sha256 "3f69afc22f274ee949c67318bd33a10ebda2b953496156534d3b1054829c70bd"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.35.2/hl-linux-arm64-musl.tar.gz"
      sha256 "fcb57f49f31918eb70874cc7574b304cf96fb6a1286b9c3096a78d03f5b4f678"

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
