on run {input, parameters}
    -- Copy the currently selected text
    tell application "System Events"
        keystroke "c" using command down
    end tell
    delay 0.2 -- wait a moment for the clipboard to update
    
    -- Get the copied text
    set originalText to the clipboard as string
    set newText to ""
    
    -- Loop over each character and convert it using our mapping
    repeat with i from 1 to (length of originalText)
        set c to character i of originalText
        set newText to newText & my convertChar(c)
    end repeat
    
    -- Replace the clipboard with the translated text
    set the clipboard to newText
    
    -- Paste the new text back in place of the selection
    tell application "System Events"
        keystroke "v" using command down
    end tell
    
    return input
end run

-- Function that converts an individual character.
-- This mapping is based on the standard Hebrew QWERTY layout:
-- Top row: q->"/"    w->"'"    e->"ק"    r->"ר"    t->"א"    y->"ט"    u->"ו"    i->"ן"    o->"ם"    p->"פ"
-- Home row: a->"ש"   s->"ד"    d->"ג"    f->"כ"    g->"ע"    h->"י"    j->"ח"    k->"ל"    l->"ך"    ;->"ף"
-- Bottom row: z->"ז" x->"ס"   c->"ב"    v->"ה"    b->"נ"    n->"מ"    m->"צ"    ,->"ת"    .->"ץ"
on convertChar(c)
    -- Convert any uppercase letter to lowercase for mapping
    set lowerC to c
    if c is in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" then
        set lowerC to (do shell script "echo " & quoted form of c & " | tr '[:upper:]' '[:lower:]'")
    end if
    
    if lowerC is "q" then return "/"
    else if lowerC is "w" then return "'"
    else if lowerC is "e" then return "ק"
    else if lowerC is "r" then return "ר"
    else if lowerC is "t" then return "א"
    else if lowerC is "y" then return "ט"
    else if lowerC is "u" then return "ו"
    else if lowerC is "i" then return "ן"
    else if lowerC is "o" then return "ם"
    else if lowerC is "p" then return "פ"
    else if lowerC is "a" then return "ש"
    else if lowerC is "s" then return "ד"
    else if lowerC is "d" then return "ג"
    else if lowerC is "f" then return "כ"
    else if lowerC is "g" then return "ע"
    else if lowerC is "h" then return "י"
    else if lowerC is "j" then return "ח"
    else if lowerC is "k" then return "ל"
    else if lowerC is "l" then return "ך"
    else if lowerC is ";" then return "ף"
    else if lowerC is "z" then return "ז"
    else if lowerC is "x" then return "ס"
    else if lowerC is "c" then return "ב"
    else if lowerC is "v" then return "ה"
    else if lowerC is "b" then return "נ"
    else if lowerC is "n" then return "מ"
    else if lowerC is "m" then return "צ"
    else if lowerC is "," then return "ת"
    else if lowerC is "." then return "ץ"
    else
        return c -- leave character unchanged (e.g. spaces, punctuation)
    end if
end convertChar
