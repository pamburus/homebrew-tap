class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  url "https://github.com/pamburus/hl/archive/refs/tags/v0.27.4.tar.gz"
  sha256 "f1a6420d7fb0d049ddbd39e6844afe33c625f7a43816457219c4a8efad5c4c7c"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.27.4"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "35efd4cf60a3e02a49ab078645901510c3cc3a22424aa3af23c879520d313d0d"
    sha256 cellar: :any_skip_relocation, ventura:      "3f0658a8f97fd3f8e9c8b3185c0f20284b3e72c88bf4c0aee08b99e441a811d4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e0417cabf33d04d4554cd701811a25181333fc1e829b2b1355d406ce24867667"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "true"
  end
end
