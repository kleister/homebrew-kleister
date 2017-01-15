require "formula"
require "language/go"

class KleisterApi < Formula
  desc "Manage mod packs for Minecraft - API server"
  homepage "https://github.com/kleister/kleister-api"

  stable do
    url "http://dl.webhippie.de/kleister-api/0.1.0/kleister-api-0.1.0-darwin-10.6-amd64"
    sha256 `curl -Ls http://dl.webhippie.de/kleister-api/0.1.0/kleister-api-0.1.0-darwin-10.6-amd64.sha256`.split(" ").first
    version "0.1.0"
  end

  devel do
    url "http://dl.webhippie.de/kleister-api/master/kleister-api-master-darwin-10.6-amd64"
    sha256 `curl -Ls http://dl.webhippie.de/kleister-api/master/kleister-api-master-darwin-10.6-amd64.sha256`.split(" ").first
    version "master"
  end

  head do
    url "https://github.com/kleister/kleister-api.git", :branch => "master"
    depends_on "go" => :build
  end

  test do
    system "#{bin}/kleister-api", "--version"
  end

  def install
    case
    when build.head?
      ENV["GOPATH"] = buildpath
      ENV["GOHOME"] = buildpath
      ENV["CGO_ENABLED"] = 1
      ENV["TAGS"] = ""

      ENV.append_path "PATH", buildpath/"bin"

      currentpath = buildpath/"src/github.com/kleister/kleister-api"
      currentpath.install Dir["*"]
      Language::Go.stage_deps resources, buildpath/"src"

      cd currentpath do
        system "make", "test", "build"

        bin.install "kleister-api"
        # bash_completion.install "contrib/bash-completion/_kleister-api"
        # zsh_completion.install "contrib/zsh-completion/_kleister-api"
      end
    when build.devel?
      bin.install "#{buildpath}/kleister-api-master-darwin-10.6-amd64" => "kleister-api"
    else
      bin.install "#{buildpath}/kleister-api-0.1.0-darwin-10.6-amd64" => "kleister-api"
    end
  end
end
