import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';

import 'models/auth_box.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheItems(List<Object> items);
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this._box);

  final Box<AuthBox> _box;
  Box<AuthBox> get box => _box;

  static AuthLocalDataSource init(Store store) {
    return AuthLocalDataSourceImpl(Box<AuthBox>(store));
  }

  @override
  Future<void> cacheItems(List<Object> items) async {
    // TODO: Convert auth items to AuthBox and cache them.
  }
}
