
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential

echo "Installing RVM"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --ruby

source /usr/local/rvm/scripts/rvm

rvm requirements
rvmsudo /usr/bin/apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion -y

echo "Installing Ruby"
rvm install 2.2.1
rvm use 2.2.1 --default
rvm rubygems current

echo "Installing Rails"
gem install rails -v 4.2.6 --no-ri --no-rdoc

echo "Installing Bundler"
gem install bundler

echo "Installing RSpec"
gem install rspec

gem install nyan-cat-formatter
echo '--format NyanCatFormatter' >> .rspec

install Trash trash-cli

install Git git
install SQLite sqlite3 libsqlite3-dev
install PostgreSQL postgresql postgresql-contrib libpq-dev

sudo -u postgres createuser --superuser vagrant

install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev
install 'Blade dependencies' libncurses5-dev
install 'ExecJS runtime' nodejs

# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

echo 'Installation Complete!'
