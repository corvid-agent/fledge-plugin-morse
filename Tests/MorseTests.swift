import Testing
@testable import MorseLib

// MARK: - Encoding

@Suite("Morse Encoding")
struct MorseEncodeTests {

    // Single letters

    @Test("Encode single letter A")
    func encodeSingleLetterA() {
        let result = encodeMorse("A")
        #expect(result.morse == ".-")
        #expect(result.skipped.isEmpty)
    }

    @Test("Encode single letter B")
    func encodeSingleLetterB() {
        let result = encodeMorse("B")
        #expect(result.morse == "-...")
        #expect(result.skipped.isEmpty)
    }

    @Test("Encode single letter Z")
    func encodeSingleLetterZ() {
        let result = encodeMorse("Z")
        #expect(result.morse == "--..")
        #expect(result.skipped.isEmpty)
    }

    // Words

    @Test("Encode word HELLO")
    func encodeWord() {
        let result = encodeMorse("HELLO")
        #expect(result.morse == ".... . .-.. .-.. ---")
        #expect(result.skipped.isEmpty)
    }

    @Test("Encode HELLO WORLD with spaces")
    func encodeWordWithSpaces() {
        let result = encodeMorse("HELLO WORLD")
        #expect(result.morse == ".... . .-.. .-.. --- / .-- --- .-. .-.. -..")
        #expect(result.skipped.isEmpty)
    }

    @Test("Encode SOS")
    func encodeSOS() {
        let result = encodeMorse("SOS")
        #expect(result.morse == "... --- ...")
        #expect(result.skipped.isEmpty)
    }

    // Digits

    @Test("Encode digits 123")
    func encodeDigits() {
        let result = encodeMorse("123")
        #expect(result.morse == ".---- ..--- ...--")
        #expect(result.skipped.isEmpty)
    }

    @Test("Encode all digits 0-9")
    func encodeAllDigits() {
        let result = encodeMorse("0123456789")
        #expect(result.morse == "----- .---- ..--- ...-- ....- ..... -.... --... ---.. ----.")
        #expect(result.skipped.isEmpty)
    }

    // Mixed case

    @Test("Encode mixed case Hello")
    func encodeMixedCase() {
        let result = encodeMorse("Hello")
        #expect(result.morse == ".... . .-.. .-.. ---")
        #expect(result.skipped.isEmpty)
    }

    @Test("Encode lowercase sos")
    func encodeLowercase() {
        let result = encodeMorse("sos")
        #expect(result.morse == "... --- ...")
        #expect(result.skipped.isEmpty)
    }

    // Punctuation

    @Test("Encode question mark")
    func encodeQuestionMark() {
        let result = encodeMorse("?")
        #expect(result.morse == "..--..")
        #expect(result.skipped.isEmpty)
    }

    @Test("Encode exclamation mark")
    func encodeExclamationMark() {
        let result = encodeMorse("!")
        #expect(result.morse == "-.-.--")
        #expect(result.skipped.isEmpty)
    }

    @Test("Encode period")
    func encodePeriod() {
        let result = encodeMorse(".")
        #expect(result.morse == ".-.-.-")
        #expect(result.skipped.isEmpty)
    }

    // Unknown characters

    @Test("Encode skips unknown characters")
    func encodeSkipsUnknownCharacters() {
        let result = encodeMorse("A#B")
        #expect(result.morse == ".- -...")
        #expect(result.skipped == ["#"])
    }

    @Test("Encode skips multiple unknown characters")
    func encodeSkipsMultipleUnknown() {
        let result = encodeMorse("A#B$C")
        #expect(result.morse == ".- -... -.-.")
        #expect(result.skipped == ["#", "$"])
    }

    @Test("Encode empty string")
    func encodeEmptyString() {
        let result = encodeMorse("")
        #expect(result.morse == "")
        #expect(result.skipped.isEmpty)
    }
}

// MARK: - Decoding

@Suite("Morse Decoding")
struct MorseDecodeTests {

    // Single codes

    @Test("Decode single code for A")
    func decodeSingleCodeA() {
        let result = decodeMorse(".-")
        #expect(result.text == "A")
        #expect(result.skipped.isEmpty)
    }

    @Test("Decode single code for Z")
    func decodeSingleCodeZ() {
        let result = decodeMorse("--..")
        #expect(result.text == "Z")
        #expect(result.skipped.isEmpty)
    }

    // Full words

    @Test("Decode HELLO")
    func decodeWord() {
        let result = decodeMorse(".... . .-.. .-.. ---")
        #expect(result.text == "HELLO")
        #expect(result.skipped.isEmpty)
    }

