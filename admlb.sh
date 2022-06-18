MAINDIR=/usr/src/app

mkdir $MAINDIR && chmod 777 $MAINDIR && cd $MAINDIR

run_python_code() {
    python3${pVer%.*} -c "$1"
}

load_configenv() {
    $(run_python_code "from dotenv import load_dotenv
load_dotenv('config.env', override=True)")
}

if [[ ${UPSTREAM_REPO} && ${UPSTREAM_BRANCH} ]];
then
    echo "Detected UPSTREAM_REPO and UPSTREAM_BRANCH"
else
    UPSTREAM_REPO="https://github.com/ahad0xff/admlb"
    UPSTREAM_BRANCH="main"
    echo "UPSTREAM_REPO or UPSTREAM_BRANCH missing, using default ones"
fi

git init -q
git config --global user.email ahadmirrorlab1@gmail.com
git config --global user.name ahadz-git
git add .
git commit -sm update -q
git remote add origin $UPSTREAM_REPO
git fetch origin -q
git reset --hard origin/$UPSTREAM_BRANCH -q

python3 -m bot
