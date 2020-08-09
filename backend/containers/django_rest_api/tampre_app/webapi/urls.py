from django.urls import path
from . import views
from django.http import HttpResponse
urlpatterns = [
    path('api/user_info/', views.UserInfoCreate.as_view() ),
    path('api/friend_info/', views.FriendInfoCreate.as_view() ),
    path('api/healthcheck', lambda r: HttpResponse()),
]