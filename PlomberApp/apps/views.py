from django.http import HttpResponse, HttpResponseForbidden
from django.contrib.auth.views import LoginView
from django.contrib.auth.decorators import login_required
from django.contrib.auth import logout
from django.contrib import messages
from django.contrib.auth import authenticate, login
from django.shortcuts import render, redirect
from .forms import LoginForm

def home(request):
    return render(request, "index.html")


def pricing(request):
    return render(request, "pricing.html")


def comments(request):
    return render(request, "comments.html")

@login_required(login_url="custom_login")
def admin(request):
    show_flag = "HereIsGaryyyy"
    return render(request, "admin.html", {"show_flag": show_flag})


def custom_login(request):
    if request.method == 'POST':
        form = LoginForm(request.POST)

        if form.is_valid():
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']

            # Perform custom authentication
            user = authenticate(request, username=username, password=password)

            if user is not None:
                print("success")
                # Authentication successful, log the user in
                login(request, user)
                return redirect('admin')  # Redirect to your admin page or any other page
    else:
        form = LoginForm()

    return render(request, 'login.html', {'form': form})