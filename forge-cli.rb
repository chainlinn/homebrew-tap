class ForgeCli < Formula
  desc "一键创建 GitHub + Docker Hub 仓库，生成 CI/CD 部署流水线"
  homepage "https://github.com/chainlinn/forge"
  url "https://github.com/chainlinn/forge/releases/download/v0.1.1/forge-v0.1.1.tar.gz"
  sha256 "1218ec6b24a8b72beedc0ff7f44494f8b7a668ec1032e7d211d0c100fcdd3d0c"
  license "MIT"

  conflicts_with "forge", because: "both ship a `forge` binary"

  def install
    bin.install "bin/forge"
    (share/"forge/templates/project").install Dir["templates/project/*"]
    (share/"forge/templates/project/hooks").install Dir["templates/project/hooks/*"]
    (share/"forge/templates/workflows").install Dir["templates/workflows/*"]
    (share/"forge/templates/infra/cloudflared").install Dir["templates/infra/cloudflared/*"]
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
