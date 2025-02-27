# Advent of Code 2024

## [Day 1: Historian Hysteria](https://adventofcode.com/2024/day/1)

For Part 1, sort the lists and compute their L1 distance.
For Part 2, use a `counter` on the right list.

## [Day 2: Red-Nosed Reports](https://adventofcode.com/2024/day/2)

For each report, take the differences of consecutive levels.
The report is monotonic if all the differences are of the same sign, and it is in range if the absolute values of all differences are in $[1, 3]$.
To dampen a report for Part 2: Remove one level, check the report's safety, replace the level, remove the next, and repeat.
This solution uses [InvertedIndices.jl](https://github.com/JuliaData/InvertedIndices.jl) for easy index removal.

## [Day 3: Mull It Over](https://adventofcode.com/2024/day/3)

Use regex to match and evaluate the instructions.
