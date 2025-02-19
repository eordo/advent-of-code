# Advent of Code 2015

## [Day 1: Not Quite Lisp](https://adventofcode.com/2015/day/1)

For Part 1, count the number of times `(` and `)` occur in the instructions.
For Part 2, walk through the instructions and track the current floor.

## [Day 2: I Was Told There Would Be No Math](https://adventofcode.com/2015/day/2)

For each box, parse its dimensions to calculate the area and perimeter of each face and the volume of the box.

## [Day 3: Perfectly Spherical Houses in a Vacuum](https://adventofcode.com/2015/day/3)

Store the coordinates of visited houses in a set.
The number of houses receiving at least one present is the size of this set.

## [Day 4: The Ideal Stocking Stuffer](https://adventofcode.com/2015/day/4)

There is no standard library implementation of the MD5 hash function, so use [MD5.jl](https://github.com/JuliaCrypto/MD5.jl).
This is a brute-force solution: Starting from 1, append the number to the key, hash the result, and see if it leads with the needed number of 0s.

## [Day 5: Doesn't He Have Intern-Elves For This?](https://adventofcode.com/2015/day/5)

Just implement the rules as described.
