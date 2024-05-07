class Hl < Formula
  desc "Log viewer for JSON and logfmt logs"
  homepage "https://github.com/pamburus/hl"
  version "{{ VERSION }}"
  license "MIT"
  head "{{ REPOSITORY_URL }}", branch: "{{ HEAD_BRANCH }}"

  on_macos do
    if Hardware::CPU.intel?
      url "{{ ASSET_MACOS_AMD64_URL }}"
      sha256 "{{ ASSET_MACOS_AMD64_SHA256 }}"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
      end
    end
    if Hardware::CPU.arm?
      url "{{ ASSET_MACOS_ARM64_URL }}"
      sha256 "{{ ASSET_MACOS_ARM64_SHA256 }}"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "{{ ASSET_LINUX_AMD64_URL }}"
      sha256 "{{ ASSET_LINUX_AMD64_SHA256 }}"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "{{ ASSET_LINUX_ARM64_URL }}"
      sha256 "{{ ASSET_LINUX_ARM64_SHA256 }}"

      def install
        bin.install "hl"
        generate_completions_from_executable(bin/"hl", "--shell-completions")
      end
    end
  end

  test do
    system "#{bin}/hl", "--version"
  end
end
