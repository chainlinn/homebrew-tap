class ForgeCli < Formula
  desc "一键创建 GitHub + Docker Hub 仓库，生成 CI/CD 部署流水线"
  homepage "https://github.com/chainlinn/forge"
  url "https://github.com/chainlinn/forge/releases/download/v0.1.8/forge-v0.1.8.tar.gz"
  sha256 "d312e1ef1b23d0355b9a83453b863135958028de474cf2644d4d0def40b5dcb7"
  license "MIT"

  conflicts_with "forge", because: "both ship a `forge` binary"

  def install
    bin.install "bin/forge"
    (share/"forge/templates/project").install Dir["templates/project/*"]
    (share/"forge/templates/project/hooks/env").install Dir["templates/project/hooks/env/*"]
    (share/"forge/templates/project/hooks/events").install Dir["templates/project/hooks/events/*"]
    (share/"forge/templates/project/hooks/plugins").install Dir["templates/project/hooks/plugins/*"]
    (share/"forge/templates/workflows").install Dir["templates/workflows/*"]
  end

  def caveats
    <<~EOS
      Prerequisites:
        brew install gh jq
        gh auth login

      Setup credentials:
        mkdir -p ~/.forge/config
        cp /path/to/your/.secrets ~/.forge/config/.secrets
    EOS
  end

  test do
    system "#{bin}/forge", "--help"
  end
end
