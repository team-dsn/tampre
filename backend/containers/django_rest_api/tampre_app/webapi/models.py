from django.db import models

class UserInfo(models.Model):
    """ ユーザ情報モデル """

    user_id = models.CharField(max_length=64, unique=True)
    user_name = models.CharField(max_length=64)
    birthday = models.CharField(max_length=8)
    profile_image_url = models.CharField(max_length=256)
    wish_list_url = models.CharField(max_length=256)
    created_at = models.DateTimeField(auto_now_add=True)

class FriendInfo(models.Model):
    """ 友達情報モデル """
    user_id = models.CharField(max_length=64)
    friend_id = models.CharField(max_length=64)
    status = models.IntegerField()
