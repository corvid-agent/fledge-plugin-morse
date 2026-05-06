import Foundation

// MARK: - Morse Code Table

public let morseTable: [(Character, String)] = [
    // Letters
    ("A", ".-"),
    ("B", "-..."),
    ("C", "-.-."),
    ("D", "-.."),
    ("E", "."),
    ("F", "..-."),
    ("G", "--."),
    ("H", "...."),
    ("I", ".."),
    ("J", ".---"),
    ("K", "-.-"),
    ("L", ".-.."),
    ("M", "--"),
    ("N", "-."),
    ("O", "---"),
    ("P", ".--."),
    ("Q", "--.-"),
    ("R", ".-."),
    ("S", "..."),
    ("T", "-"),
    ("U", "..-"),
    ("V", "...-"),
    ("W", ".--"),
    ("X", "-..-"),
    ("Y", "-.--"),
    ("Z", "--.."),
    // Digits
    ("0", "-----"),
    ("1", ".----"),
    ("2", "..---"),
    ("3", "...--"),
    ("4", "....-"),
    ("5", "....."),
    ("6", "-...."),
    ("7", "--..."),
    ("8", "---.."),
    ("9", "----."),
    // Punctuation
    (".", ".-.-.-"),
    (",", "--..--"),
    ("?", "..--.."),
    ("!", "-.-.--"),
    ("/", "-..-."),
    ("@", ".--.-."),
    ("(", "-.--."),
    (")", "-.--.-"),
    ("&", ".-..."),
    (":", "---..."),
    (";", "-.-.-."),
    ("=", "-...-"),
    ("+", ".-.-."),
    ("-", "-....-"),
    ("_", "..--.-"),
    ("\"", ".-..-."),
    ("'", ".----."),
]

public let charToMorse: [Character: String] = Dictionary(uniqueKeysWithValues: morseTable)
public let morseToChar: [String: Character] = Dictionary(uniqueKeysWithValues: morseTable.map { ($0.1, $0.0) })

// MARK: - Encode

public struct EncodeResult {
    public let morse: String
    public let skipped: [Character]
}

public func encodeMorse(_ text: String) -> EncodeResult {
    let uppercased = text.uppercased()
    var result: [String] = []
    var skipped: [Character] = []

    for char in uppercased {
        if char == " " {
            result.append("/")
        } else if let morse = charToMorse[char] {
            result.append(morse)
        } else {
            if !skipped.contains(char) {
                skipped.append(char)
            }
        }
    }

    return EncodeResult(morse: result.joined(separator: " "), skipped: skipped)
}

// MARK: - Decode

public struct DecodeResult {
    public let text: String
    public let skipped: [String]
}

public func decodeMorse(_ morse: String) -> DecodeResult {
    let words = morse.components(separatedBy: " / ")
    var result: [String] = []
    var skipped: [String] = []

    for word in words {
        var decoded = ""
        let symbols = word.split(separator: " ", omittingEmptySubsequences: true).map(String.init)
        for symbol in symbols {
            if let char = morseToChar[symbol] {
                decoded.append(char)
            } else {
                if !skipped.contains(symbol) {
                    skipped.append(symbol)
                }
            }
        }
        result.append(decoded)
    }

    return DecodeResult(text: result.joined(separator: " "), skipped: skipped)
}
