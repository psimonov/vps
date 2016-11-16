#!/bin/sh
mkdir -p ~/.vim/syntax/
cd ~/.vim/syntax/
wget http://www.vim.org/scripts/download_script.php?src_id=19394
mv download_script.php\?src_id\=19394 nginx.vim
cat > ~/.vim/filetype.vim <<EOF
au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif
EOF
