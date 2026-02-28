class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.36.0"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.36.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "593084b6382bdc357a280305522f6854c208778efecc7ce0d4444c41d5991951"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9a10a8e059e3edef08b8c3efbf4f8199bf7d465ddf9823a5a11c93a96f05744f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ae6ebb6dd623f175917b7405f8b9e8d0c3ee46e870b5a299a7812442ad093302"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3febcd9de662f3f618127de4d84520ebd2dc82bf58a004a7559a6fbbe1b90180"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.36.0/hl-macos-x86_64.tar.gz"
      sha256 "6db48b801515f7ecaeef34ca7a00f84c9a5ed30d03158ef469a36d6e1cc04d79"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.36.0/hl-macos-arm64.tar.gz"
      sha256 "0586fade398396b8da035a4a60fc05a5160e01fd4efe1c775e355f1d0f696652"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.36.0/hl-linux-x86_64-musl.tar.gz"
      sha256 "e99f0e9c7b8605b68aafe2ce51a9d851e12569c487b94853f08e4521bd64fa3e"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.36.0/hl-linux-arm64-musl.tar.gz"
      sha256 "b449f456ebfff106ab97500725d9b8adb466f780ef5d1a9af8ba578b1b9502d1"

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
