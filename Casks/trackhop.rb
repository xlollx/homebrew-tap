cask "trackhop" do
  arch arm: "arm64", intel: "x64"

  version "1.1.0"
  sha256 arm:   "bebef105d769feab95d2219e0b068b39268f3101a8a1798bd1460c80ffc7863b",
         intel: "2f3cfeeb947891248db9b750e6aedfd00596274379890a836e67f6a1dc2d99b0"

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
