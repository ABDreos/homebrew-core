class Ruff < Formula
  desc "Extremely fast Python linter, written in Rust"
  homepage "https://docs.astral.sh/ruff/"
  license "MIT"
  head "https://github.com/astral-sh/ruff.git", branch: "main"

  stable do
    url "https://github.com/astral-sh/ruff/archive/refs/tags/v0.1.12.tar.gz"
    sha256 "7550d9ceff0283d74964f27017585441d179bb9cea85254f59425cb50d793b24"

    # remove in next version
    # see upstream issue: https://github.com/astral-sh/ruff/issues/9478
    patch do
      url "https://github.com/astral-sh/ruff/commit/350dcb807ac3e1f58b895149a7f8e4c680ffaa5a.patch?full_index=1"
      sha256 "920954bbf87df9dd3028d10a2a794bba8e162e80e49a2597275a360d5ca412e4"
    end
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "705458546000203221bc457a3eaa76d0bc827c79d0bd7768988419083348499c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e0e55c52bff2570a9bc2f23c5f569b10933ee13923601ebe03aaf273b473befc"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "336f675a4c5c80ea1c9473a8999863f5358bc5fb1dcf2d26f4a31e6a6c176446"
    sha256 cellar: :any_skip_relocation, sonoma:         "9252e3b064c3f0680eb990aa68f55740deaa5428134eb4df3f2b278a1130a471"
    sha256 cellar: :any_skip_relocation, ventura:        "fd1e4e17baffb9600225530b89e52560cf7dc57b2967686caedd7fb9af64f62b"
    sha256 cellar: :any_skip_relocation, monterey:       "3fe7c2a0914a0e3411da268a7eefce7bd4cc89b49bb1c2756acc4381ea7f17d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "377e70e436a4d30c9231e8c48596ecba8e3998e1128c6ffab6979fb0778da71a"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--no-default-features", *std_cargo_args(path: "crates/ruff_cli")
    generate_completions_from_executable(bin/"ruff", "generate-shell-completion")
  end

  test do
    (testpath/"test.py").write <<~EOS
      import os
    EOS

    assert_match "`os` imported but unused", shell_output("#{bin}/ruff --quiet #{testpath}/test.py", 1)
  end
end
