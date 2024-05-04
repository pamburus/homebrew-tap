class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  url "https://github.com/pamburus/hl/archive/refs/tags/v0.29.1.tar.gz"
  sha256 "f7f8fbf3e03b20e3f48346a1f8091b7f9fb3cabe91a72a36f1744db73c15f7c7"
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
