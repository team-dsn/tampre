from django.db import models

class UserInfo(models.Model):
    """ ユーザ情報モデル """
    userId = models.CharField(max_length=64, unique=True)
    userName = models.CharField(max_length=64)
    birthday_year = models.CharField(max_length=4)
    birthday_month = models.CharField(max_length=2)
    birthday_day = models.CharField(max_length=2)
    profileImageUrl = models.CharField(max_length=256)
    wishListUrl = models.CharField(max_length=256)
    createdAt = models.DateTimeField(auto_now_add=True)

class FriendInfo(models.Model):
    """ 友達情報モデル """
    userId = models.CharField(max_length=64)
    friendId = models.CharField(max_length=64)
    status = models.IntegerField()
