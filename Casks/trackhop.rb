cask "trackhop" do
  arch arm: "arm64", intel: "x64"

  version "1.9.1"
  sha256 arm:   "b48dad22581a76481a48c0206a0f411f00e0e9ad268d312cc18c5bd1dcbe426d",
         intel: "1e15d74f80f23cffe9604cc24586cedd66b5cc65cc2beb1a3de59e0fc776bf42"

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
