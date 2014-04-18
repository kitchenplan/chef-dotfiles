node.default["git"]["name"] = "Your name"
node.default["git"]["email"] = "you@example.com"

# set of helpful aliases
node.default["git"]["aliases"] = {}.tap do |aliases|
    aliases['l'] = "log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
    aliases['d'] = "diff --patch-with-stat"
    aliases['c'] = "clone --recursive"
    aliases['ca'] = "!git add -A && git commit -av"
    aliases['go'] = "checkout -B"
    aliases['tags'] = "tag -l"
    aliases['remotes'] = "remote -v"
    aliases['undopush'] = "push -f origin HEAD^:master"
    aliases['pom'] = "push origin master"
    aliases['s'] = "status -sb"
    aliases['branches'] = "branch -a"
end
