class Tlgc < Formula
  desc "A tldr client written in Go"
  homepage "https://github.com/TheRootDaemon/tlgc"
  url "https://github.com/TheRootDaemon/tlgc/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "4da677a05956869b5bab353d459eb46c3b918c220f6f7efb4dac66e0127f2d82"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"

    system "go", "build", "-trimpath",
           "-ldflags", "-s -w -X github.com/TheRootDaemon/tlgc/version.Version=#{version}",
           "-o", bin/"tldr", "./cmd/tldr"

    man1.install "tldr.1"
    bash_completion.install "completions/tldr.bash" => "tldr"
    fish_completion.install "completions/tldr.fish"
    zsh_completion.install "completions/_tldr"
  end

  test do
    assert_predicate bin/"tldr", :executable?
  end
end
