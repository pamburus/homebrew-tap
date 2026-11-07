class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.10.0"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "6d87c5e219bba38ecb736b62363873d34b53abfbd74d0cf49035f804fb7bd1f7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "7a2a91ef12fe72cc82200bb9d153a88242dd0931dd9bc270e610ff6d025aa998"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "e52d41929a6fe4e2fb4078e1cc49c9dd83c4074d6a7546a08f3231dfa07ead97"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "75e6962c712df5da3c03a0d3b5c0eea7d65cd4b68945a0116f0cf9f8628f3792"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.10.0/termframe-macos-x86_64.tar.gz"
      sha256 "f5df75e7e5fcfe40e0fddfc66d1eb575895d6b7e88f362a778485955f06c3509"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.10.0/termframe-macos-arm64.tar.gz"
      sha256 "be459f744ff2d064f8c494647b9a97e8f621e96b1e99971c3180dbaec59e0311"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.10.0/termframe-linux-x86_64-musl.tar.gz"
      sha256 "821302e1bddfda043a768211ab3f92cc51100313f2f73daf4f809cc33b88eb98"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.10.0/termframe-linux-arm64-musl.tar.gz"
      sha256 "4d35fe9da11e7e752d44c021e68058c205439064ed17f2a84324e4cafb31bb4c"

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
