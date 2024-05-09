class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.29.3"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.29.3/hl-macos-x86_64.tar.gz"
      sha256 "416fad003e54e901dccc0930e159133774c9c6a2798bee6afb21404049fdf433"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.29.3/hl-macos-arm64.tar.gz"
      sha256 "d8e8bbe64c81f1a48593661f8da860b6a1c2943e564bc7152647625a47794ef1"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.29.3/hl-linux-x86_64-musl.tar.gz"
      sha256 "96a7bfa17c5f97995da97cd1ac1db242d4b475a2d69ad47a9ea319e93ff5e609"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.29.3/hl-linux-arm64-musl.tar.gz"
      sha256 "893cfd4929bcb02f12efb2eac20ecaeb2a8dcc20340bd86a86e63535e0f39ef7"

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
