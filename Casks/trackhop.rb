cask "trackhop" do
  arch arm: "arm64", intel: "x64"

  version "1.0.0"
  sha256 arm:   "766174c2fc0bd9ba90d796aec4c95053da104d984e88efefe2c0047fb9836cc9",
         intel: "1e85a459b89e0a9440fc231f350cb91c7f75952d03414df3bc42e8922d7fe16d"

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
