# https://stepik.org/lesson/1390616/step/2?unit=1407267

# Стандартные библиотеки Python
import argparse
import csv
import logging
import os
import sys
from datetime import datetime, timedelta
from math import floor

# Сторонние библиотеки
import numpy as np
from cryptography.fernet import Fernet

# PySpark импорты
import pyspark
from pyspark import StorageLevel
from pyspark.sql import SparkSession, DataFrame
from pyspark.sql.functions import broadcast, col, lit, rand

# Аннотации типов
from typing import List, Dict, Any

# Пользовательские библиотеки
from crypto.crypto import hash_keys
from schemas.translit_schema import translit_dict

# --- Логгер ---
logger = logging.getLogger(__name__)
handler = logging.StreamHandler(sys.stdout)
logger.setLevel(logging.INFO)
logger.addHandler(handler)

# --- Константы ---
OUTPUT_PATH = 'output/'
NAME_DATABASE_PATH = 'reference_data/names.txt'
CITIES_DATABASE_PATH = 'reference_data/cities.txt'
EMAIL_DOMAINS = ['@yandex.ru', '@gmail.com', '@yahoo.com', '@mail.ru']

