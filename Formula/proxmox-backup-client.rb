class ProxmoxBackupClient < Formula
  desc "Proxmox Backup Server client and pxar tool (unofficial macOS port)"
  homepage "https://github.com/Marvo2011/proxmox-backup-client-mac"
  url "https://github.com/Marvo2011/proxmox-backup-client-mac/releases/download/v3.2.4-20261119/proxmox-backup-client-3.2.4-20261119-macos-arm64.tar.gz"
  version "3.2.4-20261119"
  sha256 "c691a0ac7c54a5db466f72a43bbcd8fd580ddb69970c374be1a65df0e26dcca6"
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
