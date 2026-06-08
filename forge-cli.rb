class ForgeCli < Formula
  desc "一键创建 GitHub + Docker Hub 仓库，生成 CI/CD 部署流水线"
  homepage "https://github.com/chainlinn/forge"
  url "https://github.com/chainlinn/forge/releases/download/v0.1.0/forge-v0.1.0.tar.gz"
  sha256 "63d0354e07fac6bdc13e68e9ea4db7af79f14467040d61f05d8fe2d48e175978"
  license "MIT"

  conflicts_with "forge", because: "both ship a `forge` binary"

  def install
    bin.install "bin/forge"
    (share/"forge/templates/project").install Dir["templates/project/*"
    (share/"forge/templates/project/hooks/lib").install Dir["templates/project/hooks/lib/*"]
    (share/"forge/templates/project/hooks").install Dir["templates/project/hooks/*"]
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
