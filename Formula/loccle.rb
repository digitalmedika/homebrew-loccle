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
      cd "#{libexec}" && exec bun run "#{libexec}/bin/mastra-tui.ts" "$@"
    EOS
    chmod 0755, bin/"loccle"
  end

  test do
    system "#{bin}/loccle", "--version"
  end
end
