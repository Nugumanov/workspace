local appShortcuts = {
  f13 = "md.obsidian",
  f14 = "com.apple.Safari",
  f15 = "net.kovidgoyal.kitty",
  f16 = "com.hnc.Discord",
  f17 = "com.spotify.client",
  f18 = "com.toggl.daneel",
  f19 = "com.apple.finder",
}

for key, bundleID in pairs(appShortcuts) do
  hs.hotkey.bind({}, key, function()
    hs.application.launchOrFocusByBundleID(bundleID)
  end)
end
