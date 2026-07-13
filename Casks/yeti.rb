cask "yeti" do
  version "0.6.2"
  sha256 "a9d73a15beec74fce7721e145c3a7e3401a3f8c1ea5b1bbb128ec5787f248da8"

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
