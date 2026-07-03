class Loccle < Formula
  desc "Terminal UI for Loccle powered by Mastra and OpenTUI"
  homepage "https://github.com/digitalmedika/mastra-tui"
  url "https://registry.npmjs.org/loccle/-/loccle-1.0.27.tgz"
  sha256 "7d323639503e4d0cd0cc1d0a096088dcd5a5479023b1ae12a58c74c174dc9ea7"
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
