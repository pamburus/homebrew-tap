class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.31.0"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.31.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bfb2d9518dd5ba6d6dbc043d079888ce5f95958496f3629f095df83aff0b2aef"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fa6b7890e9ce182aad85c839773bf283242a48e1587c0fdc63576b3c1cc95733"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6edadc6fe3b30310d33667e97eda9074af65d71065861d33d14a58bac0fe19d7"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.31.0/hl-macos-x86_64.tar.gz"
      sha256 "6d25375ddedd2326b5a3a89e0d23f49971bbc936a4d843ddfd1b1e61fc61223b"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.31.0/hl-macos-arm64.tar.gz"
      sha256 "e057440f790137bfd9cb49083f7f5d72dc7750a78282ba31c4e9f19120d83adc"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.31.0/hl-linux-x86_64-musl.tar.gz"
      sha256 "75c073d8450f6bf7f6d99de7b7221407ea40af5d94f29f295bb80faa9e6a9ea5"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.31.0/hl-linux-arm64-musl.tar.gz"
      sha256 "d090c6016c5781a8d71994c88396f384364a7f760654ff4730616374825571b3"

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
