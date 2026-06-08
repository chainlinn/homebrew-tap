class ForgeCli < Formula
  desc "一键创建 GitHub + Docker Hub 仓库，生成 CI/CD 部署流水线"
  homepage "https://github.com/chainlinn/forge"
  url "https://github.com/chainlinn/forge/releases/download/v0.1.1/forge-v0.1.1.tar.gz"
  sha256 "07c54f6ad91dad46ab92d0ce5015a6f03d9dc2ee607d8da328487405a9646192"
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
