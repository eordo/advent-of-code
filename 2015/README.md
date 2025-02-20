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

## [Day 6: Probably a Fire Hazard](https://adventofcode.com/2015/day/6)

Create a bit matrix for whether the lights are on and another matrix for the corresponding brightness.
For each instruction, set the elements of each matrix within the parsed ranges accordingly.
The total number of lights on and total brightness equal the matrix sums in the end.

## [Day 7: Some Assembly Required](https://adventofcode.com/2015/day/7)

Represent each wire as a Symbol.
Emulate the circuit as a hashmap storing wires with their signal value, each of which is given by exactly one instruction.
Store in another hashmap the bit operation and list of arguments passed to that operation for each instruction.
Then evaluating any Symbol not yet in the circuit will recursively call the necessary instructions until an instruction successfully executes with integer arguments, thereby adding it to the circuit.
The circuit is complete once all Symbols evaluate to an integer.

## [Day 8: Matchsticks](https://adventofcode.com/2015/day/8)

For Part 1, use `unescape_string` to get each string with unescaped Unicode escape sequences.
Part 2 is done similarly but with `escape_string`.
In both parts, add 2 to the character count for the quotation marks at the beginning and end of the string that get neither escaped nor unescaped.

## [Day 9: All in a Single Night](https://adventofcode.com/2015/day/9)

Given $n$ cities, construct a symmetric $n \times n$ distance matrix `D`, where `D[i, j]` is the distance between the $i$-th and $j$-th cities.
The possible routes are the permutations of the integers 1 through $n$.
Iterate over all routes and use `D` to calculate the route distances.
Take the minimum and maximum of these distances.

## [Day 10: Elves Look, Elves Say](https://adventofcode.com/2015/day/10)

Each term of the sequence is a vector.
Iterate over the vector and construct the next term at the same time by counting the number of consecutive appearances of the same digit.

## [Day 11: Corporate Policy](https://adventofcode.com/2015/day/11)

Just implement the password requirements as described.
To make incrementing the password more performant, store it as a Char array instead of as a string.

## [Day 12: JSAbacusFramework.io](https://adventofcode.com/2015/day/12)

Use [JSON.jl](https://github.com/JuliaIO/JSON.jl) to parse the JSON to native Julia types.
This solution uses multiple dispatch to recursively find both all numbers and all objects with a "red" attribute.
Ignoring a "red" object (dictionary) and its children (values) is functionally the same as emptying it.

## [Day 13: Knights of the Dinner Table](https://adventofcode.com/2015/day/13)

The solution is conceptually identical to Day 9's.
Since the $n$ guests are seated in a circle, all possible seating arrangements are the permutations of the integers 1 through $n$.
Unlike in Day 9, however, the first and last guest in the permutation also experience a change in happiness from sitting next to each other.

## [Day 14: Reindeer Olympics](https://adventofcode.com/2015/day/14)

Given $n$ reindeer flying for $T$ seconds, create an $n \times T$ matrix that records the position of each reindeer at each second.
The winning distance is the maximum of the last column.
Assign points to the argmax of each column, and the winning point total is the reindeer with the most points.

## [Day 15: Science for Hungry People](https://adventofcode.com/2015/day/15)

This is a brute-force solution.
Collect the $m$ properties of the $n$ ingredients into an $m \times n$ matrix $A$.
Then iterate over all partitions of 100 into a sum of $n$ integers, representing each partition as a vector $x$ that gives an amount of each ingredient.
The resulting cookie score can be calculated from the product $Ax$.
