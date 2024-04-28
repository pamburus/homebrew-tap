class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  url "https://github.com/pamburus/hl/archive/refs/tags/v0.28.0-beta.1.tar.gz"
  sha256 "46a420bcf62f5bdbf327e3b8345504595b46cb0747e9ae6d819f013d3cc90d34"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.28.0-beta.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a76aea1aebcfb4d64f57af824d2ed5155a174d99b0de0027e3cc7f7a69110798"
    sha256 cellar: :any_skip_relocation, ventura:      "482da35bc753cbdd956969b11a2ec3fe4bed9db69a8928e978f9aa2a34af11f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2f926dd87b5899ed49d40de33ff6bf53aebc248084d4962cf507665d8c65368f"
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
