require "securerandom"

class KleisterCli < Formula
  homepage "https://github.com/kleister/kleister-cli"
  url "http://dl.webhippie.de/kleister-cli/latest/kleister-cli-latest-darwin-amd64"
  sha256 `curl -s http://dl.webhippie.de/kleister-cli/latest/kleister-cli-latest-darwin-amd64.sha256`.split(" ").first

  head do
    url "https://github.com/kleister/kleister-cli.git", :branch => "master"

    depends_on "go" => :build
    depends_on "mercurial" => :build
    depends_on "bzr" => :build
    depends_on "git" => :build
  end

  test do
    system "#{bin}/kleister-cli", "--version"
  end

  def install
    if build.head?
      kleister_build_home = "/tmp/#{SecureRandom.hex}"
      kleister_build_path = File.join(kleister_build_home, "src", "github.com", "kleister", "kleister-cli")

      ENV["GOPATH"] = kleister_build_home
      ENV["GOHOME"] = kleister_build_home

      mkdir_p kleister_build_path

      system("cp -R #{buildpath}/* #{kleister_build_path}")
      ln_s File.join(cached_download, ".git"), File.join(kleister_build_path, ".git")

      Dir.chdir kleister_build_path

      system "make", "deps"
      system "make", "build"

      bin.install "#{kleister_build_path}/bin/kleister-cli" => "kleister-cli"
      Dir.chdir buildpath
    else
      bin.install "#{buildpath}/kleister-cli-latest-darwin-amd64" => "kleister-cli"
    end
  ensure
    rm_rf kleister_build_home if build.head?
  end
end
