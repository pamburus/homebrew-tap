class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.8.5"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.8.5"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "585501349c147d0c11159fa0387f3e2e9b18a12f8736524ca1ddc0f9b7f27074"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "698408056e86b8ac9de73e77e9f1d122d876ae7de3677ca3ca066972179ce491"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "654e379b5e99893577eee0c16667b9aa0a742b79f0a4d9220055f08e5302d1ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f7e47e5cbb370be010996198608e5eb316986b5f0bda03b65477e13af1acdced"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.5/termframe-macos-x86_64.tar.gz"
      sha256 "1fcba5fe33878a54334cce4228cd8eb223c0f042435b77d53945ef339fd94b50"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.5/termframe-macos-arm64.tar.gz"
      sha256 "ea365445ab750ad65ebed168a7ae488d8db4665c41b466a19c50fe363b34e496"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.5/termframe-linux-x86_64-musl.tar.gz"
      sha256 "e52eb6eae87f56b2c965b12709110d66c0c7c9e1255bdd4716cd76feecd89afb"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.5/termframe-linux-arm64-musl.tar.gz"
      sha256 "af06bb1745b7b13616e33163ed121c91a921e9d3c3b9b0d1634913b3a9668605"

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
