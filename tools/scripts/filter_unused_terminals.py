def unused_terminals():
    with open("tools/sort_terminals.txt", "r", encoding="utf-8") as file:
        terminals = [line.strip() for line in file.readlines()]
    return terminals


def get_lines_to_filter():
    filter_from = "src/resources/LexerCup.flex"

    with open(filter_from, "r", encoding="utf-8") as original_file:
        for line in original_file:
            if line.rstrip() == "// Lexical Rules":
                break
        for line in original_file:
            yield line


def main():
    terminals_to_filter = unused_terminals()
    output_to = "tools/filtered_terminals.txt"

    with open(output_to, "w", encoding="utf-8") as output_file:
        for line in get_lines_to_filter():
            if line.lstrip().startswith("//") or "sym" not in line:
                output_file.write(line)
                continue

            terminal = line.split("sym.")[1].split(")")[0]

            if terminal in terminals_to_filter:
                output_file.write(f"// {line}")
            else:
                output_file.write(line)


if __name__ == "__main__":
    main()
