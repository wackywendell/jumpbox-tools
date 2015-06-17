#!/usr/bin/env zsh
#local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

setopt promptsubst

autoload -U add-zsh-hook

C_RESET=$reset_color
C_DEFAULT=$FG[004]
C_PROMPT=$FG[002]
C_YELLOW=$FG[003]
C_MAGENTA=$FG[005]
BC_DRED=$BG[006]

PROMPT_FAILURE_COLOR=$FG[001]
PROMPT_VCS_INFO_COLOR=$FG[002]
GIT_DIRTY_COLOR=$FG[001]
GIT_CLEAN_COLOR=$FG[002]
GIT_PROMPT_INFO=$FG[004]

function get_hostname() {
    host=$(hostname)
    envname=`cat /opt/datadog/etc/environment 2>&1 | cut -c 5- 2>&1`
    if [[ $envname == *"No such file"* ]] || [[ $envname == "dev" ]]
    then
        if [[ $host == "dogbox-"* ]]
        then
            echo "%{$C_YELLOW%}""vm""%{$C_RESET%}";
            return;
        fi
        echo "%{$C_DEFAULT%}""local""%{$C_RESET%}";
        return
    fi
    if [[ "$envname" == "staging" ]]
    then
        echo "%{$C_MAGENTA%}""$host""%{$C_RESET%}";
    else
        echo "%{$BC_DRED%}""$host""%{$C_RESET%}";
    fi
}

PROMPT='%{$C_RESET%}$(get_hostname):%{$C_DEFAULT%}%~%{$C_RESET%} %{$GIT_PROMPT_INFO%}$(git_prompt_info)%{$GIT_DIRTY_COLOR%}$(git_prompt_status)%{$C_RESET%}%{$PROMPT_PROMPT%}ᐅ%{$C_RESET%} '

#RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$GIT_PROMPT_INFO%}) "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$GIT_DIRTY_COLOR%}✘"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$GIT_CLEAN_COLOR%}✔"
