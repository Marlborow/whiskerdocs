# Whiskerdocs
This is my personal lightweight markdown-like syntax parser that i use to write documents.
It generates HTML and, with Puppeteer, can transform the HTML into a PDF.

## Requirements
- Lua (5.1+)
- Node.js (*unfortunately*)
- Puppeteer (installed via **npm**)

## Features
It features a plugin-based system for parsing lines and by default
supports:
- Headings, bold and italic
- Line breaks and page breaks
- Images with styling options
- Links
- Columns
- Tables
- Lists (funky archaic syntax but whatever)

### Writing Whiskerdocs
If a feature isn't demonstrated below, infer it follows Markdown syntax.
- Use :: for line breaks, and ::: for page breaks
- Use >|, |>, <| for multi-column layouts
- Use - Item and > - Nested for lists
- Inline images: \!\[alt text\](image.png) or with options (...): \!\[desc|...\](image.png)
  - c = centered
  - l = left
  - r = right
  - w:number = width
  - h:number = height

An Example test file can be found in the example directory.

### Styling Whiskerdocs
Whiskerdocs is styled via a **CSS** file located at:
**whiskerdocs/src/html/style.css**


### Usage:

To generate HTML:
```sh
./Whisker /path/to/whiskerfile.md
```

To generate PDF:
```sh
./Whisker --pdf /path/to/whiskerfile.md
```

Not tested nor should it work by default on windows.
