class Loccle < Formula
  desc "Terminal UI for Loccle powered by Mastra and OpenTUI"
  homepage "https://github.com/digitalmedika/mastra-tui"
  url "https://registry.npmjs.org/loccle/-/loccle-1.0.21.tgz"
  sha256 "b48a5b17bf3623f57d0643df2454e2d2608c3c2e165806d23f854aba74601ee9"
  license "MIT"

  preserve_rpath

  depends_on "bun"

  def install
    libexec.install Dir["*"]
    cd libexec do
      system "bun", "install", "--production"
    end
    (bin/"loccle").write <<~EOS
      #!/bin/bash
      exec bun "#{libexec}/dist/tui/cli.js" "$@"
    EOS
    chmod 0755, bin/"loccle"
  end

  test do
    system "#{bin}/loccle", "--version"
  end
end
