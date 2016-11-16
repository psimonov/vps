#!/bin/bash

# Создаем новый бранч
git checkout --orphan latest_branch && \

# Добавляем все файлы
git add -A && \

# Коммитим
git commit -am ... && \

# Удаляем master
git branch -D master && \

# Переименовываем новый бранч в master
git branch -m master && \

# Форсированно пушим
git push -f origin master
