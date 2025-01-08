# Introduction

This is my basic neovim configuration.

# Tacled pitfalls

## Including luarocks modules

You might be struggled trying to import a luarocks module in your neovim setup files. Follow the next steps...

    1. Assumed you have installed luarock.
    2. Add luarocks path to your ~/.zshrc shell startup file.
        `cat ~/.zshrc >> "eval $"luarocks --lua-version=<version> path --bin"`

Notice that in the step the arg `--lua-version` is included. This is because neovim might be using a different version.
