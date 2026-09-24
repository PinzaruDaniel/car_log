import 'package:objectbox/objectbox.dart';

@Entity()
class AuthBox {
  AuthBox({
    this.id = 0,
    this.remoteId = '',
  });

  @Id()
  int id;

  String remoteId;
}
