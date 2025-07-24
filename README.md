# Minimal LaTeX Neovim Setup (vim-plug + VimTeX + nvim-cmp)

This configuration provides a minimal but powerful LaTeX editing environment in Neovim using:

* **VimTeX** for LaTeX integration and compilation
* **nvim-cmp** for autocompletion
* **LuaSnip** for snippet support
* **texlab** for LSP features (diagnostics, formatting, etc.)
* **Zathura** as the PDF previewer
* **vim-plug** as the plugin manager

---

## Prerequisites

Make sure you have the following installed on **Ubuntu**:

### 1. **Neovim**

```bash
sudo apt install neovim
```

### 2. **LaTeX toolchain (for VimTeX)**

```bash
sudo apt install texlive-full
```

> Alternatively, install a minimal set:

```bash
sudo apt install texlive-latex-base texlive-latex-recommended texlive-latex-extra latexmk
```

### 3. **Zathura PDF viewer (optional)**

```bash
sudo apt install zathura
```

### 4. **Node.js (for snippet loader support)**

```bash
sudo apt install nodejs npm
```

### 5. **Install `texlab` (LaTeX LSP)**

You can use `cargo` or download the binary manually:

```bash
# If you have Rust installed
cargo install texlab
```

Or download from: [https://github.com/latex-lsp/texlab/releases](https://github.com/latex-lsp/texlab/releases)

Ensure `texlab` is in your PATH:

```bash
sudo mv texlab /usr/local/bin/
```

---

## Setup Instructions

### 1. Create config directory (if not done already)

```bash
mkdir -p ~/.config/nvim
```

### 2. Install `vim-plug`

```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### 3. Add the configuration

Save the provided `init.lua` content to:

```bash
~/.config/nvim/init.lua
```

### 4. Open Neovim and install plugins

Open Neovim:

```bash
nvim
```

Then run:

```vim
:PlugInstall
```

Wait for all plugins to finish installing.

---

## Usage

* Open a `.tex` file: `nvim myfile.tex`
* Use `<Ctrl-s>` to save
* Use `\ll` to compile via `latexmk` (VimTeX default)
* Use `<Tab>` and `<Ctrl-Space>` for autocompletion
* Output is auto-previewed in **Zathura**

---

## Notes

* If spell checking doesn't work, install the required dictionary:

  ```bash
  sudo apt install aspell-en
  ```
* If you prefer a different PDF viewer, adjust:

  ```lua
  vim.g.vimtex_view_method = 'zathura'
  ```

---

## Screenshot (Optional)

You can include a screenshot showing VimTeX and Zathura side-by-side.

---

## License

MIT
