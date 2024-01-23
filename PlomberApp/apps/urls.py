from django.urls import path
from django.contrib.auth.views import LoginView, LogoutView
from .views import *

urlpatterns = [
    path("", home, name="index"),
    path("home/", home, name="home"),
    
    
    path('pricing/', pricing, name="pricing"),
    path('comments/', comments, name="comments"),
    path('admin/', admin, name="admin"),
    path('login/', custom_login, name='custom_login'),
    path('logout/', LogoutView.as_view(next_page='/home/'), name='logout'),
]