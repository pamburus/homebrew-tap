class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.32.0"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.32.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "50d4a61aeaf91f99634a94c71cc1b9c47022963e6126d0c609eb4d13f616c232"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "885f67efc84b6e41be88de2c6378d7fb8ce11c2e18ffc33cdb8b94da0900abd1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "73c41d2db172e3e2cffc125ea549b72a3ca1e22c49606e4a623e26b40d905d4b"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.32.0/hl-macos-x86_64.tar.gz"
      sha256 "91c7f5f14b3a28a0337614eff7c6ac84d4c12510ead5d044273b493283949eca"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.32.0/hl-macos-arm64.tar.gz"
      sha256 "d6b5eb91f12c90d12b6f54dfec87a9c9ead43ecc9027582947ee4849c2424dc8"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.32.0/hl-linux-x86_64-musl.tar.gz"
      sha256 "36f6ad1fb279ff18ddfef9a113a08a7ba0480b5edbe3e010212d8e3850e05310"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.32.0/hl-linux-arm64-musl.tar.gz"
      sha256 "95b98917d10292c08bfc0d10332b13c908cec152e2e21c8e074b85ce9600d42b"

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
