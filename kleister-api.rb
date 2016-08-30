require "formula"

class KleisterApi < Formula
  homepage "https://github.com/kleister/kleister-api"
  head "https://github.com/kleister/kleister-api.git"

  stable do
    url "http://dl.webhippie.de/kleister-api/0.0.1/kleister-api-0.0.1-darwin-amd64"
    sha256 `curl -s http://dl.webhippie.de/kleister-api/0.0.1/kleister-api-0.0.1-darwin-amd64.sha256`.split(" ").first
    version "0.0.1"
  end

  devel do
    url "http://dl.webhippie.de/kleister-api/latest/kleister-api-latest-darwin-amd64"
    sha256 `curl -s http://dl.webhippie.de/kleister-api/latest/kleister-api-latest-darwin-amd64.sha256`.split(" ").first
    version "0.0.1"
  end

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
      mkdir_p buildpath/File.join("src", "github.com", "kleister")
      ln_s buildpath, buildpath/File.join("src", "github.com", "kleister", "kleister-api")

      ENV["GOVENDOREXPERIMENT"] = "1"
      ENV["GOPATH"] = buildpath
      ENV["GOHOME"] = buildpath
      ENV["PATH"] += ":" + File.join(buildpath, "bin")

      system("make", "build")

      bin.install "#{buildpath}/bin/kleister-api" => "kleister-api"
    else
      bin.install "#{buildpath}/kleister-api-latest-darwin-amd64" => "kleister-api"
    end
  end
end
