# Advent of Code 2017

## [Day 1: Inverse Captcha](https://adventofcode.com/2017/day/1)

For Part 2, use `mod1` to jump forward from each index by half the length of the list.

## [Day 2: Corruption Checksum](https://adventofcode.com/2017/day/2)

For Part 2, sort each row `x` and iterate over it in a double for loop.
Find when `x[i]` divides an element of `x[(i + 1):end]` evenly.

## [Day 3: Spiral Memory](https://adventofcode.com/2017/day/3)

The key to both parts is how to compute the grid coordinates of any number $n$ in the spiral.
Let $n = 1$ be at the origin, and imagine infinitely many concentric squares of integer side length.
Now fix any $n > 1$.
We find that it lies in the $k$-th square, where
$$
k = \left\lceil \frac{\lfloor \sqrt{n - 1} \rfloor}{2} \right\rceil
$$
The part of the spiral in the $k$-th square starts at $(k, -k + 1)$; the value allocated there is
$$
n_k = 1 + \sum_{i=1}^{k-1} 8i
$$
since each square fits 8 more numbers than the previous square.
Then we can find the coordinates of $n$ by walking $n - n_k$ steps counterclockwise starting from the coordinates of $n_k$.
For a more rigorous analytic formulation of this pattern, read about the [Ulam spiral](https://en.wikipedia.org/wiki/Ulam_spiral).

For Part 1, the number of steps is the $L^1$ distance of the coordinates of the input `x`.
For Part 2, map the coordinates of each natural number to the value allocated there.

## [Day 4: High-Entropy Passphrases](https://adventofcode.com/2017/day/4)

Analyze each passphrase as a string vector.
For both parts, use `allunique` to check if a passphrase has any repeated words.
For Part 2, sort the characters in each word of a passphrase; there will be repeated sorted words if any of the words is an anagram of another.

## [Day 5: A Maze of Twisty Trampolines, All Alike](https://adventofcode.com/2017/day/5)

Store the offsets as a vector and mutate each element when its index corresponds to the current instruction.
