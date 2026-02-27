class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.35.4"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.35.4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9134967e38b6ba6ef90d22c4a6ba23c34f636f2ec7d18a7cfa91deeb8e1da0a2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e60c5b4c7ba1ac6f767902eeb923a820055719e8a11bcd325d5e0aae65944794"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "530824b61bed7622b8d8c0df6080831c010e02a43c2f5697721ccce4218b8fc6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "69a8ba94f3bf3b38a2ebc76666e5407ca6348cff7c2c25e420df3a5acd591fec"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.35.4/hl-macos-x86_64.tar.gz"
      sha256 "5d97f5b83f6725624f8ccf21e97e1d1ea81249cbbd305593f401d86d4e7cabf7"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.35.4/hl-macos-arm64.tar.gz"
      sha256 "ecf6ace0e8d2b370f1e1d76764963b23b45022b3acf0be86422388c0fe9a8f78"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.35.4/hl-linux-x86_64-musl.tar.gz"
      sha256 "1c18fb86b409de21fe9ce0bcb3dd631c11025b88d1e66ff9362ec5dd7ec45f69"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.35.4/hl-linux-arm64-musl.tar.gz"
      sha256 "a11598aa13db0d86586b216786f43016c2d64e5507de3a005145f6ddba295c7a"

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
