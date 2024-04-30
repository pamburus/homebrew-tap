class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  url "https://github.com/pamburus/hl/archive/refs/tags/v0.28.1.tar.gz"
  sha256 "e5e748f0d39dc2a2fa4ba126c86c0cf3af9b1f61d13dd17806c11cac3fce88d6"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.28.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "66843d546897a0384f04ea3f4e27f4c5338c2558e790b549b3eb6927b4a870ef"
    sha256 cellar: :any_skip_relocation, ventura:      "f4d2c977154649a5e0037e119bd9194703f56e5cc1daa04a8d48dcdd12e5ed3a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "aebc0aa963371ce117bcb561bba21482252e05277124d9699d186ea4ee2a24ef"
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
