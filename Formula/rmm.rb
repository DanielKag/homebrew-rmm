class Rmm < Formula
  desc "Fast parallel rm -rf with a live progress bar"
  homepage "https://github.com/DanielKag/rmm"
  version "0.2.0"
  license "MIT"

  base = "https://github.com/DanielKag/rmm/releases/download/v#{version}/rmm-v#{version}"

  on_macos do
    on_arm do
      url "#{base}-aarch64-apple-darwin.tar.gz"
      sha256 "ced77bdf34b39062bc8e2b714ee8f62ae4db0f1c70a79ab89636ea6cfbe0138d"
    end
    on_intel do
      url "#{base}-x86_64-apple-darwin.tar.gz"
      sha256 "e57e6278bc8baaf17ee136a0cd0a5c8ed22d032e61904fbf39e3ab4c8f0070bf"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "10bfc76fba4959a469dba43dbefe4682a3ecbdef834fa9673a924126645e4019"
    end
    on_intel do
      url "#{base}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6a6629e45fc24b0c1eab116cfa9d48246f3241b7e146ec31d04d5df53915994b"
    end
  end

  def install
    bin.install "rmm"
    generate_completions_from_executable(bin/"rmm", "--completions")
  end

  def caveats
    <<~EOS
      zsh ships an unrelated completion for `rmm` (MH mail). For path completion,
      make sure Homebrew's completions come first in fpath, before compinit/oh-my-zsh:
        FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    EOS
  end

  test do
    (testpath/"tree/a/b").mkpath
    (testpath/"tree/a/b/file.txt").write "x"
    system bin/"rmm", "-rf", testpath/"tree"
    refute_path_exists testpath/"tree"
    assert_match "_files", shell_output("#{bin}/rmm --completions zsh")
    assert_match version.to_s, shell_output("#{bin}/rmm --version")
  end
end
