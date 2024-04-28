class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  url "https://github.com/pamburus/hl/archive/refs/tags/v0.28.0-beta.1.tar.gz"
  sha256 "46a420bcf62f5bdbf327e3b8345504595b46cb0747e9ae6d819f013d3cc90d34"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"hl", "--shell-completions")
  end

  test do
    system "true"
  end
end
