class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  url "https://github.com/pamburus/hl/archive/refs/tags/v0.29.2.tar.gz"
  sha256 "f8bf6f6f1917e7cdcb90b1b645a2380a37e021b8fea6b1bed6c1d4fb38689eed"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.29.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a465d69acdea1c4c6d9a0e19ec1e2074b1dee3cf3066e00fd95058da8718dca0"
    sha256 cellar: :any_skip_relocation, ventura:      "e27ddc5de15c4712f5e16c166e34aca84cb8d9fda20900ac42dfd9632ff8e9bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "98544dda6d7f99086caa32c4872478afaf4f6b5a2cc02514ea89dd121aecd877"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"hl", "--shell-completions")
  end

  test do
    system "true"
  end
end
