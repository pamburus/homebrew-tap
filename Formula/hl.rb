class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  url "https://github.com/pamburus/hl/archive/refs/tags/v0.28.1.tar.gz"
  sha256 "e5e748f0d39dc2a2fa4ba126c86c0cf3af9b1f61d13dd17806c11cac3fce88d6"
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
