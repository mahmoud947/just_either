import 'package:just_either/just_either.dart';

import 'dart:convert';
import 'dart:io';

void main(List<String> args) async {
  final data = await getData();
  data.fold((failure) => print(failure.message), (data) => print(data));
  print('done');
}

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
