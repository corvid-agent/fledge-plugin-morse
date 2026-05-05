import Foundation

// MARK: - Morse Code Table

let morseTable: [(Character, String)] = [
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

let charToMorse: [Character: String] = Dictionary(uniqueKeysWithValues: morseTable)
let morseToChar: [String: Character] = Dictionary(uniqueKeysWithValues: morseTable.map { ($0.1, $0.0) })

// MARK: - Encode

func encode(_ text: String) -> String {
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

    if !skipped.isEmpty {
        let skippedStr = skipped.map { String($0) }.joined(separator: ", ")
        print("Note: skipped unknown character(s): \(skippedStr)")
    }

    return result.joined(separator: " ")
}

// MARK: - Decode

func decode(_ morse: String) -> String {
    // Normalize word separators: " / " is the standard word separator
    // Also handle multiple spaces as word separator
    let words = morse.components(separatedBy: " / ")
    var result: [String] = []
    var skipped: [String] = []

    for word in words {
        var decoded = ""
        // Split each word by spaces to get individual Morse characters
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

    if !skipped.isEmpty {
        let skippedStr = skipped.joined(separator: ", ")
        print("Note: skipped unknown Morse sequence(s): \(skippedStr)")
    }

    return result.joined(separator: " ")
}

// MARK: - Table

func printTable() {
    print("Morse Code Table")
    print(String(repeating: "=", count: 40))

    print("\nLetters:")
    // Print letters in 2 columns
    let letters = morseTable.filter { $0.0 >= "A" && $0.0 <= "Z" }
    let half = (letters.count + 1) / 2
    for i in 0..<half {
        let left = letters[i]
        let leftStr = "  \(left.0)  \(left.1.padding(toLength: 8, withPad: " ", startingAt: 0))"
        if i + half < letters.count {
            let right = letters[i + half]
            print("\(leftStr)  \(right.0)  \(right.1)")
        } else {
            print(leftStr)
        }
    }

    print("\nDigits:")
    let digits = morseTable.filter { $0.0 >= "0" && $0.0 <= "9" }
    for digit in digits {
        print("  \(digit.0)  \(digit.1)")
    }

    print("\nPunctuation:")
    let punctuation = morseTable.filter { !($0.0 >= "A" && $0.0 <= "Z") && !($0.0 >= "0" && $0.0 <= "9") }
    for p in punctuation {
        let charDisplay = String(p.0).padding(toLength: 2, withPad: " ", startingAt: 0)
        print("  \(charDisplay) \(p.1)")
    }
}

// MARK: - Usage

func printUsage() {
    print("""
    fledge-plugin-morse — Encode and decode Morse code

    Usage:
      fledge morse encode <TEXT>    Convert text to Morse code
      fledge morse decode <MORSE>   Convert Morse code back to text
      fledge morse table            Show the full Morse code table

    Examples:
      fledge morse encode "Hello World"
      fledge morse decode ".... . .-.. .-.. --- / .-- --- .-. .-.. -.."
      fledge morse table
    """)
}

// MARK: - Main

let args = CommandLine.arguments.dropFirst() // drop the executable name

guard let command = args.first else {
    printUsage()
    exit(0)
}

switch command.lowercased() {
case "encode":
    let text = args.dropFirst().joined(separator: " ")
    if text.isEmpty {
        print("Error: no text provided")
        print("Usage: fledge morse encode <TEXT>")
        exit(1)
    }
    print(encode(text))

case "decode":
    let morse = args.dropFirst().joined(separator: " ")
    if morse.isEmpty {
        print("Error: no Morse code provided")
        print("Usage: fledge morse decode <MORSE>")
        exit(1)
    }
    print(decode(morse))

case "table":
    printTable()

case "--help", "-h", "help":
    printUsage()

default:
    print("Unknown command: \(command)")
    printUsage()
    exit(1)
}
