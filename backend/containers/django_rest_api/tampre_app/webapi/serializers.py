from rest_framework import serializers
from webapi.models import UserInfo, FriendInfo

class UserInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserInfo
        fields = ('user_id', 'user_name', 'birthday', 'profile_image_url', 'wish_list_url', 'created_at')

class FriendInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = FriendInfo
        fields = ('user_id', 'friend_id', 'status')