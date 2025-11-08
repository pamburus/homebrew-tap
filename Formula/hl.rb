class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.32.2"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.32.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "38fab9f8b80e8b7b1d323c50559f992c4ca03a2f27d3931c633289b33163c0a7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c40253d285ad9118923c70bd1ec485f09118965a248cd06ccf31ff369984d61a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "676fa5b349cabb21731ec4b276c8ce507bdf69212527d38af9010052e10fded3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7fcc5cdd9bff0bb6d95969341d0d56189911e4dded3f30a27dc8f0f31f222190"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.32.2/hl-macos-x86_64.tar.gz"
      sha256 "e34838cd2aaca2bd89a3ed6e7fdbe90d0ca8036398155f8bc53626da3a0c4e0b"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.32.2/hl-macos-arm64.tar.gz"
      sha256 "068cc6b08020da039a1e250b02b716a8c3b6dccc6a0e6b2921721f23883d4cc8"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.32.2/hl-linux-x86_64-musl.tar.gz"
      sha256 "ea311a8b2ad4f191168a86247f427af47ff74bf245ddd394b4a80d9f547af541"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.32.2/hl-linux-arm64-musl.tar.gz"
      sha256 "f209f3ac81f996e284ac2f18dd18fb58e41d43a7d9b6e62e0ef73868db069340"

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
