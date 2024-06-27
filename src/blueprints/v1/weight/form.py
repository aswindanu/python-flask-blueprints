from wtforms import Form, BooleanField, StringField, PasswordField, validators

class WeightForm(Form):
    date = StringField('Date', [
        validators.DataRequired(),
    ])
    weight = PasswordField('Weight', [
        validators.DataRequired()
    ])