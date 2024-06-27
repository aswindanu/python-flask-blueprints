from wtforms import Form, BooleanField, StringField, PasswordField, SubmitField, validators

class AuthForm(Form):
    email_or_username = StringField('Username / Email:', [
        validators.DataRequired(),
        validators.Length(min=4, max=25)
    ])
    password = PasswordField('Password:', [
        validators.DataRequired()
    ])
    submit = SubmitField('Submit')