#!/bin/bash
#Объявляем переменные в которые будут передваться аргументы команды
output_file=$1
target_dir=$2
extension=$3

# Проверка на то чтобы консоли передались ровно 3 аргумента
if [ $# -ne 3 ]; then
	echo "Ошибка! Нужно указать 3 аргумента: output_file target_dir extension"
	exit 1
fi

# find target_dir выведет всё внутри каталога и глубже
#-maxdepth 1 ограничивает поиск 1 директорией, чтобы не находить файлы в подкаталогах
#-name *.extension фильтр по имени, при помощи "*. " можно искать по расширению
find "${target_dir}" -maxdepth 1 -name "*.${extension}" | tee "${output_file}"
