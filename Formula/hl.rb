class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.33.2"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.33.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "98919a0b984065978689ba3d5e252b16e906ca02245e1fc4f672a209775602e6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8e4a26b388881403f926f277255fbd8296f6e895328c6d935b68523858b44c46"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "954ca6dde46eba40b007fb237f078c2b364fdb7bafd805e6e0297dc33fa8b33a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "da7a6fa7883e4ecf2597e0544fe7dca2f99422620e0d6ede7e41bec2f4fb70e3"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.33.2/hl-macos-x86_64.tar.gz"
      sha256 "9c372000c87bdf9f5d8be3f1f577c668adf8394ebd53b0f65993a72a72c0916d"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.33.2/hl-macos-arm64.tar.gz"
      sha256 "9480bbb1d8f298bcc766e330fe24e80769fa2f786e276427f33434350b7752cc"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.33.2/hl-linux-x86_64-musl.tar.gz"
      sha256 "9b6f8e3f2d4a59cf7389c1ac44d417faa5886b6dae56c8bd56975a3ed1801146"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.33.2/hl-linux-arm64-musl.tar.gz"
      sha256 "1802620b61dc9332f59656556feb81f4ab88f986ace0605a002c67b1739caaa2"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hl --version")
  end
end
