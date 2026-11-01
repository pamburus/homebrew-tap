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
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.36.5"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1cc9e5aac3688e41008b4393146a5f6ea70eef41e486008a025883b0ebba12fe"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "92efc8e6bcc9ad9f94f0681f4b987c8f4371195687f4f2e154c9329f07a322ce"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f3a4917a695df03c50c175c0f43c7b8d5a684fb17aefbab24c5901a8ef0b8df5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cb2236d338bd0e8aba96e2c662d7efe9f31741f9b6ddb97772f879c011613801"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.36.5/hl-macos-x86_64.tar.gz"
      sha256 "716b1092e93016c5bf7fa18a22d4faed62ca2d87c743d7f8e9de4d5d6349a950"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.36.5/hl-macos-arm64.tar.gz"
      sha256 "cd3ecd9d7914175c12e2d8137ea1b299a0d71ba514eb60a2a673917075ed3eb7"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.36.5/hl-linux-x86_64-musl.tar.gz"
      sha256 "e38e8cd156bf7db377da6ce680166d0e330a0b77ded5f41ef69696ad0e8147bc"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.36.5/hl-linux-arm64-musl.tar.gz"
      sha256 "00efdc6e1b8de38174089555f1dc3846c93db9fb9252143a10b1a91f39dba7e8"

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
