def parse_input(filename):
    rotations = []
    with open(filename) as f:
        for line in f.readlines():
            direction = line[0]
            distance = int(line[1:])
            if direction == 'L':
                distance *= -1
            rotations.append(distance)
    return rotations


def part_1(rotations, position=50):
    zero_count = 0
    for rotation in rotations:
        position = (position + rotation) % 100
        if position == 0:
            zero_count += 1
    return zero_count


def part_2(rotations, position=50):
    zero_count = 0
    for rotation in rotations:
        for _ in range(abs(rotation)):
            position += (-1 if rotation < 0 else 1)
            position %= 100
            if position == 0:
                zero_count += 1
    return zero_count


def solve_puzzle(input_file):
    rotations = parse_input(input_file)
    ans_1 = part_1(rotations)
    ans_2 = part_2(rotations)
    return ans_1, ans_2


if __name__ == "__main__":
    ans_1, ans_2 = solve_puzzle('inputs/day_01.txt')
    print("Advent of Code 2025")
    print(f"Part 1: {ans_1}")
    print(f"Part 2: {ans_2}")
