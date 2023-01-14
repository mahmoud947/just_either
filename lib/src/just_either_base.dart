abstract class Either<L, R> {
  T fold<T>(T Function(L) onLeft, T Function(R) onRight);
}

class Left<L, R> extends Either<L, R> {
  Left(this._value);
  final L _value;

  @override
  T fold<T>(T Function(L p1) onLeft, T Function(R p1) onRight) {
    return onLeft(_value);
  }

  @override
  bool operator ==(covariant Left<L, R> other) {
    if (identical(this, other)) return true;

    return other._value == _value;
  }

  @override
  int get hashCode => _value.hashCode;
}

class Right<L, R> extends Either<L, R> {
  Right(this._value);
  final R _value;

  @override
  T fold<T>(T Function(L p1) onLeft, T Function(R p1) onRight) {
    return onRight(_value);
  }

  @override
  bool operator ==(covariant Right<L, R> other) {
    if (identical(this, other)) return true;

    return other._value == _value;
  }

  @override
  int get hashCode => _value.hashCode;
}
