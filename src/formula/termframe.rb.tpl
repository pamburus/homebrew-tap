class Termframe < Formula
  desc "Terminal output SVG screenshot tool"
  homepage "https://github.com/pamburus/termframe"
  version "{{ VERSION }}"
  license "MIT"
  head "{{ REPOSITORY_URL }}", branch: "{{ HEAD_BRANCH }}"

  on_macos do
    if Hardware::CPU.intel?
      url "{{ ASSET_MACOS_AMD64_URL }}"
      sha256 "{{ ASSET_MACOS_AMD64_SHA256 }}"

      define_method(:install) do
        bin.install "hl"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm?
      url "{{ ASSET_MACOS_ARM64_URL }}"
      sha256 "{{ ASSET_MACOS_ARM64_SHA256 }}"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "{{ ASSET_LINUX_AMD64_URL }}"
      sha256 "{{ ASSET_LINUX_AMD64_SHA256 }}"

      define_method(:install) do
        bin.install "termframe"
        generate_completions_from_executable(bin/"termframe", "--shell-completions")
        (man1/"termframe.1").write Utils.safe_popen_read(bin/"termframe", "--man-page")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "{{ ASSET_LINUX_ARM64_URL }}"
      sha256 "{{ ASSET_LINUX_ARM64_SHA256 }}"

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
