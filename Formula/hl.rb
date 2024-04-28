class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  url "https://github.com/pamburus/hl/archive/refs/tags/v0.27.4.tar.gz"
  sha256 "f1a6420d7fb0d049ddbd39e6844afe33c625f7a43816457219c4a8efad5c4c7c"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.27.4"
    rebuild 1
    sha256 cellar: :any_skip_relocation, ventura:      "6cc299de96ccbb29e981e26e1d4a887453e6d7a80ca1e34bfda300ac51a6a108"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c10f29eea1ade7fd418223a9e9681c3fbaf738c11aa172a9b5fe13d610ca5cb0"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "true"
  end
end
