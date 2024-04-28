class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  url "https://github.com/pamburus/hl/archive/refs/tags/v0.28.0.tar.gz"
  sha256 "63d6c96b0cf7e60514acec3a36d025a4e429dea6b0f8a2d7d1af0b9c87156ff9"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.28.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "54d3864d86b3284acee4c8b18022267e3dcbbb512b8690954131e6eb3adf7c26"
    sha256 cellar: :any_skip_relocation, ventura:      "d3b81d68f2c02e09227039d178c98887de678f829d366b1b1706c82b99dbeb55"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "69cb679f72fd65d338391740c0870929530cc2f1c6f129bfe994ac42aee5f4cb"
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
