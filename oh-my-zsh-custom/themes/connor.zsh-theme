local return_code="%(?..%F{red}%? ↵%f)"


if [[ $UID -eq 0 ]]; then
    local user_host='%F{red}%n@%m%f'
    local user_symbol='#'
else
    local user_host='%F{green}%n@%m%f'
    local user_symbol='$'
    local bracket='$fg_bold[blue]['
    local end='$fg_bold[blue]]'
    local time='%F{red}%T%f'
fi

local current_dir='%F{cyan}%~%f'

local git_branch='$(git_prompt_info)%{$reset_color%}'

PROMPT="╭─${bracket} ${time} ${end} ${user_host} ${current_dir} ${git_branch}
╰─%B${user_symbol}%b "
RPS1="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %f"

ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}✗%f"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{green}✔%f"
