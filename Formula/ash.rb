# Homebrew formula for ash, the agentic shell.
#
# Builds from source, so the binary is never quarantined by Gatekeeper: it runs
# immediately with no "downloaded from the internet" prompt and needs no signing.
#
#   brew install dboeke/tap/ash

class Ash < Formula
  desc "Agentic shell: natural-language commands via on-device Apple Intelligence"
  homepage "https://github.com/dboeke/ash-cli"
  url "https://github.com/dboeke/ash-cli/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "75a621c96a8a052539d77ec83fcf39d1a05a0deff77f0bb73e5d2d0d37c119c8"
  license "MIT"
  head "https://github.com/dboeke/ash-cli.git", branch: "main"

  depends_on arch: :arm64
  # Requires macOS 26+ with Apple Intelligence at runtime. ash prints a clear
  # message and exits if the on-device model is unavailable, so the OS minimum
  # is enforced at runtime rather than risking a stale Homebrew version symbol.

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release", "--arch", "arm64"
    bin.install ".build/release/ash"
  end

  test do
    assert_match "ash", shell_output("#{bin}/ash --version")
  end
end
