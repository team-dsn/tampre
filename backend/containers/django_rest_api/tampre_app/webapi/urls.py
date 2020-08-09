from django.urls import path
from . import views
urlpatterns = [
    path('api/user_info/', views.UserInfoCreate.as_view() ),
    path('api/friend_info/', views.FriendInfoCreate.as_view() ),
]