abstract class Either<L, R> {
  T fold<T>(T Function(L) onLeft, T Function(R) onRight);
}
