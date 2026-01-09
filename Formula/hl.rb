class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.34.1"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.34.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a0f4605eac70210fca493619d16afa6adb5c5d25fdb221901e2c8410659d99d4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cb42ce85301adff903f82ac70a9ede927c7a2840502e16a907de1420d7f0e8e1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a788fe191d4cc3562e53551723703856fd9a6712327a1e0d0317cd995eb892b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "25d24993229b841a8a75ab127ef25ca4b2a30c5bac7c885373a54e4646297e46"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.34.1/hl-macos-x86_64.tar.gz"
      sha256 "717fc2e1c91336856df035922276ff7a6e91c4b3818ce4d7df2a8368d18aa870"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.34.1/hl-macos-arm64.tar.gz"
      sha256 "1afff148ee9df161a7f7eb56022627e0781b246699de32020741b39dccfc5099"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.34.1/hl-linux-x86_64-musl.tar.gz"
      sha256 "d286c02eef85245469801f8bfe73d60eaedab2622494c7e8d5000e251b585b01"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.34.1/hl-linux-arm64-musl.tar.gz"
      sha256 "02d017314521113e971723f3c072a02ac197d0f3114789f2d74d75505ad66c9b"

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
