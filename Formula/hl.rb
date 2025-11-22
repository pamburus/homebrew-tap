class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.32.3"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.32.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "44b3de5a7eda4aaf8d5ff8cf0b837c99d6772bb91ffd7e073a6335b085bee03a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "548974af5b3e104297c88579ce5503612d40b213856ca2b3da134fdd95f0ef66"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f05bd05d378790cd88a20f352120e6dd7c2ec417e7fa6bc372af34c812ec23ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ae424537ab5308f6a03b65d7a0ffb84d733e96f3163dca3633aaf7bf47fa132d"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.32.3/hl-macos-x86_64.tar.gz"
      sha256 "a410093a2a544b50e6900561bcfe95655cb8de8c75c2dda67129ecdd35d381bb"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.32.3/hl-macos-arm64.tar.gz"
      sha256 "ba8e812173ebc539501afd181dffcc4ade88a157ad4afcb5568d14b678927f12"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.32.3/hl-linux-x86_64-musl.tar.gz"
      sha256 "8b502f1a7c8b311776b0c70bbf98823f6c67502889bc420ae4e5763a5ea649a3"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.32.3/hl-linux-arm64-musl.tar.gz"
      sha256 "8d1c5f2beb34a57299ec60197d01017fa778cf5041047090c4f562b0415912dd"

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
