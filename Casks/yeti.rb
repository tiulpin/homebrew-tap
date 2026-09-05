cask "yeti" do
  version "0.8.1"
  sha256 "9a6949ecbe82f597b8ed931bdc0b986d4ed18f837e8108ceb6f35485edd2e429"

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
