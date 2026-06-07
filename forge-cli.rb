class ForgeCli < Formula
  desc "一键创建 GitHub + Docker Hub 仓库，生成 CI/CD 部署流水线"
  homepage "https://github.com/chainlinn/forge"
  url "https://github.com/chainlinn/forge/releases/download/v0.1.0/forge-v0.1.0.tar.gz"
  sha256 "b580542ee73c0562011c8035083757e3e59c03746875cac7d3c9d4f8f1adfbcd"
  license "MIT"

  conflicts_with "forge", because: "both ship a `forge` binary"

  def install
    bin.install "bin/forge"
    (share/"forge/templates/shared").install Dir["templates/shared/*"]
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
