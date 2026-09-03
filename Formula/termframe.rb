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
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.8.7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ec6e23bfa6d1005d1b1997a0754ed91a415edc4602c5c12e583f8852ac79ca48"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "58559a3cd6be967fdab66019254390249c69616daaebd73f0e918f43e4438186"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6d1baf45be1c43946297e5ff222cb0fcda6ad3fba46934a5db12798f1865dd70"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c34d4c34df29547e311597d9624e56608455f2177baea5e28aea046755000c21"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.7/termframe-macos-x86_64.tar.gz"
      sha256 "37bcdc42c4dd2a6557fd9ea305491660cce9d2cc9fb482b4edb10bd1197b6e23"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.7/termframe-macos-arm64.tar.gz"
      sha256 "91c7ce2dc4277f2cbab8fbd2011d780397f11baf3d25d666082ac1659f3b7486"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.7/termframe-linux-x86_64-musl.tar.gz"
      sha256 "ac2594f46bbcb0831338a9c6919f308e5684dec4954a1ef3d6ee95dc31b93fc2"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.8.7/termframe-linux-arm64-musl.tar.gz"
      sha256 "5ec8882b28c7d890bc09235c82a2a13859669062a8650e866752f66d094b575e"

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
