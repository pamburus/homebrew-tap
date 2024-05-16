class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.29.4"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.29.4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "040fec2219fa7b47dfde1ab0b6c02f77c763825e9d053d4ebd8590d79cdefa9e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4feeb91746b76e54b589a4dad53267cdf3943ab59f6629d199f309ea9a397eb7"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.29.4/hl-macos-x86_64.tar.gz"
      sha256 "230826871f5fae36769b5661ac20a9d5de4fddad98f54d585037f78244cf2f6b"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.29.4/hl-macos-arm64.tar.gz"
      sha256 "a674568138d144266a3f7b68117a9ff265ef8a0331fa889b98ded9ed1e5d82da"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.29.4/hl-linux-x86_64-musl.tar.gz"
      sha256 "6b8d7975fa7f47041298d1d609386f8ddec8a60727de453bf526669a86a90671"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.29.4/hl-linux-arm64-musl.tar.gz"
      sha256 "6c6815d76e9ad80b5d3691bc45f571e1e49640e6e76058f32f425ee6bc1d19d3"

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
