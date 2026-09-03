class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.36.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0911fac5fcf306c257d535438c26713b6186d243f13387ec937556c1e0faa151"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "80b5a50578d86627e0c275699715798822fc461eac1e18ee2d841953f94c4b49"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "88a92100c5efc96f57d081c18f24c6238f499094ebcc81bb0fc2db23f7468417"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "555e7b461028a2a9e41fd6e3716fef94006e9f87ee1c7b770b856c31c748ec3b"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.36.3/hl-macos-x86_64.tar.gz"
      sha256 "fadaf64345f0967e241ff3016058c04b5021fe0d37e053078ceb87a4e2f9a859"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.36.3/hl-macos-arm64.tar.gz"
      sha256 "613a787040fcf77026b9a0c49b9873a2f8466bf8dd40b098bd3333918d26b6b5"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.36.3/hl-linux-x86_64-musl.tar.gz"
      sha256 "28f9330d4b84339c84d7d2053480c003bdca0cc98247171185ebb1df90b637d0"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.36.3/hl-linux-arm64-musl.tar.gz"
      sha256 "b8d2a90a42ec6cd0f78b478903a7d94730a6bd0732e2bf911b03f581a508cfdf"

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
