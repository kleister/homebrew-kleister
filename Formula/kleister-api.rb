# frozen_string_literal: true

# Definition of the kleister-api formula
class KleisterApi < Formula
  desc "Kleister: API"
  homepage "https://kleister.eu"
  license "Apache-2.0"

  url "https://github.com/kleister/kleister-api/archive/v0.0.0.tar.gz"
  sha256 ""
  head "https://github.com/kleister/kleister-api.git", branch: "master"

  test do
    system bin / "kleister-api", "--version"
  end

  depends_on "go" => :build
  depends_on "go-task" => :build
  depends_on "node@22" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ENV["SHA"] = "undefined"
    ENV["VERSION"] = if build.head?
                       Utils.git_short_head(length: 8)
                     else
                       url.split("/").last.gsub(".tar.gz", "").gsub("v", "")
                     end

    system "task", "fe:install", "fe:generate", "fe:build", "be:generate", "be:build"
    bin.install "bin/kleister-api"

    FileUtils.touch("kleister-api.conf")
    etc.install "kleister-api.conf"
  end

  def post_install
    (var / "kleister-api").mkpath
  end

  service do
    run [opt_bin / "kleister-api", "server"]
    environment_variables KLEISTER_API_ENV_FILE: etc / "kleister-api.conf"
    keep_alive true
    log_path var / "log/kleister-api.log"
    error_log_path var / "log/kleister-api.log"
  end
end
