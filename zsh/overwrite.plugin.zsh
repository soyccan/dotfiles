# Usage:
#     program < input.txt | overwrite input.txt

overwrite() {
    n="$(tee >(cat 1<> "$1") | wc -c)"
    truncate -s "$n" "$1"
}
