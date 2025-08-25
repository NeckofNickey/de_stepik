object StringProcessor {
  def processStrings(strings: List[String]): List[String] = {
    // Функциональный подход: фильтрация + преобразование
    strings
      .filter(_.length > 3)        // Оставляем только строки длиннее 3 символов
      .map(_.toUpperCase)           // Преобразуем каждую строку в верхний регистр
  }

  def main(args: Array[String]): Unit = {
    val strings = List("apple", "cat", "banana", "dog", "elephant")
    val processedStrings = processStrings(strings)
    println(s"Processed strings: $processedStrings")
  }
}