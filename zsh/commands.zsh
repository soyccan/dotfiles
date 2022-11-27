# Convinient commands

mdcd() {
    mkdir -pv "$@" && cd "$@"
}

size-tree() {
    du "$@" | tail -r | awk '{print $0 ":" $1}' | sed 's;[^/]*/;|____;g;s;____|; |;g'
}

# process status
# -f (full format): uid, pid, parent pid, recent CPU usage, process start time, controlling tty, elapsed CPU usage, command
# -j : user, pid, ppid, pgid, sess, jobc, state, tt, time, command
# -l : uid, pid, ppid, flags, cpu, pri, nice, vsz=SZ, rss, wchan, state=S, paddr=ADDR, tty, time, command=CMD
# -v : pid, state, time, sl, re, pagein, vsz, rss, lim, tsiz, %cpu, %mem, and command
# u (user-oriented): user, pid, %cpu, %mem, vsz, rss, tt, state, start, time, and command
# a : all users
# x : include tty-less
# -A / -e : all
# -a : all except tty-less
# -m : sorted by memory
# -r : sorted by CPU
# -E : show environment
# -w / -ww : wider output
p() {
    if has ag; then
        _grep=ag
    else
        _grep=grep
    fi

    # $1 : pattern
    # $2.. : options for ps
    # rss : resident set size = physical memory usage
    # first line is duplicated to stderr, useful when piping result to grep
    if [[ "$1" ]]; then
        ps -eo user,pid,ppid,lwp,state,start,time,etime,command $@[2,$] \
            | tee >(sed -n '1p' >&2) | "$_grep" -i "$1"
    else
        ps -eo user,pid,ppid,lwp,state,start,time,etime,command
    fi
}

# Show colorbar to test terminal color
colorbar() {
    awk 'BEGIN{
        s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
        for (colnum = 0; colnum<77; colnum++) {
            r = 255-(colnum*255/76);
            g = (colnum*510/76);
            b = (colnum*255/76);
            if (g>255) g = 510-g;
                printf "\033[48;2;%d;%d;%dm", r,g,b;
                printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
                printf "%s\033[0m", substr(s,colnum+1,1);
            }
        printf "\n";
    }'
}

fonttest() {
    echo -e '\e[1mbold\e[22m'
    echo -e '\e[2mdim\e[22m'
    echo -e '\e[3mitalic\e[23m'
    echo -e '\e[4munderline\e[24m'
    echo -e '\e[4:1mthis is also underline (new in 0.52)\e[4:0m'
    echo -e '\e[21mdouble underline (new in 0.52)\e[24m'
    echo -e '\e[4:2mthis is also double underline (new in 0.52)\e[4:0m'
    echo -e '\e[4:3mcurly underline (new in 0.52)\e[4:0m'
    echo -e '\e[5mblink (new in 0.52)\e[25m'
    echo -e '\e[7mreverse\e[27m'
    echo -e '\e[8minvisible\e[28m <- invisible (but copy-pasteable)'
    echo -e '\e[9mstrikethrough\e[29m'
    echo -e '\e[53moverline (new in 0.52)\e[55m'

    echo -e '\e[31mred\e[39m'
    echo -e '\e[91mbright red\e[39m'
    echo -e '\e[38:5:42m256-color, de jure standard (ITU-T T.416)\e[39m'
    echo -e '\e[38;5;42m256-color, de facto standard (commonly used)\e[39m'
    echo -e '\e[38:2::240:143:104mtruecolor, de jure standard (ITU-T T.416) (new in 0.52)\e[39m'
    echo -e '\e[38:2:240:143:104mtruecolor, rarely used incorrect format (might be removed at some point)\e[39m'
    echo -e '\e[38;2;240;143;104mtruecolor, de facto standard (commonly used)\e[39m'

    echo -e '\e[46mcyan background\e[49m'
    echo -e '\e[106mbright cyan background\e[49m'
    echo -e '\e[48:5:42m256-color background, de jure standard (ITU-T T.416)\e[49m'
    echo -e '\e[48;5;42m256-color background, de facto standard (commonly used)\e[49m'
    echo -e '\e[48:2::240:143:104mtruecolor background, de jure standard (ITU-T T.416) (new in 0.52)\e[49m'
    echo -e '\e[48:2:240:143:104mtruecolor background, rarely used incorrect format (might be removed at some point)\e[49m'
    echo -e '\e[48;2;240;143;104mtruecolor background, de facto standard (commonly used)\e[49m'

    echo -e '\e[21m\e[58:5:42m256-color underline (new in 0.52)\e[59m\e[24m'
    echo -e '\e[21m\e[58;5;42m256-color underline (new in 0.52)\e[59m\e[24m'
    echo -e '\e[4:3m\e[58:2::240:143:104mtruecolor underline (new in 0.52) (*)\e[59m\e[4:0m'
    echo -e '\e[4:3m\e[58:2:240:143:104mtruecolor underline (new in 0.52) (might be removed at some point) (*)\e[59m\e[4:0m'
    echo -e '\e[4:3m\e[58;2;240;143;104mtruecolor underline (new in 0.52) (*)\e[59m\e[4:0m'
}

# Usage: program < input.txt | overwrite input.txt
overwrite() {
    n=$(tee >(cat 1<> "$1") | wc -c)
    truncate -s "$n" "$1"
}

urlencode() {
    # https://blog.longwin.com.tw/2017/12/bash-shell-curl-send-urlencode-args-2017/
    quoted=$(curl --silent --write-out '%{url_effective}' \
                  --get --data-urlencode "$1" '')
    ret=$?
    if [[ $ret != 3 ]]; then
        echo "Unexpected error" >&2
        return 1
    fi
    echo "${quoted##/?}"
}

urldecode() {
    unquoted="${1//+/ }"
    printf '%b' "${unquoted//%/\\x}"
}


shell-speed-test() {
    for i in $(seq 1 10); do time $SHELL -i -c exit; done
}

