# Advent of Code 2018

## [Day 1: Chronal Calibration](https://adventofcode.com/2018/day/1)

For Part 2, store the seen frequencies in a Set.

## [Day 2: Inventory Management System](https://adventofcode.com/2018/day/2)

In Part 2, the `splat` creates a new function that applies `!=` element-wise on two strings.

## [Day 3: No Matter How You Slice It](https://adventofcode.com/2018/day/3)

Represent the fabric with a matrix where each entry is the number of claims made on that square inch of fabric.
For Part 2, the only non-overlapping claim is the one where the corresponding slice of the matrix equals 1 everywhere.

## [Day 4: Repose Record](https://adventofcode.com/2018/day/4)

Since the dates are in ISO format, sorting the entries lexicographically also sorts them chronologically.
Iterate through the ordered entries and map the current guard on duty to the total time he sleeps and to a record of how many times he is asleep in each of the minutes from 00:00 to 00:59.

## [Day 5: Alcehmical Reduction](https://adventofcode.com/2018/day/5)

Note that two alphabetic characters are an uppercase/lowercase pair if the absolute difference of their character values equals 32.
