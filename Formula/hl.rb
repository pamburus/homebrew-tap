class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  url "https://github.com/pamburus/hl/archive/refs/tags/v0.29.1.tar.gz"
  sha256 "f7f8fbf3e03b20e3f48346a1f8091b7f9fb3cabe91a72a36f1744db73c15f7c7"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.29.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b199448da84963e14d7e7f6d33a8d1e1321734e20d85aba9570fce5d2f1e38de"
    sha256 cellar: :any_skip_relocation, ventura:      "1cfea8b90d3b9dc460fdc55dfe6f0c8319a9bf75bcf3d272ff9b99ea8ab53d79"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "378b334994080546a1b34b8028570f6cd0a5d0a1324e707c9023a59c2e62eb21"
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
