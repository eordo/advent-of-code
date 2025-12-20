def get_neighbors(x, y, max_x, max_y):
    neighbor_coords = [
        (x + dx, y + dy)
        for dx, dy in [
            (-1, -1), (-1, 0), (-1, 1), (0, 1),
            (1, 1), (1, 0), (1, -1), (0, -1)
        ]
        if 0 <= x + dx < max_x and 0 <= y + dy < max_y
    ]
    return neighbor_coords


def is_accessible(neighbors_list, grid):
    surrounding_count = sum(grid[x][y] == '@' for (x, y) in neighbors_list)
    return surrounding_count < 4


def parse_input(filename):
    with open(filename) as f:
        grid = [list(line.strip()) for line in f] 
    return grid


def part_1(grid):
    m, n = len(grid), len(grid[0])
    roll_neighbors = [
        get_neighbors(x, y, m, n)
        for x in range(m)
        for y in range(n)
        if grid[x][y] == '@'
    ]
    return sum(is_accessible(neighbors, grid) for neighbors in roll_neighbors)


def part_2(grid):
    m, n = len(grid), len(grid[0])
    accessible_rolls = [
        (x, y)
        for x in range(m)
        for y in range(n)
        if grid[x][y] == '@' and is_accessible(get_neighbors(x, y, m, n), grid)
    ]
    roll_count = len(accessible_rolls)
    if roll_count > 0:
        for (x, y) in accessible_rolls:
            grid[x][y] = '.'
        roll_count += part_2(grid)
    return roll_count


def solve_puzzle(input_file):
    grid = parse_input(input_file)
    ans_1 = part_1(grid)
    ans_2 = part_2(grid)
    return ans_1, ans_2


if __name__ == "__main__":
    ans_1, ans_2 = solve_puzzle('inputs/day_04.txt')
    print("2025 Day 4")
    print(f"Part 1: {ans_1}")
    print(f"Part 2: {ans_2}")
