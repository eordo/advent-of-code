#!/usr/bin/python
"""
This script gets Advent of Code puzzle input from the command line. Once 
logged in to Advent of Code, the session cookie must be saved locally in the 
same directory in a file named session.txt.

Usage: python get_input.py YEAR DAY

Puzzle inputs are written to /YEAR/inputs/day_DAY.txt.
"""

import argparse
import requests
from pathlib import Path


BASE = "https://adventofcode.com"
USER_AGENT = ("https://github.com/eordo/advent-of-code/blob/master/get_input.py"
                " by Eric O. at https://eordonez.com")
SESSION = Path("session.txt").read_text()


parser = argparse.ArgumentParser(description="Get puzzle input")
parser.add_argument("year", type=int, help="year")
parser.add_argument("day", type=int, help="day")

args = parser.parse_args()

url = f'{BASE}/{args.year}/day/{args.day}/input'
response = requests.get(url,
    headers={"User-Agent": USER_AGENT},
    cookies={"session": SESSION})

if not response.ok:
    print(f'Request at {url} failed with status code {response.status_code}.')
    quit()

# For file names, day numbering starts at 01.
if args.day < 10:
    day_num = f'0{args.day}'
else:
    day_num = str(args.day)

# Save puzzle input to a .txt file.
outdir = Path(f'{args.year}/inputs')
outdir.mkdir(parents=True, exist_ok=True)
filename = f'day_{day_num}.txt'
filepath = outdir / filename

if not filepath.exists():
    with open(filepath, 'w') as f:
        f.write(response.text)
else:
    prompt_str = f'{filepath} already exists. Overwrite? [Y/n] '
    yeses = ["yes", "y", ""]
    nos = ["no", "n"]
    acceptable_answers = yeses + nos
    answer = input(prompt_str).lower()
    while answer not in acceptable_answers:
        answer = input(prompt_str).lower()    
    if answer in yeses:
        with open(filepath, 'w') as f:
            f.write(response.text)        
    else:
        print("Exiting without doing anything.")
        quit()

print(f'Puzzle input successfully written to {filepath}')
