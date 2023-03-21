# Nois Documentation (v2)

## Building

1.  Install mdbook:

    ```
    $ cargo install mdbook
    ```

2.  Build

    ```
    $ mdbook build
    ```

3.  The output will be in the `book` subdirectory. Open it in your web browser.

    _Firefox:_

    ```bash
    $ firefox book/index.html                       # Linux
    $ open -a "Firefox" book/index.html             # OS X
    $ Start-Process "firefox.exe" .\book\index.html # Windows (PowerShell)
    $ start firefox.exe .\book\index.html           # Windows (Cmd)
    ```

    _Chrome:_

    ```bash
    $ google-chrome book/index.html                 # Linux
    $ open -a "Google Chrome" book/index.html       # OS X
    $ Start-Process "chrome.exe" .\book\index.html  # Windows (PowerShell)
    $ start chrome.exe .\book\index.html            # Windows (Cmd)
    ```

4.  To rebuild changes automatically, use

    ```
    $ mdbook watch
    ```
