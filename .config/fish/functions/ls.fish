function ls --wraps eza --description 'Enhanced ls replacement with eza'
    if not command -q eza
        command ls $argv
        return
    end

    # تحديد ما إذا كان الطرف يدعم الأيقونات
    set -l supports_icons false

    # التحقق من أنواع الطرفيات التي تدعم الأيقونات
    if test -n "$TERM_PROGRAM"
        switch $TERM_PROGRAM
            case 'iTerm.app' 'WezTerm' 'vscode' 'Hyper'
                set supports_icons true
        end
    end

    # التحقق من متغيرات TERM الأخرى
    if string match -q -r 'xterm-256color|alacritty|kitty' $TERM
        set supports_icons true
    end

    # بناء وسائط eza
    set -l eza_args

    # إضافة الأيقونات إذا كان مدعوم
    if test $supports_icons = true
        set -a eza_args --icons=always
    end

    # إعدادات افتراضية
    set -a eza_args \
        --color=always \
        --group-directories-first \
        --header \
        --git \
        --time-style=long-iso \
        --level=2

    # التعامل مع الوسائط الخاصة
    for arg in $argv
        switch $arg
            case '-l' '--long'
                set -a eza_args --long
            case '-a' '--all'
                set -a eza_args --all
            case '-la' '-al'
                set -a eza_args --all --long
            case '-lh' '-hl'
                set -a eza_args --long --header
            case '-lt'
                set -a eza_args --long --sort=modified
            case '-ltr'
                set -a eza_args --long --sort=modified --reverse
            case '*'
                set -a eza_args $arg
        end
    end

    # تنفيذ eza
    eza $eza_args
end
