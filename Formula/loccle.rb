class Loccle < Formula
  desc "Terminal UI for Loccle powered by Mastra and OpenTUI"
  homepage "https://github.com/digitalmedika/mastra-tui"
  url "https://registry.npmjs.org/loccle/-/loccle-1.0.18.tgz"
  sha256 "cfbff6377a691c9ab7bac21b992b9aa6346e738bd4120378c557140acd9fca13"
  license "MIT"

  preserve_rpath

  depends_on "node"

  def install
    libexec.install Dir["*"]
    cd libexec do
      system "npm", "install", "--omit=dev", "--ignore-scripts"
    end
    (bin/"loccle").write <<~EOS
      #!/bin/bash
      exec node "#{libexec}/dist/tui/cli.js" "$@"
    EOS
    chmod 0755, bin/"loccle"
  end

  test do
    system "#{bin}/loccle", "--version"
  end
end
