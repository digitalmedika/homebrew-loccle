class Loccle < Formula
  desc "Terminal UI for Loccle powered by Mastra and OpenTUI"
  homepage "https://github.com/digitalmedika/mastra-tui"
  url "https://registry.npmjs.org/loccle/-/loccle-1.0.24.tgz"
  sha256 "92f4ed45721aea5d6e98950b83aee886d11e0b678e2dbf6a8381ef9273622c3a"
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
