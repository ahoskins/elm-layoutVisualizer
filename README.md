# Elm-layoutVisualizer
Experimenting with the Elm programming language, a functional reactive language that compiles to JavaScript.

This Elm code compiles to a very-limited CSS position and display visualizer.

**Related Resources:**
- [elm architecture](https://github.com/evancz/elm-architecture-tutorial)
- [elm cli](http://elm-lang.org/get-started)
- functional reactive programming in js using [bacon.js](https://github.com/baconjs/bacon.js)
- [reactive-extensions](https://github.com/Reactive-Extensions/RxJS)
- reactive js at [netflix (talk)](https://www.youtube.com/watch?v=XRYN2xt11Ek)
- adventures with elm [slides](http://www.slideshare.net/theburningmonk/my-adventure-with-elm)


# run
First install [elm](http://elm-lang.org/install).

`git clone` and `cd` into the root of this project.  Install the required packages, then start the local server.  The server seems to watch all files for changes
and errors are given right in the client window without opening dev tools or anything.

    $ elm package install
    $ elm reactor
