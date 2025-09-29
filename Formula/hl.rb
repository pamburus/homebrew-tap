class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "0.32.1"
  license "MIT"
  head "https://github.com/pamburus/hl.git", branch: "master"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/hl-0.32.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3967abf4c1690f42e9a584f41f4832da34f7b564a3fd62bf9bfdda7a39476cff"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bb0f3d871b497d4848bb035ce4ecc2dd8d2eede2ddefa906371457a589559c2a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e536b9a97a8326983883934281327e0fe0fca62cd93f68611da97e37005121d8"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.32.1/hl-macos-x86_64.tar.gz"
      sha256 "0440b464445222a8175307751af75eb854938656fa9a513dbc68627a8b886950"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/hl/releases/download/v0.32.1/hl-macos-arm64.tar.gz"
      sha256 "8504802c3fd5c6d55d2faab9a12dc1a960ddaa47ffb4402293240fa340236354"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/hl/releases/download/v0.32.1/hl-linux-x86_64-musl.tar.gz"
      sha256 "d4fd249e7ed28c9714a8d4bbf152e4a43a681cc56a865297abec7bd2eb5a9df8"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
        (man1/"hl.1").write Utils.safe_popen_read(bin/"hl", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/hl/releases/download/v0.32.1/hl-linux-arm64-musl.tar.gz"
      sha256 "504a94e1867330dea2b26ad17074b95777f01e2b13b1facdb33d1312369ab090"

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
