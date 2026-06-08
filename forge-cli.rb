class ForgeCli < Formula
  desc "一键创建 GitHub + Docker Hub 仓库，生成 CI/CD 部署流水线"
  homepage "https://github.com/chainlinn/forge"
  url "https://github.com/chainlinn/forge/releases/download/v0.1.0/forge-v0.1.0.tar.gz"
  sha256 "d1841fa5592e1818fb33e65c9ae16b1c881749095b7d1672a6637267bd7dcbe8"
  license "MIT"

  conflicts_with "forge", because: "both ship a `forge` binary"

  def install
    bin.install "bin/forge"
    (share/"forge/templates").install Dir["templates/project/*"]
    (share/"forge/templates/project/hooks").install Dir["templates/project/hooks/*"]
    (share/"forge/templates/workflows").install Dir["templates/workflows/*"]
    (share/"forge/templates/infra").install Dir["templates/infra/*"]
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
