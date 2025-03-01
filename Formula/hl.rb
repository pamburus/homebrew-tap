class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.30.4"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.30.4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "3e444f1e66528bac0b6d6fd69befd4dd9cec80ffc1b463be05618f6ef1caab84"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f1e38f2316844f35b7045d561b7cc5c6239c6d47a579686665943dd3886823eb"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.30.4/hl-macos-x86_64.tar.gz"
      sha256 "d6b71aefa11436ca8ad51979c746143a46fb66b66f5cae63b6a0d19e94686305"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.30.4/hl-macos-arm64.tar.gz"
      sha256 "8e301107038f37b1d27918b77c348458c9b58e934f42341ccd901b88642ab3b9"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.30.4/hl-linux-x86_64-musl.tar.gz"
      sha256 "fe0b86220e1ccaad75fd8898254efac0a39e61ff187bfa6e68b43fe17859ae7a"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.30.4/hl-linux-arm64-musl.tar.gz"
      sha256 "199e130f14392716297b77a77ef471c024a324b1530c5c095ce4240946c35e96"

      def install
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
