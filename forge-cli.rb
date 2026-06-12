class ForgeCli < Formula
  desc "一键创建 GitHub + Docker Hub 仓库，生成 CI/CD 部署流水线"
  homepage "https://github.com/chainlinn/forge"
  url "https://github.com/chainlinn/forge/releases/download/v0.1.13/forge-v0.1.13.tar.gz"
  sha256 "3120507fe118ee134e88eefbf964eac1ab5649df84976af324d9215721f2cc50"
  license "MIT"

  conflicts_with "forge", because: "both ship a `forge` binary"

  def install
    bin.install "bin/forge"
    (share/"forge/templates/project").install Dir["templates/project/*"].select { |f| File.file?(f) }
    (share/"forge/templates/project/hooks").install "templates/project/hooks/env"
    (share/"forge/templates/project/hooks").install "templates/project/hooks/events"
    (share/"forge/templates/project/hooks").install "templates/project/hooks/plugins"
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
