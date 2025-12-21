from math import prod


def check_work(nums_list, ops):
    m, n = len(nums_list), len(ops)
    grand_total = 0
    for nums, op in zip(nums_list, ops):
        if op == '+':
            grand_total += sum(nums)
        elif op == '*':
            grand_total += prod(nums)
    return grand_total


def parse_left_to_right(worksheet):
    ops = worksheet[-1].split()
    n = len(ops)
    rows = [list(map(int, line.split())) for line in worksheet[:-1]]
    nums_list = [[row[j] for row in rows] for j in range(n)]
    return nums_list, ops


def parse_right_to_left(worksheet):
    m, n = len(worksheet), len(worksheet[0])
    nums = []
    nums_list = []
    ops = []
    end_of_problem = False
    for j in reversed(range(n)):
        digits = []
        for i in range(m):
            try:
                current_ch = worksheet[i][j]
            except:
                continue
            if current_ch.isdigit():
                digits.append(current_ch)
            elif current_ch in ('+', '*'):
                ops.append(current_ch)
                end_of_problem = True
        if digits:
            num = int(''.join(digits))
            nums.append(num)
        if end_of_problem:
            end_of_problem = False
            nums_list.append(nums)
            nums = []
    return nums_list, ops


def part_1(worksheet):
    nums_list, ops = parse_left_to_right(worksheet)
    return check_work(nums_list, ops)
    

def part_2(worksheet):
    nums_list, ops = parse_right_to_left(worksheet)
    return check_work(nums_list, ops)


def solve_puzzle(input_file):
    with open(input_file) as f:
        worksheet = f.readlines()
    ans_1 = part_1(worksheet)
    ans_2 = part_2(worksheet)
    return ans_1, ans_2


if __name__ == "__main__":
    ans_1, ans_2 = solve_puzzle('inputs/day_06.txt')
    print("2025 Day 6")
    print(f"Part 1: {ans_1}")
    print(f"Part 2: {ans_2}")
