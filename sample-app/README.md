# Allscreenshots Demo

A sample macOS application demonstrating the AllScreenshots Swift SDK.

## Features

- URL input for capturing any website
- Device selection (Desktop HD, iPhone 14, iPad)
- Full page capture toggle
- Live screenshot preview
- Error handling with user-friendly messages

## Requirements

- macOS 13.0+
- Swift 5.9+
- AllScreenshots API key

## Setup

1. Set your API key as an environment variable:

   ```bash
   export ALLSCREENSHOTS_API_KEY=your-api-key
   ```

2. Build and run the application:

   ```bash
   cd sample-app
   swift run
   ```

   Or open in Xcode:

   ```bash
   open Package.swift
   ```

## Usage

1. Enter a URL in the text field (e.g., `https://github.com`)
2. Select a device from the dropdown:
   - **Desktop HD** - 1920x1080 resolution
   - **iPhone 14** - Mobile viewport
   - **iPad** - Tablet viewport
3. Optionally enable **Full page** to capture the entire scrollable content
4. Click **Take Screenshot**
5. The captured screenshot will appear in the result area

## Environment variables

| Variable | Required | Description |
|----------|----------|-------------|
| `ALLSCREENSHOTS_API_KEY` | Yes | Your AllScreenshots API key |

## Project structure

```
sample-app/
├── Package.swift           # Swift Package Manager configuration
├── AllscreenshotsDemo/
│   ├── App.swift           # Application entry point
│   ├── ContentView.swift   # Main UI components
│   └── ScreenshotViewModel.swift  # Business logic
├── README.md
└── LICENSE
```

## License

Apache License 2.0. See [LICENSE](LICENSE) for details.
