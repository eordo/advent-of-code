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

## [Day 6: Memory Reallocation](https://adventofcode.com/2017/day/6)

Hash the banks configuration to store what states have been seen so far.
The cycle length is the number of reallocation cycles between when a hashed state is seen for the first and second times.

## [Day 7: Recursive Circus](https://adventofcode.com/2017/day/7)

For Part 1, the root program is the only program without a parent.
For Part 2, recursively compute the stack weights of all programs.
An unbalanced program is one whose children's stack weights are not all equal.
Find the deepest unbalanced program in the tree, identify its child whose stack weight differs from the other children's, and compute the new weight from the difference.

## [Day 8: I Heard You Like Registers](https://adventofcode.com/2017/day/8)

Store register values in a Dict, and at each step, track what the highest stored value is so far.

## [Day 9: Stream Processing](https://adventofcode.com/2017/day/9)

Analyze the stream character by character.
Increment group depth when a `{` is seen, and decrement when the closing `}` is seen.
Flag when the stream is garbage and ignore score calculations.

## [Day 10: Knot Hash](https://adventofcode.com/2017/day/10)

The indexes of the slice to be reversed can wrap to the front by using `mod1`, and the slice can be reversed in place with `reverse!`.
Get the ASCII value of a Char `x` with `Int(codepoint(x))`.

## [Day 11: Hex Ed](https://adventofcode.com/2017/day/11)

Define one coordinate axis of the hex grid running north-south, the other running northeast-southwest.
Then moving in the six directions maps to the following steps:

* `n => (0, 1)`
* `ne => (1, 0)`
* `se => (1, -1)`
* `s => (0, -1)`
* `sw => (-1, 0)`
* `nw => (-1, 1)`

The taxicab distance from a point $(x, y)$ to the origin in this coordinate system is $\lvert x + y \rvert$ if $\mathrm{sgn}(x) = \mathrm{sgn}(y)$, otherwise $\max\left\{\lvert x \rvert, \lvert y \rvert\right\}$.

## [Day 12: Digital Plumber](https://adventofcode.com/2017/day/12)

Use [Graphs.jl](https://juliagraphs.org/Graphs.jl/stable/) to represent the pipe network as an undirected graph.
For Part 1, the group size is the size of the connected component containing 0.
For Part 2, the number of groups is the number of connected components.

## [Day 13: Packet Scanners](https://adventofcode.com/2017/day/13)

Let $k$ be the depth of a layer in the firewall, and let $r_k$ be the range of the $k$-th layer.
The position of the $k$-th scanner is cyclic with period $T_k = 2 (r_k - 1)$.
We consider position $0$ to be the top of the layer, i.e., where we have to pass through.

Let $t$ be the delay in picoseconds before beginning the trip.
(For Part 1, this means $t = 0$).
Moving at 1 step/ps, the time at which we would arrive at the $k$-th layer is $k + t$.

This means that the $k$-th scanner catches us if $k + t \equiv 0 \mod{T_k}$.
Analytically, solving Part 2 amounts to finding the smallest $t > 0$ such that $k + t \not\equiv 0 \mod{T_k}$ for all $k$.
In practice, we can just try $t = 1, 2, 3, \dots$ until all these incongruences hold.

## [Day 14: Disk Defragmentation](https://adventofcode.com/2017/day/14)

For Part 1, use the knot hash algorithm already implemented in Day 10.
For Part 2, use `label_components` from [Images.jl](https://github.com/JuliaImages/Images.jl).

## [Day 15: Dueling Generators](https://adventofcode.com/2017/day/15)

Note that the binary representations of two integers `A` and `B` agree in the last 16 bits if `(A - B) & 0xffff == 0`, i.e., the binary representation of the difference `A - B` has at least 16 trailing zeros.

## [Day 16: Permutation Promenade](https://adventofcode.com/2017/day/16)

The sequence of positions is cyclic, so find its period (in number of times the dance is done) by repeating the dance until the subsequent positions equal the initial positions.

## [Day 17: Spinlock](https://adventofcode.com/2017/day/17)

For Part 1, iteratively fill the buffer and find the index of 2017.
For Part 2, note that 0 is always in the first index of the buffer.
Let $p_k$ be the index where the $k$-th natural number will be inserted.
The number $k$ is inserted after 0 when $p_k = 2$.

## [Day 20: Particle Swarm](https://adventofcode.com/2017/day/20)

Simulate the particle movements for a sufficiently large number of ticks $T$ such that the same particle stays closest to the origin and no more collisions occur.
I found that $T = 500$ works.
