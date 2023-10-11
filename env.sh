#!/bin/bash -xe


echo '+ Update `apt-get`'
sudo apt-get update

echo '+ Install packages needed'
sudo apt install -y libssl-dev libreadline-dev zlib1g-dev libyaml-dev
sudo apt install -y gcc g++ make

echo '+ Install `rbenv`'
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo '+ Pass the path'
echo "# For rbenv" >> ~/.bash_profile
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(~/.rbenv/bin/rbenv init -)"' >> ~/.bash_profile
source ~/.bashrc

if command -v which rbenv &> /dev/null; then
    echo '-> Installing has been success!'
else
    echo '-> Installing faild!'
    exit 1
fi

echo '+ bundle install'
bundle install --path vendor/bundle
if command -v bundle exec rails s &> /dev/null; then
    echo '-> Bootign web server has been success!'
else
    echo '-> Booting web server failed!'
fi