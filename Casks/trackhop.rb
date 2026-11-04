cask "trackhop" do
  arch arm: "arm64", intel: "x64"

  version "1.4.0"
  sha256 arm:   "95782f66ba130fc3ffeb077f2feb81514618391876ad94071a39a74e3347dc55",
         intel: "2f9f245fb61c874a2566121708366ed19d81039535d9c3ec7a9a15dd0910771a"

  url "https://github.com/xlollx/Trackhop/releases/download/server-v#{version}/Trackhop-Desktop-v#{version}-macos-#{arch}.dmg"
  name "Trackhop Desktop"
  desc "Keep playlists in sync between music services"
  homepage "https://xlollx.github.io/Trackhop/"

  # Desktop's releases are server-v<version> prereleases: never GitHub's "latest".
  livecheck do
    url "https://github.com/xlollx/Trackhop"
    regex(/^server-v(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on macos: ">= :big_sur"

  app "Trackhop.app"
  binary "#{appdir}/Trackhop.app/Contents/MacOS/trackhop-cli", target: "trackhop"

  zap trash: "~/Library/Application Support/Trackhop"

  caveats <<~EOS
    Trackhop is not signed with Apple's developer certificate. The first time, macOS refuses to
    open it: open System Settings > Privacy & Security and choose "Open Anyway" for Trackhop.
    Guide: https://xlollx.github.io/Trackhop/guide/desktop#macos
    The command line is `trackhop` (Trackhop must be running).
  EOS
end
