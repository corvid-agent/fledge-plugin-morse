# fledge-plugin-morse

Encode and decode Morse code.

## Install

```bash
fledge plugins install corvid-agent/fledge-plugin-morse
```

## Usage

```bash
# Encode text to Morse code
fledge morse encode "Hello World"
# .... . .-.. .-.. --- / .-- --- .-. .-.. -..

# Decode Morse code back to text
fledge morse decode ".... . .-.. .-.. --- / .-- --- .-. .-.. -.."
# HELLO WORLD

# Show the full Morse code table
fledge morse table
```

## Development

Build the plugin:

```bash
swift build
```

Run the tests:

```bash
swift test -Xswiftc -F -Xswiftc /Library/Developer/CommandLineTools/Library/Developer/Frameworks \
  -Xlinker -rpath -Xlinker /Library/Developer/CommandLineTools/Library/Developer/Frameworks
```

## Links

- [Documentation](https://corvid-agent.github.io/fledge-plugin-morse/)
- [fledge](https://github.com/CorvidLabs/fledge)
