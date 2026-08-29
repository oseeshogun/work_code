import 'package:fuzzy/fuzzy.dart';

bool matchesQuery(String haystack, String query, {double threshold = 0.4}) {
  final fuse = Fuzzy<String>([haystack]);
  return fuse.search(query).any((result) => result.score < threshold);
}
