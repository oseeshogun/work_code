mixin AiFunctionsRepository {
  Future<Map<String, dynamic>> getCodeStructure();

  Future<List<Map<String, dynamic>>> searchArticles({
    required List<String> keywords,
    int? titleNumber,
    int? chapterNumber,
    int? sectionNumber,
    int limit = 5,
  });

  Future<Map<String, dynamic>?> getArticleByNumber(int number);
}
