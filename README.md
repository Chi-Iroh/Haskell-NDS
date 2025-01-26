# Haskell-NDS

This repository is a PoC to run Haskell on Nintendo DS.  
It uses the JHC compiler (not to be confused with GHC compiler) to transpile Haskell code to C code.  
The C code will be compiled using devkitpro compiler then.  

## JHC

JHC being old and unmaintained, the `jhc-components` is a fork of a fork of a fork etc.. which has been updated to build with a recent GHC.  
Go see [jhc-components/README.md] to build it, then you may proceed.  

## JHC oddities

JHC has some issues with if then else, the following code doesn't compile despite being valid and produces a `parser error` with JHC :  
```hs
main = do
    if True then do
        print "true"
    else
        print "false"
```
You must do this instead :  
```hs
main = do
    if True then do
            print "true"
        else
            print "false"
```

## Build

Simply run `make`.  

## Run

DeSmuME on Linux (0.9.13 for now) cannot run homebrew ROMs using libnds-v2 (it does open the file but does nothing), as libnds has undergone some major changes.  
I don't know about DeSmuME on Windows.  

With melonDS on Linux (0.9.5 for now), it's a bit weird.  
After libnds-v2 was released, a [pull request](https://github.com/melonDS-emu/melonDS/pull/2197) was made to update melonDS to run libnds-v2.  
That branch perfectly runs the PoC, but even if the PR was merged, the [upstream version](https://github.com/melonDS-emu/melonDS/commit/15c3faa26e879bdcff615558ded6dd886681ccae) doesn't run the PoC (white screen doing nothing).  
I dont't know either about melonDS on Windows.  

I tested on real hardware with a Nintendo DS Lite, and it perfectly runs.  

## Credits

Many thanks to Brian McKenna for his blog [article](https://brianmckenna.org/blog/learn_nintendo_ds_a_haskell), from which I've downloaded the Makefile, include and source files.  
They have slightly been updated to be able to compile though, and they may evolve further if I decide to improve this project.  
