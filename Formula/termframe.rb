class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.7.1"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.7.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d37a7fd9d3e6368dc3193f593fc7248b8ef6aedf5af61d2948e691d3839e36fc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "48bbaaa4a08322099d19947f9da93f83ab579dfa4a832a06a68efcbad6605d69"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aec5a9103ad4bb27295ab3070437919035009abc7a29fb63c08817392bcd82ac"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.1/termframe-macos-x86_64.tar.gz"
      sha256 "5e2d0779a7b4cae3e6e6d5892cce254ad23816d268c6908cd3d6b24b63598326"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.1/termframe-macos-arm64.tar.gz"
      sha256 "e6e2de8ea85098bfda9db0c4b717af0368002bf3bcf5dc8340d31ff9355b0f2d"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.1/termframe-linux-x86_64-musl.tar.gz"
      sha256 "8429d1b2e1a9f75b64df44b77dc9f4c4e8b5a851a24e1bc52b47599af2ecb1e5"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.1/termframe-linux-arm64-musl.tar.gz"
      sha256 "036a19a0815f2578fa356bd9869f9c7801bec052ac156d33179e7c254296b278"

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
