class Rmm < Formula
  desc "Fast parallel rm -rf with a live progress bar"
  homepage "https://github.com/DanielKag/rmm"
  version "0.1.0"
  license "MIT"

  base = "https://github.com/DanielKag/rmm/releases/download/v#{version}/rmm-v#{version}"

  on_macos do
    on_arm do
      url "#{base}-aarch64-apple-darwin.tar.gz"
      sha256 "e5cd880b8d4f2d48d19437ce33a24c095fc205e717b11d7c6adcac05e9623cb1"
    end
    on_intel do
      url "#{base}-x86_64-apple-darwin.tar.gz"
      sha256 "b1c68033f026dd70386dff1a90737d838aa708bec94718a004fc5cf41a30a6d2"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "10dfd98ae8fd92750c72e9eb1764ffbead95bb94903aa6c24165184b0b5cde17"
    end
    on_intel do
      url "#{base}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a05d887e4424074779c2b918cb1727e7e34eac3dbd1c76839cde7a710942d540"
    end
  end

  def install
    bin.install "rmm"
  end

  test do
    (testpath/"tree/a/b").mkpath
    (testpath/"tree/a/b/file.txt").write "x"
    system bin/"rmm", "-rf", testpath/"tree"
    refute_path_exists testpath/"tree"
    assert_match version.to_s, shell_output("#{bin}/rmm --version")
  end
end
