function uninstall-mac-pkg
    argparse 'f/forget' -- $argv

    if test (count $argv) -lt 1
        pkgutil --pkgs | sort
        return
    end

    set pkg $argv[1]
    set pkg_info (pkgutil --pkg-info $pkg)
    set path
    set -a path (string match --regex --groups-only '^volume: (.*)$' $pkg_info)
    set -a path (string match --regex --groups-only '^location: (.*)$' $pkg_info)
    set path (string join '' $path)

    sudo rm -v (__add_prefix $path (pkgutil --only-files --files $pkg))
    sudo rmdir -pv (__add_prefix $path (pkgutil --only-dirs --files $pkg | tail -r))

    if test $_flag_forget
        sudo pkgutil --forget $pkg
    end
end

function __add_prefix
    set prefix $argv[1]
    for path in $argv[2..]
        echo "$prefix/$path"
    end
end
