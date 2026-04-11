class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.36.1"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.36.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "766552e59d41505eeb4aecd3c4e6ed2773edfeaa8addad6b3dbb19f8d8d9f51c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d94a6edb9f990aac699ec54d21babf4e1a39cb9910d680c06dd5737cc00eea49"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a1b1d861ec5bda4ae36f39d34d39a25761c769b791f01d56da902f84375b4142"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "563272b20a42356cf0646b689b81109e1fd4e6a53ad1ad8795119b3841b0f3c4"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.36.1/hl-macos-x86_64.tar.gz"
      sha256 "4aa1d05a5d5f10166b216508e3ece36d802f7eaf2805d5c77307614e9822feaf"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.36.1/hl-macos-arm64.tar.gz"
      sha256 "aaf117db454f1a98da75a3435afbf53b609cfee67389cfdf2b5c3eb6b8163aee"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.36.1/hl-linux-x86_64-musl.tar.gz"
      sha256 "f7a78f7dfc10c46f32eb1e249a4717fcc88994e0f0581743c517c32d94f7b033"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.36.1/hl-linux-arm64-musl.tar.gz"
      sha256 "19a6ada79c6dd88621bffbeb3ba63e05893f935c2718d61d42501d61cbd88391"

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
