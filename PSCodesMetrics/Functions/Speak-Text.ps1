function Speak-Text {
    param ($text)

    (New-Object -ComObject SAPI.SPVoice).Speak($text) | Out-Null
}