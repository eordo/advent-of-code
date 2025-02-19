# Advent of Code

This repository is for my Julia solutions to [Advent of Code](https://adventofcode.com/).
I'm attempting to complete every calendar starting from 2015.

## Getting puzzle inputs

`get_input.py` is a Python script that I use to automate getting and saving puzzle inputs.
After logging in to Advent of Code, save the session cookie in a file named `session.txt`.
Then the puzzle input for any year and day can be fetched from the command line by running

```bash
python get_input.py YEAR DAY
```

The input will be saved to `/YEAR/inputs/day_DAY.txt`.
