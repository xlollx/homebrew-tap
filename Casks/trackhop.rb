cask "trackhop" do
  arch arm: "arm64", intel: "x64"

  version "1.3.0"
  sha256 arm:   "b1d6ce1c280165cbed00c6af9f87b5e3d5ec5d87ceda9fd330038908f7040e40",
         intel: "509f36da73229db5f12bc4080b84c553a0a005134bc303a943da76a830020378"

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
