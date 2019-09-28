#! /bin/bash
usage="$(basename "$0") [-h] [-i] [-r] [-c] [-v] -- configure host server for GOal OwN project

where:
    -h  show this help text
    -i  try to install all components (works only with -r)
    -r  really try to install all components (works only with -i)
    -c  configure all components
    -v  verbose mode
"

# ------------------------- USEFUL FUNCTIONS -----------------------------------
die(){
  printf "$*\n" 1>&2 ;
  printf "\n$usage\n"
  exit 1;
}

pretty_print(){
  printf "\n------------------- $* -------------------------------\n\n"
}

verbose_print(){
  if [ $VERBOSE ];then printf "$*";fi
}


install_if_not_installed(){
  sudo apt update
  for package in $*;do
    pckg_info=$(dpkg -s $package 2>/dev/null)
    dpkg_okay=$?
    status=$(printf "$pckg_info" | \
                    grep 'Status' | \
                    sed 's/.* deinstall.*/deinstall/')
    if [[ $status == 'deinstall' ]];then status='1'
    else status='0';fi
    # printf "dpkg_okay = $dpkg_okay status = $status\n"

    if [[ ($dpkg_okay != '0') || ($status != '0') ]];then
      printf "$package not installed, installation... "
      sudo apt install $package
      if [[ $? != '0' ]];then
        printf "failed\n"
        die "problem with installation of package = $package"
      else
        printf "done\n"
      fi
    else
      printf "$package already installed\n"
    fi
  done

}


#set -xe

# -------------------------- parsing arguments ---------------------------------
INSTALL=""
REALLY=""
CONFIG=""
VERBOSE=""
HELP=""
LOCAL_SERVER_PATH=""

if [[ $# == 0 ]];then die "Illegal amount of arguments == $#";fi

while getopts "ircvhp:" opt; do
    case "$opt" in
    i)  INSTALL="yes"
        ;;
    r)  REALLY="yes"
        ;;
    c)  CONFIG="yes"
        ;;
    v)  VERBOSE="yes"
        ;;
    h)  HELP="yes"
        ;;
    p)  LOCAL_SERVER_PATH=$OPTARG
        ;;
    \?) die "illegal option: $OPTARG" >&2
       ;;
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift

if [[ $LOCAL_SERVER_PATH = ""  ]];then die "option -l (LOCAL_SERVER_PATH) wasn't passed , exiting...\n";else printf "LOCAL_SERVER_PATH = $LOCAL_SERVER_PATH\n";fi
# if [[ $PORT = ""  ]];then die "option -p (PORT) wasn't passed , exiting...\n";else printf "PORT = $PORT\n";fi
# if [[ $REPOS = ""  ]];then die "option -r (REPOS) wasn't passed , exiting...\n";else printf "REPOS = $REPOS\n";fi

if [[ $HELP ]];then
  printf "$usage"
  exit 0
fi

#---------------------------- Components installtion ---------------------------
pretty_print "Components installtion"
if [[ $INSTALL && $REALLY ]];then

  #-------------------------- sbt preconfig ------------------------------------
  if [[ ! -f '/etc/apt/sources.list.d/sbt.list' ]];then
    echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
  fi
  curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
  #------------------------- postgresql preconfig ------------------------------
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
  wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
  # ------------------------- install packages ---------------------------------
  install_if_not_installed "postgresql postgresql-contrib\
                            openjdk-11-jdk openjdk-11-jre\
                            sbt"
else
  printf "Components installation isn't requested\n"
fi
#---------------------------- server configuration -----------------------------------
if [[ $CONFIG ]];then
  pretty_print "server cloning"
  cd $LOCAL_SERVER_PATH
  rm  -rf banjo
  git clone 'https://github.com/goal-own/banjo'
  cd 'banjo'

  pretty_print "SBT building"
  sbt run
  printf "all done\n\n"
else
  printf "Configuration isn't requested\n"
fi
