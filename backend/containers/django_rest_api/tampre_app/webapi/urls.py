from django.urls import path
from . import views
from django.http import HttpResponse
urlpatterns = [
    path('api/user_info/', views.UserInfoCreate.as_view() ),
    path('api/friend_info/', views.FriendInfoCreate.as_view() ),
    path('api/healthcheck', lambda r: HttpResponse() ),
    path('api/user/<str:user_id>', views.UserInfoAPIView.as_view() ),
    path('api/user', views.UserInfoAPIView.as_view() ),
    path('api/friends/<str:user_id>', views.FriendListAPIView.as_view() ),
    path('api/friends/<str:user_id>/<str:friend_id>', views.FriendDeleteAPIView.as_view() ),
    path('api/friends/request/<str:user_id>/<str:friend_id>', views.FriendRequestAPIView.as_view() ),
    path('api/friends/requested/<str:user_id>', views.FriendRequestedAPIView.as_view() ),
]