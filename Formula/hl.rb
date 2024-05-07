class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.29.2"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.29.2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "0e17415672c7f7bcee1c858dbae36b6a450688d271e03f30be6a7397f390745a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "46d6d09e2f4afddd2f85fb0d55078e7ee56dc00549558bfc48085bd837f5ed5c"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.29.2/hl-macos-x86_64.tar.gz"
      sha256 "a5ce909baad2ba125deccb5426e891d6e47def1756ae871a219e337c9fcbf094"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.29.2/hl-macos-arm64.tar.gz"
      sha256 "638748cdd8f344db9e51ed486b863956139a9581b42d8c6ecd15c22176865cb9"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.29.2/hl-linux-x86_64-musl.tar.gz"
      sha256 "7637f4b0616b810a4883ab7f29cded16c1099fcbb3ba767f2e1ae7f82f9fa237"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.29.2/hl-linux-arm64-musl.tar.gz"
      sha256 "c30affd547b5bc33ac8d7f2d9b3f3728af29026d27409e64fb33ba7912874012"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
      end
    end
  end

  test do
    system "#{bin}/hl", "--version"
  end
end
