cask "yeti" do
  version "0.5.1"
  sha256 "52744f17a7bb715b1338fd7f14cbb4e079f66bd72bf030427efe58f4a0ff3771"

  url "https://yeti-releases.s3.eu-west-1.amazonaws.com/v#{version}/Yeti_#{version}_aarch64.dmg"
  name "Yeti"
  desc "Fast, local-first desktop client for YouTrack"
  homepage "https://github.com/JetBrains/yeti"

  # Apple Silicon only; the app self-updates in place via the in-app Tauri updater,
  # so Homebrew leaves upgrades to it.
  depends_on macos: :catalina
  depends_on arch: :arm64
  auto_updates true

  app "Yeti.app"

  # Developer ID-signed but not Apple-notarized: strip the download quarantine so
  # Gatekeeper does not block first launch. Remove once the dmg is notarized.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Yeti.app"]
  end

  zap trash: [
    "~/Library/Application Support/app.yeti.desktop",
    "~/Library/Logs/app.yeti.desktop",
  ]
end
