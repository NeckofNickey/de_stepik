#!/bin/bash

# Пути к файлам
base_dir="/home/nick/learning/data_engineer/de_stepik/files"
log_file="$base_dir/access.log"
report_file="$base_dir/report.txt"

# Очищаем старый отчет
: > "$report_file"

# Печатаем заголовок
header="Отчет о логе веб-сервера"
echo "$header" >> "$report_file"

# Печатаем разделитель строк равный заданной длине
repeat_char(){
    printf -v result '%*s' "$2"
    echo "${result// /$1}"
}

header_length=${#header}
delimiter_char="="

delimiter=$(repeat_char "$delimiter_char" "$header_length")
echo "$delimiter" >> "$report_file"

# Проверяем наличие файла
if [ ! -f "$log_file" ]; then
    echo "Файл access.log не найден!" >> "$report_file"
    exit 1
fi

# Составляем отчет
{
    # 1. Подсчитать общее количество запросов.
    echo "Общее количество запросов: $(awk '/HTTP\/[0-9.]+"/ {count++} END{print count}' "$log_file")"

    # 2. Подсчитать количество уникальных IP-адресов. Строго с использованием awk.
    echo "Количество уникальных IP-адресов: $(awk '/HTTP\/[0-9.]+"/ {ip[$1]++} END{print length(ip)}' "$log_file")"
    echo
    
    # 3. Подсчитать количество запросов по методам (GET, POST и т.д.). Строго с использованием awk.
    echo "Количество запросов по методам:"
    awk -F '[ "]+' \
        '/HTTP\/[0-9.]+"/ {
            method[$6]++
        } 
        END {
            for(m in method) 
                print "    " method[m], m
        }
    ' "$log_file"
    echo

    # 4. Найти самый популярный URL. Строго с использованием awk.
    awk '{
        if (match($0, /"[^"]+"/, req)) {
            if (req[0] ~ /HTTP/) {
                split(req[0], parts, " ");
                url = parts[2];
                count[url]++;
                }
            }
        }
    END {
        max = 0
        for (u in count)
            if (count[u] > max) {
                max = count[u];
                popular = u;
            }
        print "Самый популярный URL:", max, popular;   

        }
    ' "$log_file"

} >> "$report_file"