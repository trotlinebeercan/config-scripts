tell application "Spotify"
    set currentArtist to artist of current track as string
    set currentTrack to name of current track as string
    set currentSongId to id of current track as string
    set currentAlbum to album of current track as string

    set AppleScript's text item delimiters to ":"
    set currentSongId to text item 3 of currentSongId

    set theURL to "https://api.spotify.com/v1/tracks/" & currentSongId
    set response to do shell script "curl " & quoted form of theURL

    return currentArtist & "`" & currentTrack & "`" & currentAlbum & "`" & currentSongId & "`" & response
end tell
