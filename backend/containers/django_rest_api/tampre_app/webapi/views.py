from webapi.models import UserInfo, FriendInfo
from webapi.serializers import UserInfoSerializer, FriendInfoSerializer
from rest_framework import generics

class UserInfoCreate(generics.ListCreateAPIView):
    queryset = UserInfo.objects.all()
    serializer_class = UserInfoSerializer

class FriendInfoCreate(generics.ListCreateAPIView):
    queryset = FriendInfo.objects.all()
    serializer_class = FriendInfoSerializer
