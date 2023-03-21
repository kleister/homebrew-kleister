# frozen_string_literal: true

# Definition of the kleister-ui formula
class KleisterUi < Formula
  desc "Kleister: UI"
  homepage "https://kleister.eu"
  license "Apache-2.0"

  url "https://github.com/kleister/kleister-ui/archive/v0.0.0.tar.gz"
  sha256 ""
  head "https://github.com/kleister/kleister-ui.git", branch: "master"

  test do
    system bin / "kleister-ui", "--version"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ENV["SHA"] = "undefined"
    ENV["VERSION"] = if build.head?
                       Utils.git_short_head(length: 8)
                     else
                       url.split("/").last.gsub(".tar.gz", "").gsub("v", "")
                     end

    system "make", "generate", "build"
    bin.install "bin/kleister-ui"

    FileUtils.touch("kleister-ui.conf")
    etc.install "kleister-ui.conf"
  end

  def post_install
    (var / "kleister-ui").mkpath
  end

  service do
    run [opt_bin / "kleister-ui", "server"]
    environment_variables KLEISTER_UI_ENV_FILE: etc / "kleister-ui.conf"
    keep_alive true
    log_path var / "log/kleister-ui.log"
    error_log_path var / "log/kleister-ui.log"
  end
end
