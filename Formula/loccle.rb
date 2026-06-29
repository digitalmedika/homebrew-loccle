class Loccle < Formula
  desc "Terminal UI for Loccle powered by Mastra and OpenTUI"
  homepage "https://github.com/digitalmedika/mastra-tui"
  url "https://registry.npmjs.org/loccle/-/loccle-1.0.23.tgz"
  sha256 "83a2ca3ba432463f1e14f4fab46bbc28d8cc45477421f11f887d5fef45c330d1"
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
