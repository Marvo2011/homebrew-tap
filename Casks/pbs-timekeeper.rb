cask "pbs-timekeeper" do
  version "0.1.0"
  sha256 "4fb3c9a157dc21fe0e973810214bc5088e3e1fee9d930670104b22b87fb19a9c"

  url "https://github.com/Marvo2011/pbs-timekeeper/releases/download/v#{version}/PBS-Timekeeper-#{version}-macos-arm64.zip"
  name "PBS Timekeeper"
  desc "Folder backups to a Proxmox Backup Server, with a timeline to restore"
  homepage "https://github.com/Marvo2011/pbs-timekeeper"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "PBS Timekeeper.app"

  preflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "PBS Timekeeper.app"],
        chdir:          ".",
        writable_paths: ["PBS Timekeeper.app"]
  end

  uninstall quit: "io.github.marvo2011.pbs-timekeeper"

  zap trash: [
    "~/Library/Application Support/PBSTimekeeper",
    "~/Library/Caches/PBSTimekeeper",
    "~/Library/Logs/PBSTimekeeper",
  ]

  caveats <<~EOS
    Browsing backups needs FUSE-T:
      brew install --cask macos-fuse-t/cask/fuse-t

    To back up protected folders (Desktop, Documents, Mail, ...), give
    PBS Timekeeper Full Disk Access in System Settings > Privacy & Security.
  EOS
end
