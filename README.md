# The Mobile Program #

## Files ##

This repository hosts a collection of solutions to the mobile program described 
below. The languages are as follows:

* Fourth: mobile.4th
* F#:     mobile.fs
* Perl:   mobile.pl
* Prolog: mobile.pro
* Scheme: mobile.ss

Each file also contains sample mobiles to verify correctness.

## Problem Description ##

A Mobile is either a cord of some length with a ball of some weight at the end,
or a cord on which hangs a strut somewhere in the middle.
We know the length of the whole strut as well as the length of the left 
and right strut 'parts'. 
At each of the two ends of a strut is another mobile hanging from the strut.

Building a mobile involves issues of weight and balance.
A proper mobile exhibits properties of weight and balance that
allow it to exist in space with the struts level; this is a balanced mobile.
In addition, the height of a mobile is important because 
a mobile occupies space, usually in a public place.

Write a program that creates several mobiles, both balanced and imbalanced.

The program must evaluate whether each mobile is proper based on its
balance. Output must describe each mobile and its properties.

These mobile properties must be derived (i.e. computed) from the
structure of each mobile instance the program creates.

_totalWeight_ -- 
    Compute the total weight of a mobile by traversing its
    structure and summing the weights of its sub-mobiles. 
    Assume that the weight of struts and cords is 0.

_totalHeight_ -- 
    Compute the total height of the mobile by traversing its
    structure and finding the greatest height of its sub-mobiles. 

_isBalanced_ -- 
    Determine whether a mobile is balanced.
    A balanced mobile is defined as follows:
      - A mobile with no struts is always balanced.
      - A mobile with a strut is balanced if
        -- the product of the weight of the mobile on the left with the 
           length of the left section of the strut is the same as the 
           product of the weight of the mobile on the right with the 
           length of the right section of the strut
        -- the left mobile is balanced
        -- the right mobile is balanced

A balanced mobile example hanging from a mount point, X:

                               X
                               |  <- 2 length cord
                               |
          +--------------------+----------+
          | <- 1  length cord             |  <- 5 length cord
    +-----+-----+                         |
    |           |                         |
    5      +----+------+                  |
           |           |                  |
           |           2                 20
           | 
           | 
           | 
           3 

The height of the above mobile is 9 (2 + 1 + 1 + 5 is greater than 2 + 5).
The length of the strut arms is the number of '-'.