    @Test("Decode SOS")
    func decodeSOS() {
        let result = decodeMorse("... --- ...")
        #expect(result.text == "SOS")
        #expect(result.skipped.isEmpty)
    }

    // Word separators

    @Test("Decode with word separator")
    func decodeWithWordSeparator() {
        let result = decodeMorse(".... .. / .-- --- .-. .-.. -..")
        #expect(result.text == "HI WORLD")
        #expect(result.skipped.isEmpty)
    }

    @Test("Decode HELLO WORLD")
    func decodeHelloWorld() {
        let result = decodeMorse(".... . .-.. .-.. --- / .-- --- .-. .-.. -..")
        #expect(result.text == "HELLO WORLD")
        #expect(result.skipped.isEmpty)
    }

    // Unknown sequences

    @Test("Decode skips unknown sequences")
    func decodeSkipsUnknownSequences() {
        let result = decodeMorse(".- .-.-.-.- -...")
        #expect(result.text == "AB")
        #expect(result.skipped == [".-.-.-.-"])
    }

    @Test("Decode empty string")
    func decodeEmptyString() {
        let result = decodeMorse("")
        #expect(result.text == "")
        #expect(result.skipped.isEmpty)
    }
}

// MARK: - Roundtrip

@Suite("Morse Roundtrip")
struct MorseRoundtripTests {

    @Test("Roundtrip HELLO WORLD")
    func roundtripHelloWorld() {
        let original = "HELLO WORLD"
        let encoded = encodeMorse(original)
        let decoded = decodeMorse(encoded.morse)
        #expect(decoded.text == original)
        #expect(encoded.skipped.isEmpty)
        #expect(decoded.skipped.isEmpty)
    }

    @Test("Roundtrip SOS")
    func roundtripSOS() {
        let original = "SOS"
        let encoded = encodeMorse(original)
        let decoded = decodeMorse(encoded.morse)
        #expect(decoded.text == original)
    }

    @Test("Roundtrip full alphabet")
    func roundtripAlphabet() {
        let original = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let encoded = encodeMorse(original)
        let decoded = decodeMorse(encoded.morse)
        #expect(decoded.text == original)
        #expect(encoded.skipped.isEmpty)
        #expect(decoded.skipped.isEmpty)
    }

    @Test("Roundtrip all digits")
    func roundtripDigits() {
        let original = "0123456789"
        let encoded = encodeMorse(original)
        let decoded = decodeMorse(encoded.morse)
        #expect(decoded.text == original)
    }

    @Test("Roundtrip mixed case normalizes to uppercase")
    func roundtripMixedCase() {
        let encoded = encodeMorse("Hello World")
        let decoded = decodeMorse(encoded.morse)
        #expect(decoded.text == "HELLO WORLD")
    }

    @Test("Roundtrip multiple words")
    func roundtripMultipleWords() {
        let original = "THE QUICK BROWN FOX"
        let encoded = encodeMorse(original)
        let decoded = decodeMorse(encoded.morse)
        #expect(decoded.text == original)
    }
}

// MARK: - Table Completeness

@Suite("Morse Table")
struct MorseTableTests {

    @Test("All 26 letters present in charToMorse")
    func allLettersPresent() {
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for letter in alphabet {
            #expect(charToMorse[letter] != nil, "Missing Morse code for letter \(letter)")
        }
    }

    @Test("All 10 digits present in charToMorse")
    func allDigitsPresent() {
        for digit in "0123456789" {
            #expect(charToMorse[digit] != nil, "Missing Morse code for digit \(digit)")
        }
    }

    @Test("Exactly 26 letters in table")
    func letterCount() {
        let letters = charToMorse.keys.filter { $0 >= "A" && $0 <= "Z" }
        #expect(letters.count == 26)
    }

    @Test("Exactly 10 digits in table")
    func digitCount() {
        let digits = charToMorse.keys.filter { $0 >= "0" && $0 <= "9" }
        #expect(digits.count == 10)
    }

    @Test("morseToChar is inverse of charToMorse")
    func morseToCharIsInverse() {
        for (char, morse) in charToMorse {
            #expect(morseToChar[morse] == char,
                "morseToChar[\(morse)] should be \(char)")
        }
    }

    @Test("charToMorse is inverse of morseToChar")
    func charToMorseIsInverse() {
        for (morse, char) in morseToChar {
            #expect(charToMorse[char] == morse,
                "charToMorse[\(char)] should be \(morse)")
        }
    }

    @Test("No duplicate Morse codes in table")
    func noDuplicateMorseCodes() {
        var seen = Set<String>()
        for (char, morse) in morseTable {
            #expect(!seen.contains(morse), "Duplicate Morse code \(morse) for character \(char)")
            seen.insert(morse)
        }
    }
}
