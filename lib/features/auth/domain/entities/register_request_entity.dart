

class RegisterRequestEntity {
  String name;
  String phone;
  String email;
  String password;
  String confirmPassword;

  RegisterRequestEntity(
      { this.name='name',  this.phone='phone',  this.email='email',  this.password='password', this.confirmPassword='confirmPassword'});

  
}  