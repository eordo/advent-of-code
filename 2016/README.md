# Advent of Code 2016

## [Day 1: No Time for a Taxicab](https://adventofcode.com/2016/day/1)

Define directional orientations with 1 for up, 2 for right, 3 for down, and 4 for left.
Let the starting coordinates be `(0, 0)` and starting orientation be 1.
For each instruction, reorient by turning right or left and add or subtract the distance for the appropriate coordinate.
The number of blocks to the HQ is the $L^1$ norm of the ending coordinates.

## [Day 2: Bathroom Security](https://adventofcode.com/2016/day/2)

For Part 1, imagine the keypad as a $3 \times 3$ matrix with its entries enumerated 1 to 9, left to right.
For Part 2, note that the keypad forms a disc of radius 2 under the $L^1$ norm, and its entries are enumerated 1 to 13 in hexadecimal, left to right.

## [Day 3: Squares With Three Sides](https://adventofcode.com/2016/day/3)

Given three side lengths, sort them in ascending order.
If the sum of the first and second lengths is strictly greater than the third, then these sides form a valid triangle.

## [Day 4: Security Through Obscurity](https://adventofcode.com/2016/day/4)

For Part 1, count the letters in the encrypted name using `counter` from [DataStructures.jl](https://github.com/JuliaCollections/DataStructures.jl).
For Part 2, see if all of "north," "pole," and "object" occur in the decrypted name.

## [Day 5: How About a Nice Game of Chess?](https://adventofcode.com/2016/day/5)

The hashing process is the same as implemented for [2015 Day 4](../2015/README.md/#day-4-the-ideal-stocking-stuffer).

