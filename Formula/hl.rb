class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.34.0"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.34.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8c65641ee8aa1ba905c1ff868b360a41189fd1dbc8b25d5ca6b97f3364177df2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "dd7e444550b08d49823a663a986d4d3b64a92f36d57c30570133d02af7d38484"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2fee970d1a40e79cebbbb8df3c22d71ee9f84b49aff8e0864ef64d8ed7c6630c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "505e01d57c7c9030046d94c1596027b3fdb71b20c553b6c542ac8b1e581a4ad1"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.34.0/hl-macos-x86_64.tar.gz"
      sha256 "f45b1cf99ebc538f74a36600b07cd18b4d9dab77596e8ae58e00145f28790883"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.34.0/hl-macos-arm64.tar.gz"
      sha256 "91e0443fc042be8973222d77fbe97ab6ea18355d493d9e4fab3add7311e5fe6c"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.34.0/hl-linux-x86_64-musl.tar.gz"
      sha256 "21d67ffefad4b4a08fe9d3fd249f501090abcef8b8eed6485d67abcef6732ebe"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.34.0/hl-linux-arm64-musl.tar.gz"
      sha256 "61d62ade26c04eae3dc5dfddb7c36e1c7b1449344dc1bd0970def059439d154b"

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
