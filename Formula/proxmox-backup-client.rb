class ProxmoxBackupClient < Formula
  desc "Proxmox Backup Server client and pxar tool (unofficial macOS port)"
  homepage "https://github.com/Marvo2011/proxmox-backup-client-mac"
  url "https://github.com/Marvo2011/proxmox-backup-client-mac/releases/download/v4.2.10-20261120/proxmox-backup-client-4.2.10-20261120-macos-arm64.tar.gz"
  version "4.2.10-20261120"
  sha256 "42a996b0da6267c1839a2d7b058b001bdfe878b4fe4c1e18102347d9176ae3bb"
  license "AGPL-3.0-only"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "proxmox-backup-client", "pxar"
  end

  def caveats
    <<~EOS
      The mount, map and unmap commands need FUSE-T:
        brew install --cask macos-fuse-t/cask/fuse-t
    EOS
  end

  test do
    # the binary reports the version with "+" (3.2.4+20261119)
    assert_match "client version: #{version.to_s.tr("-", "+")}",
                 shell_output("#{bin}/proxmox-backup-client version")
  end
end
