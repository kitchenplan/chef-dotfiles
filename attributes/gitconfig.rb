node.default["git"]["name"] = "Your name"
node.default["git"]["email"] = "you@example.com"

# set of helpful aliases
node.default["git"]["aliases"] = {}.tap do |aliases|
    aliases['l'] = 'log --pretty=oneline -n 20 --graph'
    aliases['s'] = 'status -s'
    aliases['d'] = 'diff --patch-with-stat'
    aliases['p'] = '!"git pull; git submodule foreach git pull origin master"'
    aliases['c'] = 'clone --recursive'
    aliases['ca'] = '!git add -A && git commit -av'
    aliases['go'] = 'checkout -B'
    aliases['tags'] = 'tag -l'
    aliases['remotes'] = 'remote -v'
    aliases['credit'] = '"!f() { git commit --amend --author \"$1 <$2>\" -C HEAD; }; f"'
    aliases['undopush'] = 'push -f origin HEAD^:master'
    aliases['pom'] = 'push origin master'
end
