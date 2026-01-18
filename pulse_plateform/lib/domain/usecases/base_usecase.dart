import 'abstract_usecase.dart';

abstract class BaseUseCase<Request, Response> extends AbstractUseCase {
  Future<Response?> execute(Request request);
}

/// Empty parameter class for use cases that don't require any input
class NoParams {
  const NoParams();
}
