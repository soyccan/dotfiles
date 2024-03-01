if not status is-interactive || not command -q fasd
    exit
end

function __fasd_preexec --on-event fish_preexec
    command fasd --proc (__fasd_split_cmdline $argv[1])
end

function __fasd_split_cmdline --description "Split a command line string into tokens"
    # https://stackoverflow.com/a/60346363
    set oldline (commandline)
    commandline $argv[1]
    commandline --tokenize
    commandline $oldline
end
