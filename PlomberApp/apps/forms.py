from django import forms
from django.core.exceptions import ValidationError

def validate_username(value):
    # Add your custom validation logic for the username
    if not value.startswith('GaryThePlumber'):
        raise ValidationError('Username must start with "GaryThePlumber".')

def validate_password(value):
    # Add your custom validation logic for the password
    if value != 'ILovePinky':
        raise ValidationError('Incorrect.')

class LoginForm(forms.Form):
    username = forms.CharField(max_length=100, validators=[validate_username], widget=forms.TextInput(attrs={'class': 'form-control'}))
    password = forms.CharField(max_length=100, validators=[validate_password], widget=forms.PasswordInput(attrs={'class': 'form-control'}))
