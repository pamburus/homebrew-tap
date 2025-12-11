class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.33.0"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.33.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "51e1acd5352fbe2e8562d6dd5e456b5a8b6b2450254a3151c7f12e60580336de"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "91c6de825722e793a7f2b716500d53ebf89ea5ce5e50d57603627f2eeef84da2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "eefa3c43dd542078fb13e84b3cf5fb0479b6f5154010a96e89f66809bc5766d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "76036234728cecf324fb1f39b5e2fc065717b3b9ca0bedf43b42dff6c9406841"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.33.0/hl-macos-x86_64.tar.gz"
      sha256 "f885c4de17a4ead0624ef35f9c60e296a35cd117f70c1f96e8f0baf13a88429d"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.33.0/hl-macos-arm64.tar.gz"
      sha256 "1048df59582395d7f79191d7c11fdb55b3c3737520d01dff505834fa1462817b"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.33.0/hl-linux-x86_64-musl.tar.gz"
      sha256 "5a973786d412f67a70de53eaa9c7061e9c7edf69fb2d21454ed0551f8b7f0bde"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.33.0/hl-linux-arm64-musl.tar.gz"
      sha256 "1404a6f0d029541a3e443df890997893aea49623b5e7afc2fe5113943bdb78c2"

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
