from collections import defaultdict


def parse_input(filename):
    with open(filename) as f:
        diagram = [list(line.strip()) for line in f] 
    return diagram


def solve_puzzle(input_file):
    diagram = parse_input(input_file)
    split_count = 0
    timelines = defaultdict(int, {diagram[0].index('S'): 1})
    for row in diagram:
        for j, ch in enumerate(row):
            if ch == '^' and j in timelines:
                # Part 1.
                split_count += 1
                # Part 2.
                timelines[j-1] += timelines[j]
                timelines[j+1] += timelines[j]
                del timelines[j]
    return split_count, sum(timelines.values())


if __name__ == "__main__":
    ans_1, ans_2 = solve_puzzle('inputs/day_07.txt')
    print("2025 Day 7")
    print(f"Part 1: {ans_1}")
    print(f"Part 2: {ans_2}")
