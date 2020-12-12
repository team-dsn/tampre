from rest_framework import serializers
from webapi.models import UserInfo, FriendInfo

class BirthdaySerializer(serializers.Serializer):
    year = serializers.CharField(max_length=4, source='birthday_year')
    month = serializers.CharField(max_length=2, source='birthday_month')
    day = serializers.CharField(max_length=2, source='birthday_day')

class UserInfoSerializer(serializers.ModelSerializer):
    birthday = BirthdaySerializer(source='*')

    class Meta:
        model = UserInfo
        fields = ('userId', 'userName', 'birthday', 'profileImageUrl', 'wishListUrl')

class UserInfoSerializerForFriend(serializers.ModelSerializer):
    class Meta:
        model = UserInfo
        fields = ('userId', 'userName', 'profileImageUrl')

class FriendInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = FriendInfo
        fields = ('userId', 'friendId', 'status')