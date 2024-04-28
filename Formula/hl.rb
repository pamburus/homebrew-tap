class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  url "https://github.com/pamburus/hl/archive/refs/tags/v0.27.4.tar.gz"
  sha256 "f1a6420d7fb0d049ddbd39e6844afe33c625f7a43816457219c4a8efad5c4c7c"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "true"
  end
end
