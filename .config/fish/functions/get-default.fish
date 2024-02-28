function get-default
    if set -q $argv[1]
        eval "echo \$$argv[1]"
    else
        echo $argv[2]
    end
end
