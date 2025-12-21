from itertools import combinations
from math import dist, prod


def parse_input(filename):
    with open(filename) as f:
        points = {
            i: tuple(map(int, line.split(',')))
            for i, line in enumerate(f)
        }
    return points


def solve_puzzle(input_file):
    points = parse_input(input_file)
    closest_points = sorted(
        combinations(points.keys(), 2),
        key=lambda x: dist(points[x[0]], points[x[1]]),
        reverse=True
    )
    
    # Connect circuits.
    circuits = [{k} for k in points.keys()]
    def find_circuit(x):
        for idx, circuit in enumerate(circuits):
            if x in circuit:
                return idx
        return None

    def connect(i, j, circuits):
        idx_1, idx_2 = find_circuit(i), find_circuit(j)
        if idx_1 != idx_2:
            circuits[idx_1] = circuits[idx_1] | circuits[idx_2]
            del circuits[idx_2]
    
    # Part 1.
    for _ in range(1000):
        i, j = closest_points.pop()
        connect(i, j, circuits)
    circuits = sorted(circuits, key=len, reverse=True)
    circuit_lengths = list(map(len, circuits))
    ans_1 = prod(circuit_lengths[:3])
    
    # Part 2.
    while len(circuits) != 1:
        i, j = closest_points.pop()
        connect(i, j, circuits)
    ans_2 = points[i][0] * points[j][0]
    return ans_1, ans_2


if __name__ == "__main__":
    ans_1, ans_2 = solve_puzzle('inputs/day_08.txt')
    print("2025 Day 8")
    print(f"Part 1: {ans_1}")
    print(f"Part 2: {ans_2}")
