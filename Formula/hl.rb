class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.35.3"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.35.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "33ab516df9e50440fbf902441469a4f290dd32a8d9f1ecb2fbc6437b94205687"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e0492d257a2398d981a60a874c717d3a6cc3e68a668e4e4f11c9bae5903a43f0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d312f34ff24a7ca23e753df02621bd47a93949f945c63dc95d151611ff3cb339"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b0cfa0e1b10b333749b9fbac5d58d0fe3e1912c2050f5dbd86c6a17da6130d3b"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.35.3/hl-macos-x86_64.tar.gz"
      sha256 "db70cc646756896ac6803910fe0b8edd817b74b2d44106a2651f4ffbe9ea2676"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.35.3/hl-macos-arm64.tar.gz"
      sha256 "2fe1ae1b36f1719e3dd78193ece50756800b48e31c53624baa152168d7df4fe2"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.35.3/hl-linux-x86_64-musl.tar.gz"
      sha256 "9369bddb10207acfa0893def7f5d8db481e3f0c1ff2f3398cfc866c6babf1090"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.35.3/hl-linux-arm64-musl.tar.gz"
      sha256 "03946199a99c14514cf451e9e6d2d33a08cb66f36e177ae263f8673a872edada"

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
