# Setup instruction


## Install npm

install Homebrew (if you don't have)
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

install nodebrew

```
brew install nodebrew
```

following instructions after install
(change .zshrc to .bashrc if you are using bash)
```
/usr/local/opt/nodebrew/bin/nodebrew setup_dirs
export PATH=$HOME/.nodebrew/current/bin:$PATH
echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >> ~/.zshrc
```

install latest binary
```
nodebrew install-binary latest
```

show installed version
```
% nodebrew list
v9.8.0

current: none
```

set current version
```
% nodebrew use  v9.8.0
use v9.8.0
```

confirm installation

```
% which node
/Users/hoge/.nodebrew/current/bin/node
% node --version
v9.8.0
```

Install gulp
```
% npm install --global gulp
...
# Rebuild node-sass
% npm rebuild node-sass
...
````
## Install middleman

See: https://middlemanapp.com/jp/basics/install/

```
gem install middleman
```


## setup
```
% git clone git@hub.georepublic.net:vision-net/website.git
...
% cd website
% bin/setup
...
% npm install
...
```

## setup
```

```
