function fish_prompt
    set_color --bold red
    echo -n "["

    set_color yellow
    echo -n $USER

    set_color green
    echo -n "@"

    set_color blue
    echo -n (hostname)

    echo -n " "

    set_color magenta
    echo -n (prompt_pwd)

    set_color red
    echo -n "]"

    set_color normal
    echo -n "\$ "
end
