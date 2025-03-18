# Load .NET Forms for SendKeys
Add-Type -AssemblyName System.Windows.Forms

# Allow a short pause to ensure clipboard content is ready
Start-Sleep -Milliseconds 200

# Get the text currently in the clipboard (requires Windows 10+)
$originalText = Get-Clipboard -Raw

if (-not $originalText) {
    [System.Windows.Forms.MessageBox]::Show("Clipboard is empty or no text was selected.", "Error")
    exit
}

# Define the mapping from accidental English keystrokes to Hebrew characters
$mapping = @{
    "q" = "/"
    "w" = "'"
    "e" = "ק"
    "r" = "ר"
    "t" = "א"
    "y" = "ט"
    "u" = "ו"
    "i" = "ן"
    "o" = "ם"
    "p" = "פ"
    "a" = "ש"
    "s" = "ד"
    "d" = "ג"
    "f" = "כ"
    "g" = "ע"
    "h" = "י"
    "j" = "ח"
    "k" = "ל"
    "l" = "ך"
    ";" = "ף"
    "z" = "ז"
    "x" = "ס"
    "c" = "ב"
    "v" = "ה"
    "b" = "נ"
    "n" = "מ"
    "m" = "צ"
    "," = "ת"
    "." = "ץ"
}

# Process each character of the original text
$newText = ""
foreach ($char in $originalText.ToCharArray()) {
    $lowerChar = $char.ToString().ToLower()
    if ($mapping.ContainsKey($lowerChar)) {
        $newText += $mapping[$lowerChar]
    }
    else {
        $newText += $char
    }
}

# Update the clipboard with the translated text
Set-Clipboard -Value $newText

# Optionally, simulate a paste (Ctrl+V) to replace the text in the current application.
# Note: This works in many contexts but may not work in all applications.
[System.Windows.Forms.SendKeys]::SendWait("^v")
