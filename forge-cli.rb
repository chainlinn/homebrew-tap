class ForgeCli < Formula
  desc "一键创建 GitHub + Docker Hub 仓库，生成 CI/CD 部署流水线"
  homepage "https://github.com/chainlinn/forge"
  url "https://github.com/chainlinn/forge/releases/download/v0.1.7/forge-v0.1.7.tar.gz"
  sha256 "15a42fddf01ab1b48269c24ce70c4059b3171cde1875b8a84c6549a26d2ae0cd"
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
