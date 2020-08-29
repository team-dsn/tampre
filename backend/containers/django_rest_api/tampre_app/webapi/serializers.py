from rest_framework import serializers
from webapi.models import UserInfo, FriendInfo

class UserInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserInfo
        fields = ('userId', 'userName', 'birthday', 'profileImageUrl', 'wishListUrl', 'createdAt')

class FriendInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = FriendInfo
        fields = ('userId', 'friendId', 'status')