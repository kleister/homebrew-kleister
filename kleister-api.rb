require "securerandom"

class KleisterApi < Formula
  homepage "https://github.com/kleister/kleister-api"
  url "http://dl.webhippie.de/kleister-api/latest/kleister-api-latest-darwin-amd64"
  sha256 `curl -s http://dl.webhippie.de/kleister-api/latest/kleister-api-latest-darwin-amd64.sha256`.split(" ").first

  head do
    url "https://github.com/kleister/kleister-api.git", :branch => "master"

    depends_on "go" => :build
    depends_on "mercurial" => :build
    depends_on "bzr" => :build
    depends_on "git" => :build
  end

  test do
    system "#{bin}/kleister-api", "--version"
  end

  def install
    if build.head?
      kleister_build_home = "/tmp/#{SecureRandom.hex}"
      kleister_build_path = File.join(kleister_build_home, "src", "github.com", "kleister", "kleister-api")

      ENV["GOPATH"] = kleister_build_home
      ENV["GOHOME"] = kleister_build_home

      mkdir_p kleister_build_path

      system("cp -R #{buildpath}/* #{kleister_build_path}")
      ln_s File.join(cached_download, ".git"), File.join(kleister_build_path, ".git")

      Dir.chdir kleister_build_path

      system "make", "deps"
      system "make", "build"

      bin.install "#{kleister_build_path}/bin/kleister-api" => "kleister-api"
      Dir.chdir buildpath
    else
      bin.install "#{buildpath}/kleister-api-latest-darwin-amd64" => "kleister-api"
    end
  ensure
    rm_rf kleister_build_home if build.head?
  end
end
