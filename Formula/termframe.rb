class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "0.6.7"
  license "MIT"
  head "https://github.com/pamburus/termframe.git", branch: "main"

  bottle do
    root_url "https://github.com/pamburus/homebrew-tap/releases/download/termframe-0.6.7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5b420374038a76a63e3e5a1dee618094f82b3fa38250a0036d5ef1cb183602b3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "aaf485bacd93ddaac386c73ec1cb591896abc5a6a584ffa04058f0c51871cdd9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f3856418c45a49cb6ac4225d37f7623cc98933cabe95d999f607d72dfb411798"
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.7/termframe-macos-x86_64.tar.gz"
      sha256 "df55efec4942891495049d8a6a88af8da95b795c0187b8e1756e6284ce06b3e5"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.7/termframe-macos-arm64.tar.gz"
      sha256 "a53066dc3f77265dc52ba91c54b4a5cdc095eff06ced80cdedef928a0f696527"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.7/termframe-linux-x86_64-musl.tar.gz"
      sha256 "477e27098762a06084a8d572d40222f0d98d188a6d6fb2bd6bec375afc2f2928"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/pamburus/termframe/releases/download/v0.6.7/termframe-linux-arm64-musl.tar.gz"
      sha256 "9eed811bdef571a539a0ed9f8b9ba617646026fd0325077f5413d1c684490d65"

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
