class Fd < Formula
  desc "Fast, user-friendly, and open-source alternative to find"
  homepage "https://github.com/sharkdp/fd"
  version "{{ VERSION }}"
  license "MIT"
  head "{{ REPOSITORY_URL }}", branch: "{{ HEAD_BRANCH }}"

  on_macos do
    if Hardware::CPU.intel?
      url "{{ ASSET_MACOS_AMD64_URL }}"
      sha256 "{{ ASSET_MACOS_AMD64_SHA256 }}"

      define_method(:install) do
        bin.install "fd"
        (man1/"fd.1").write Utils.safe_popen_read(bin/"fd", "--help")
      end
    end
    if Hardware::CPU.arm?
      url "{{ ASSET_MACOS_ARM64_URL }}"
      sha256 "{{ ASSET_MACOS_ARM64_SHA256 }}"

      define_method(:install) do
        bin.install "fd"
        (man1/"fd.1").write Utils.safe_popen_read(bin/"fd", "--help")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "{{ ASSET_LINUX_AMD64_URL }}"
      sha256 "{{ ASSET_LINUX_AMD64_SHA256 }}"

      define_method(:install) do
        bin.install "fd"
        (man1/"fd.1").write Utils.safe_popen_read(bin/"fd", "--help")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "{{ ASSET_LINUX_ARM64_URL }}"
      sha256 "{{ ASSET_LINUX_ARM64_SHA256 }}"

      define_method(:install) do
        bin.install "fd"
        (man1/"fd.1").write Utils.safe_popen_read(bin/"fd", "--help")
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fd --version")
  end
end
