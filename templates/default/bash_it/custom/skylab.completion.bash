function _skylab_c11cbf52ee0dc1c9_complete {
    export COMP_LINE COMP_POINT COMP_WORDBREAKS;
    local RESULT STATUS;

    RESULT="$(/usr/local/bin/skylab _completion)";
    STATUS=$?;

    local cur;
    _get_comp_words_by_ref -n : cur;


    if [ $STATUS -eq 200 ]; then
        _filedir;
        return 0;

    elif [ $STATUS -ne 0 ]; then
        echo -e "$RESULT";
        return $?;
    fi;

    COMPREPLY=(`compgen -W "$RESULT" -- $cur`);

    __ltrim_colon_completions "$cur";
};

complete -F _skylab_c11cbf52ee0dc1c9_complete skylab;
