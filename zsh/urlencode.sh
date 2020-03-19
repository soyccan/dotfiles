urlencode() {
    # https://blog.longwin.com.tw/2017/12/bash-shell-curl-send-urlencode-args-2017/
    local quoted="$(curl --silent --write-out %{url_effective} --get --data-urlencode "$1" '')" ret=$?
    if [ $ret != 3 ]; then
        echo "Unexpected error" >&2
        return -1
    fi
    echo "${quoted##/?}"
    return 0
}
urldecode() {
    local unquoted="${1//+/ }"
    printf '%b' "${unquoted//%/\\x}"
}
