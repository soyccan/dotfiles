# inspired by ohmyzsh: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

if not status is-interactive || not command -q git
    exit
end

# TODO: too many abbrs slow down fish startup

abbr ga 'git add'
abbr gaa 'git add --all'
abbr gau 'git add --update'

abbr gb 'git branch --all -vv'
abbr gbd 'git branch --delete'
abbr gbD 'git branch --delete --force'
# function gbda --description 'delete merged branches'
#     git branch --no-color --merged |
#         string match "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" |
#         command xargs git branch --delete 2>/dev/null
# end
abbr gbm 'git branch --move'

abbr gbk 'git-backup'

abbr gc 'git commit --verbose'
abbr gc! 'git commit --amend --reset-author --verbose'
abbr gc!! 'git commit --amend --reset-author --no-edit'
abbr gcm 'git commit --message'
abbr gca 'git commit --all --verbose'
abbr gca! 'git commit --all --amend --reset-author --verbose'
abbr gca!! 'git commit --all --amend --reset-author --no-edit'
abbr gcam 'git commit --all --message'

abbr gcl 'git clone --recurse-submodules'
abbr gcl1 'git clone --recurse-submodules --depth 1'
abbr gd 'git diff -w --word-diff=color'
abbr gds 'git diff -w --word-diff=color --staged'
abbr gdt 'git difftool'
abbr gf 'git fetch --all'
abbr gl 'git pull'

abbr glg 'git log --stat'
abbr glgp 'git log --stat --patch'
abbr glo 'git log --oneline --graph'
abbr gloa 'git log --oneline --graph --all'

abbr gm 'git merge'
abbr gma 'git merge --abort'
abbr gmc 'git merge --continue'
abbr gms 'git merge --squash'
abbr gmt 'git mergetool'

abbr gr 'git remote -v'
abbr grms 'git remote set-url origin'

abbr grb 'git rebase'
abbr grba 'git rebase --abort'
abbr grbc 'git rebase --continue'
abbr grbi 'git rebase --interactive'
abbr grbi! 'git rebase --interactive --root'

abbr grm 'git rm'
abbr grmc 'git rm --cached'

abbr grs 'git restore'
abbr grss 'git restore --source'
abbr grst 'git restore --staged'

abbr grh 'git reset'

abbr gsm 'git submodule'
abbr gsma 'git submodule add'

abbr gsh 'git stash'
abbr gshl 'git stash list'
abbr gshp 'git stash pop'
abbr gshs 'git stash show --patch --word-diff=color'
abbr gshx 'git stash drop'

abbr gst 'git status'
abbr gsti 'git status --ignored'

abbr gsw 'git switch'
abbr gswc 'git switch --create'
abbr gswd 'git switch --detach'

function git --description 'a safer git hook to prevent dangerous commands'
    if test "$argv[1]" = reset; and test "$argv[2]" = --hard;
        and test (command git status --short --untracked-files=no)
        echo "\"git reset --hard\" is dangerous, don't do that!"
        echo "Consider backing up & dropping local changes using \"git stash\""
        return 1
    end

    if test "$argv[1]" = restore; and test "$argv[2]" != --worktree;
        and test (command git diff --diff-filter=M --name-only -- "$argv[2]")
        echo "\"git restore\" discards local changes of specified files: $argv[2..-1]"
        echo "If you are sure want to proceed, type \"git restore --worktree\""
        return 1
    end

    command git $argv
end

function git-add-downstream
    git remote rename origin upstream
    git remote add origin $argv[1]
end

function git-backup
    if test (git stash) != 'No local changes to save'
        git stash apply
    end
end

function git-lazypull --description 'pull without switching branch'
    if test (count $argv) = 1
        set repo origin
        set refspec $argv[1]
    else if test (count $argv) = 2
        set repo $argv[1]
        set refspec $argv[2]
    else
        echo 'Wrong number of arguments'
    end
    git fetch $repo $refspec
    echo "Resetting refs/heads/$refspec to refs/remotes/$repo/$refspec"
    git update-ref "refs/heads/$refspec" "refs/remotes/$repo/$refspec"
end

function git-switch-keep-stash
    if test (git stash) != 'No local changes to save'
        git switch $argv
        git stash pop
    else
        git switch $argv
    end
end

function git-sync-upstream --description 'sync the main/master branch with the upstream repo, \
without switching branch'
    set origin_repo 'origin'
    set upstream_repo 'upstream'

    # get the main branch ref of upstream repo
    set main_branch_remote (git symbolic-ref "refs/remotes/$upstream_repo/HEAD")
    set main_branch_local (string replace "refs/remotes/$upstream_repo/" 'refs/heads/' $main_branch_remote)

    # fetch the main branch only
    git fetch $upstream_repo HEAD

    echo "Resetting $main_branch_local to $main_branch_remote"
    git update-ref $main_branch_local $main_branch_remote

    git push $origin_repo $main_branch_local
end
