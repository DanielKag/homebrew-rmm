class Rmm < Formula
  desc "Fast parallel rm -rf with a live progress bar"
  homepage "https://github.com/DanielKag/rmm"
  url "https://github.com/DanielKag/rmm/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "a8b9ed67c35e2d968db2710c75ff5f2c0cde820f9dde50f3940cba6c195896e4"
  license "MIT"
  head "https://github.com/DanielKag/rmm.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    (testpath/"tree/a/b").mkpath
    (testpath/"tree/a/b/file.txt").write "x"
    system bin/"rmm", "-rf", testpath/"tree"
    refute_path_exists testpath/"tree"
    assert_match version.to_s, shell_output("#{bin}/rmm --version")
  end
end
