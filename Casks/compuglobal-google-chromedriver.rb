cask "compuglobal-google-chromedriver" do

    arch arm: "arm64", intel: "x64"
    sha256 arm: "b72a618ac15de86cb622421b5442056bf4c19a79d834a2894c2c390b54aba3de",
           intel: "d1964c4b4381c76367af53ce87d304e1586bf7d0d767b7ceef86cb651120c4eb"
    name "Google chromedriver for Testing"
    version "133.0.6943.141"
    url "https://storage.googleapis.com/chrome-for-testing-public/#{version}/mac-#{arch}/chromedriver-mac-#{arch}.zip"
    desc "Web browser for automated testing."
    homepage "https://developer.chrome.com/blog/chrome-for-testing/"

    livecheck do
        url "https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json"
        regex(/https:\/\/.*?chromedriver-mac-#{arch}.zip/i)
        strategy :json do |json, regex|
            version = json["channels"]["Stable"]["version"]
            json["channels"]["Stable"]["downloads"]["chromedriver"]&.map do |download|
                dl_url = download["url"]&.match(regex)
                next if dl_url.blank?
                "#{version},#{dl_url}"
            end
        end
    end

    binary "chromedriver-mac-#{arch}/chromedriver"
end
