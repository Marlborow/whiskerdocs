# Whiskerdocs
This is my personal lightweight markdown-like syntax parser that i use to write documents.
It generates HTML and, with Puppeteer, can transform the HTML into a PDF.

## Requirements
- **Lua** (5.1+)
- **Node.js** (*unfortunately*)
- **Puppeteer** (installed via **npm**)

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
- Comments
### Writing Whiskerdocs
If a feature isn't demonstrated below, infer it follows Markdown syntax.
- Headers act as they normally would with the addition:
    - \# header | **arg** where arg could equal:
        - (**c**) entered
        - (**l**) left
        - (**r**) right
- Use ;; at the start of a line for a comment.
- Use :: for line breaks, and ::: for page breaks
- Use >|, |>, <| for multi-column layouts
- Use - Item and > - Nested for lists
- Inline images: \!\[alt text\](image.png) or with options (...): \!\[desc|...\](image.png)
  - (**c**) entered
  - (**l**) eft
  - (**r**) ight
  - (**w**:*number*) width
  - (**h**:*number*) height

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

Windows not tested nor should it work by default on windows.
