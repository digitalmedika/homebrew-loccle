class Loccle < Formula
  desc "Terminal UI for Loccle powered by Mastra and OpenTUI"
  homepage "https://github.com/digitalmedika/mastra-tui"
  url "https://registry.npmjs.org/loccle/-/loccle-1.0.17.tgz"
  sha256 "fd62052b0a89e2a7318574ecf9c57113e6957903e593d4c8b8578bd71c3379e4"
  license "MIT"

  depends_on "bun"
  depends_on "node"

  def install
    libexec.install Dir["*"]
    cd libexec do
      system "bun", "install", "--production"
    end
    (bin/"loccle").write <<~EOS
      #!/bin/bash
      case "$1" in
        --version|-v)
          node -e "console.log(require('#{libexec}/package.json').version)"
          exit 0
          ;;
        --help|-h)
          echo "Usage: loccle [options]"
          echo ""
          echo "Options:"
          echo "  -v, --version  Show version number"
          echo "  -h, --help     Show this help message"
          exit 0
          ;;
      esac
      cd "#{libexec}" && exec bun "#{libexec}/bin/mastra-tui.ts" -- "$@"
    EOS
    chmod 0755, bin/"loccle"
  end

  test do
    system "#{bin}/loccle", "--version"
  end
end
