abstract class PadelException implements Exception{
  String errorMessage();
}
class UserNotFoundException extends PadelException{
  @override
  String errorMessage() => 'No user found for provided uid/username';

}
class UsernameMappingUndefinedException extends PadelException{
  @override
  String errorMessage() =>'User not found';

}
class ContactAlreadyExistsException extends PadelException{
  @override
  String errorMessage() => 'Contact already exists!';
}