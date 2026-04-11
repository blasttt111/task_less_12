#!/bin/bash

SEARCH_STR=$1
TARGET_DIR=$2

if [ -z "$TARGET_DIR" ]; then
	echo "Использование: $0 <строка> <каталог>"
	exit 1
fi

# -type f : ищем только в файлах
# -exec - для найденных файлов запускает команду 
#grep -l : выводит только имя файла
# {} + : передает найденные файлы в команду
# 2>error.log : перенаправляет сообщения об ошибках доступа в файл

find "$TARGET_DIR" -type f -exec grep -l "$SEARCH_STR" {} + 2>temp_errors.log | while read -r file; do
# Для каждого найденного файла выводим путь и размер
	size=$(stat -c %s "$file")
	echo "Найден: $file | Размер: $size байт"
done

# Выводим ошибки доступа, если они были
if [ -s temp_errors.log ]; then
	echo -e "\n--- Сообщения об ошибках доступа: ---"
	grep "Permission denied" temp_errors.log
fi

