#!/bin/bash

HOST='{host}'
USER='{user}'
PROJ=${PWD##*/}

### REMOTE ###

ssh ${USER}@${HOST} -t "\
mkdir -p /var/www/${PROJ}/ && \
cd /var/www/${PROJ}/ && \

git init && \
git config receive.denyCurrentBranch ignore && \

cat <<EOF > .git/hooks/post-receive
#!/bin/sh
cd ..
GIT_DIR='.git'
git reset --hard
EOF

chmod +x .git/hooks/post-receive \
"

### LOCAL ###

git init && \
git remote add --track master production ssh://${USER}@${HOST}/var/www/${PROJ}/

if [[ $1 == 'php' ]]; then
    DOCUMENT_ROOT='web'
elif [[ $1 == 'js' ]]; then
    DOCUMENT_ROOT='dest'
fi

if [[ ${DOCUMENT_ROOT} ]]; then

mkdir ${DOCUMENT_ROOT} && \
cd ${DOCUMENT_ROOT} && \

cat <<EOF > ./robots.txt
User-agent: *
Disallow: /
EOF

git add * && \
git commit -m ... && \
git push --set-upstream production master

fi
