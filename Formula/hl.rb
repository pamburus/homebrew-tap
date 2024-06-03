class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.29.6"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.29.6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "f8897c60a9bf7cbcc353c7394fb25a713ccbcfd414c379b57e65da74dd8b6be4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "10887a9c8bed6cd14a55cc622043eaaaf1d7e7c7b2a7cff52cc0c84bbff8144c"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.29.6/hl-macos-x86_64.tar.gz"
      sha256 "c9b362283828f2bbad7a2096dda2729d7b26d25d18a399cca882962a8a01637d"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.29.6/hl-macos-arm64.tar.gz"
      sha256 "9f270fdffef4021d0a3a17efa003ac4657aa9ab6329f2b3f50afc53fdd516a55"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.29.6/hl-linux-x86_64-musl.tar.gz"
      sha256 "244b2682f2399e58aa83b4c7ceebaab671b4130935c11317446e1d1a30fda67b"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.29.6/hl-linux-arm64-musl.tar.gz"
      sha256 "19b1fdb3f07c4ad9a04c4db8ca8556a16908877fe03eeec5af4f9b2857ec1ec3"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  test do
    system "#{bin}/hl", "--version"
  end
end
