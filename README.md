# Introduction

This is my basic neovim configuration.

## Including luarocks modules

You might be struggled trying to import a luarocks module in your neovim setup files. Follow the next steps...

    1. Assuming luarocks is installed.
    2. Add luarocks path to your ~/.zshrc shell startup file.
        `cat ~/.zshrc >> "eval $"luarocks --lua-version=<version> path --bin"`
