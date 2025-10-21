class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.7.0"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.7.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b16e774e3bd44c651cc41609b6fdf43d84a5ec031b3ff91d239beea0d2ec8901"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "80a95f9b886b94521fd5ab635bf7c9f048df1c519292504b04a7bcf507205eda"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "64cc405633865764a97a04b52bc9e535eda8da7fc5cda23379d62414bd96a312"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.0/termframe-macos-x86_64.tar.gz"
      sha256 "86c612bf655d87eaf98c1bb4457f7d6b4f2d55a4c91a2354dea69362be422518"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.0/termframe-macos-arm64.tar.gz"
      sha256 "63bd6d803cf246f44b317ae68006e668955a868b17dd3b209cbb55a6db9f3476"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.0/termframe-linux-x86_64-musl.tar.gz"
      sha256 "234e23e0c4ccb411786582675d79adec325d19047074b820900be3f8367d4f90"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.0/termframe-linux-arm64-musl.tar.gz"
      sha256 "f19df06d5445f1ed4a3e01ca7da4de7e6fbe557f26794813ff1de54e43a8ef54"

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
