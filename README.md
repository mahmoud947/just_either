
# just_either

just_either is a simple library created by function programming lover typed for easy and safe error handling with functional programming style in Dart.

# Installation

add package to your project

```yaml
dependencies:
  just_either:
   git: https://github.com/mahmoud947/just_either
   ```

## Usage

### example

```dart
void main(List<String> args) async {
  final data = await getData();
  data.fold(
    (failure) => print(failure.message),
    (data) => print(data),
  );
  print('done');
}


// return String on success http request
// return failure on exception
Future<Either<Failure, String>> getData() async {
  final clint = HttpClient();
  try {
    final data = await clint
        .getUrl(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'))
        .then((req) => req.close())
        .then((res) => res.transform(utf8.decoder).join());
    return Right(data);
  } on Exception {
    return Left(NetworkFailure(message: 'network failure'));
  } finally {
    clint.close();
  }


  abstract class Failure {
  Failure({required this.message});
  final String message;

  @override
  bool operator ==(covariant Failure other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message});
}
}```
