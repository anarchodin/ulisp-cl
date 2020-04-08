# uLisp in Common Lisp

The code here is a simple package in Common Lisp to emulate the features allowed
by [uLisp](http://www.ulisp.com/show?3L), a mostly CL-like language that runs on
various microcontrollers. The code at present does not have any implementation
of the Arduino-like functions, but it should be possible to implement at least
some of them on various single-board computers (like the Raspberry Pi) or with
appropriate USB hardware (such as FTDI FT232H boards).

## Caveats

I've not tried to mess with the readtable, so the full selection of CL reader
macros is active. uLisp only supports a select few, and in particular turns `#'`
into a no-op, which this code does not.

The vast majority of functions exposed are simply exported from the
`COMMON-LISP` package. There are certainly minor differences in behaviour, and
there may be some fairly large ones I haven't noticed.

## Licence

Given the triviality of the code herein, and my own preferences, the contents of
this repository are under [CC0][cc0]. In short, all copyright is disclaimed
where possible, and an extremely permissive licence applied where it is not.

[cc0]: https://creativecommons.org/publicdomain/zero/1.0/
