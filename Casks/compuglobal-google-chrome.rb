cask "compuglobal-google-chrome" do

    arch arm: "arm64", intel: "x64"
    sha256 arm: "ec940509119220ee2a464dea26556cb5a8163eabce6f4bcdf15fbacad2da3993",
           intel: "54fba3bc59f71b485f7f32363d32e2eea0d2ba26352d4d7a55af67fe75aaff38"
    name "Google Chrome for Testing"
    version "133.0.6943.141"
    url "https://storage.googleapis.com/chrome-for-testing-public/#{version}/mac-#{arch}/chrome-mac-#{arch}.zip"
    desc "Web browser for automated testing."
    homepage "https://developer.chrome.com/blog/chrome-for-testing/"

    livecheck do
        url "https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json"
        regex(/https:\/\/.*chrome-mac-#{arch}.zip/i)
        strategy :json do |json, regex|
            json["Stable"]&.map do |stable|
                version = stable["version"]
                stable["chrome"]["downloads"]&.map do |download|
                    dl_url = download["url"]&.match(regex)
                    next if dl_url.blank?
                    "#{version},#{dl_url}"
                end
            end
        end
    end

    app "chrome-mac-#{arch}/Google Chrome for Testing.app"

    zap trash: [
        "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.google.chrome.for.testing.app.*.sfl*",
        "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.google.chrome.for.testing.sfl*",
        "~/Library/Application Support/Google/Chrome",
        "~/Library/Caches/com.google.chrome.for.testing",
        "~/Library/Caches/com.google.chrome.for.testing.helper.*",
        "~/Library/Caches/Google/Chrome",
        "~/Library/Google/Google Chrome Brand.plist",
        "~/Library/Preferences/com.google.chrome.for.testing.plist",
        "~/Library/Saved Application State/com.google.chrome.for.testing.app.*.savedState",
        "~/Library/Saved Application State/com.google.chrome.for.testing.savedState",
        "~/Library/WebKit/com.google.chrome.for.testing",
    ],
    rmdir:     [
        "~/Library/Application Support/Google",
        "~/Library/Caches/Google",
        "~/Library/Google",
    ]

end
