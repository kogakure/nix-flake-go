# Nix Flake for Go

This is following the tutorial [Is Nix Your New Terminal SUPERPOWER?](https://www.youtube.com/watch?v=m4ST2dq10no).

```sh
nix build # Build the flake
nix shell --command hello # Run the hello command
nix flake show # Show the flake information
nix develop # Enter the development environment
eval "$buildPhase"
./hello
```

```sh
nix shell github:kogakure/nix-flake-go -c hello # Run the command directly from GitHub
```
