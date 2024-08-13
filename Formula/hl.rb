class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.29.8"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.29.8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "6f9e814002498b69e24c1c22657de393b5f9a06a29e11d16f33da27590b61fab"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f42bc17100fbca95ea9bebe77bcd8ffe27887a081240c5ce212b7995d542a4aa"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.29.8/hl-macos-x86_64.tar.gz"
      sha256 "8c8adcb1743f3a2d45988d5488da46ef6f359d71d9befe9413b5d950e5f31cb2"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.29.8/hl-macos-arm64.tar.gz"
      sha256 "39a0e0e414ad8174b102d1e43d58d40ba9f2709e37b406fa0871ca101d99a066"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.29.8/hl-linux-x86_64-musl.tar.gz"
      sha256 "9bda9da7a7a9d4ab93512756d8f44672afcae20c3f1a0914c121af441d56c00e"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.29.8/hl-linux-arm64-musl.tar.gz"
      sha256 "055ae761b8cd80bac5e0fc8ae305a95c61af3d65148e8ed1349143f7d2a574b7"

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
