class ForgeCli < Formula
  desc "一键创建 GitHub + Docker Hub 仓库，生成 CI/CD 部署流水线"
  homepage "https://github.com/chainlinn/forge"
  url "https://github.com/chainlinn/forge/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "54304d2ca48d3c1b249990a2955b3aeb69d9c5d2b0d5d6eb190e93833a361f62"
  license "MIT"

  conflicts_with "forge", because: "both ship a `forge` binary"

  depends_on "gh"
  depends_on "jq"

  def install
    bin.install "bin/forge"
    (share/"forge/templates").install Dir["templates/shared/*"]
  end

  def caveats
    <<~EOS
      Forge uses ~/.forge/config/.secrets for credentials.
      Create one before running 'forge init':
        mkdir -p ~/.forge/config
        cp /path/to/your/.secrets ~/.forge/config/.secrets

      Then authenticate with GitHub:
        gh auth login
    EOS
  end

  test do
    system "#{bin}/forge", "--help"
  end
end
