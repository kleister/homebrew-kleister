require "formula"

class KleisterCli < Formula
  homepage "https://github.com/kleister/kleister-cli"
  head "https://github.com/kleister/kleister-cli.git"

  stable do
    url "http://dl.webhippie.de/kleister-cli/0.0.1/kleister-cli-0.0.1-darwin-amd64"
    sha256 `curl -s http://dl.webhippie.de/kleister-cli/0.0.1/kleister-cli-0.0.1-darwin-amd64.sha256`.split(" ").first
    version "0.0.1"
  end

  devel do
    url "http://dl.webhippie.de/kleister-cli/latest/kleister-cli-latest-darwin-amd64"
    sha256 `curl -s http://dl.webhippie.de/kleister-cli/latest/kleister-cli-latest-darwin-amd64.sha256`.split(" ").first
    version "0.0.1"
  end

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
      mkdir_p buildpath/File.join("src", "github.com", "kleister")
      ln_s buildpath, buildpath/File.join("src", "github.com", "kleister", "kleister-cli")

      ENV["GOVENDOREXPERIMENT"] = "1"
      ENV["GOPATH"] = buildpath
      ENV["GOHOME"] = buildpath
      ENV["PATH"] += ":" + File.join(buildpath, "bin")

      system("make", "build")

      bin.install "#{buildpath}/bin/kleister-cli" => "kleister-cli"
    else
      bin.install "#{buildpath}/kleister-cli-latest-darwin-amd64" => "kleister-cli"
    end
  end
end
