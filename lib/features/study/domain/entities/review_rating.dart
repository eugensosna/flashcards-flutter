/// Self-assessment offered at the end of a card review.
///
/// [quality] is the SM-2 quality grade (0-5). Only four buckets are exposed to
/// keep the UI focused.
enum ReviewRating {
  again('Again', 0),
  hard('Hard', 3),
  good('Good', 4),
  easy('Easy', 5);

  const ReviewRating(this.label, this.quality);

  final String label;
  final int quality;

  /// Ratings that count as a successful recall in SM-2.
  bool get isSuccessful => quality >= 3;
}
