class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.33.1"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.33.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1cc4e86221ee5a0a8702a7f9901eddde3134eb85c5e4804cae8f187324821060"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "48f7b3603a381ad81657f8ab6e49cef559f363ce1146222f5bf858b427f09195"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f7d9c9a34b835a68548f5be568a7ce847ed856618aa9c19103c60c6bfe149745"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "edb89307bade3830af0052c50699d9b4a073f4b9cfa620173fb535cd55f2feeb"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.33.1/hl-macos-x86_64.tar.gz"
      sha256 "b81fe7551c08fa50f4439a4bbd24b3ec5ed79038c400e4470b509bcc8ac38236"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.33.1/hl-macos-arm64.tar.gz"
      sha256 "9f62932f37bd3e3d030fa529db277af2c858c358f5b51da5999bee9724040268"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.33.1/hl-linux-x86_64-musl.tar.gz"
      sha256 "1e8a59d424691235ea2181fd12a532a9fe93f8e0dd2c23eff7be2f3aad3b24a6"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.33.1/hl-linux-arm64-musl.tar.gz"
      sha256 "c767b9e29dc5ff7ad8b113ca4c3836c706d7b731c97041d35bc1f3c1c9fd0d81"

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
