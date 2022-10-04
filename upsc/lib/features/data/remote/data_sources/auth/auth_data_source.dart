
abstract class AuthDataSource{
  Future<void> updateStream(String stream,String token);
  Future<void> updateLanguage(String language,String token);
}