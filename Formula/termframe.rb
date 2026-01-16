class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.7.6"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v((?:0|[1-9]\d*)(?:\.(?:0|[1-9]\d*)){2})$/i)
  end

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.7.6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "992f09e071bad2647ec50cfbf2edbb7c03c2f5c08e65576bdacd6734c2b6869c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3a12c6975dd77a0857e821aa5f5b4d3638ea25b8737c6067700e4a551abb17ef"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8ac262cc97b7b9e4b18245628e0cb002953065cdff2d52ebe705fc352943f0c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e27b2f59e5924acd98410ce58239601d09f41a470cdbac7fc83cf8a5e9bf2948"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.6/termframe-macos-x86_64.tar.gz"
      sha256 "512a614752c4ed26539ddc13c36744810f97bf72b5966eda58227ff696b81a3e"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.6/termframe-macos-arm64.tar.gz"
      sha256 "04375df5b12cc6e433b3f94d1c31493179e4204a263993ee40ba7ab5f0d98559"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.6/termframe-linux-x86_64-musl.tar.gz"
      sha256 "2a443f484f411cd654dc1f0fb9737402ff871b1701c65ec86f2b3134d2609b55"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.7.6/termframe-linux-arm64-musl.tar.gz"
      sha256 "e569026e689dd55671d454205b2fd1db67a9560ac2747b3d36de3545934647a2"

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
