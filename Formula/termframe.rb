class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.7.3"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.7.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "17a7c7ee9812ea38e3006e8b4e5b4c64a145aa497800ea77b497908139f613a9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b2c7f5561883d3368821f04cd710c80bc48ad12cfd4a8aa9b8ea1a43ea6f2e9d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fcc659daa6450e5b9edbff449be352a909333fca42152610e62e26feee9017e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b1b7b2eef5f12d60122b58be05cf662fbf263cfdec1225d3678208694ebcf5b3"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.3/termframe-macos-x86_64.tar.gz"
      sha256 "4afbc123875675144113dfeda64c6d3dba8f27d580c64951b1825cf6c076866d"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.3/termframe-macos-arm64.tar.gz"
      sha256 "4e9dbe4f60b44774370a54427c8b63c0509bcf67c421abb9f8f35db0b7477dc4"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.3/termframe-linux-x86_64-musl.tar.gz"
      sha256 "16df864ffb2276131b8d56ebe281586cab5d1b309486e5ccab75c65370133a55"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.3/termframe-linux-arm64-musl.tar.gz"
      sha256 "de62cd66a20dfe0de6eaa3fd29da7d476ed84dcec79d2f84ad373aff822df78f"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/termframe --version")
  end
end
