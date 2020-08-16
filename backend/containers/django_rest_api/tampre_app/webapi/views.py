from webapi.models import UserInfo, FriendInfo
from webapi.serializers import UserInfoSerializer, FriendInfoSerializer
from rest_framework import generics, status, views
from rest_framework.response import Response
from django.shortcuts import get_object_or_404

class UserInfoCreate(generics.ListCreateAPIView):
    queryset = UserInfo.objects.all()
    serializer_class = UserInfoSerializer

class FriendInfoCreate(generics.ListCreateAPIView):
    queryset = FriendInfo.objects.all()
    serializer_class = FriendInfoSerializer

class UserInfoAPIView(views.APIView):
    """ ユーザモデルの登録、修正、削除 """

    def get(self, request, user_id, *args, **kwargs):
        """ ユーザモデル取得APIに対応するハンドラメソッド """

        # モデルオブジェクトを取得
        user = get_object_or_404(UserInfo, user_id=user_id)
        # シリアライザオブジェクトを作成
        serializer = UserInfoSerializer(instance=user)
        # レスポンスオブジェクトを作成して返す
        return Response(serializer.data, status.HTTP_200_OK)
        
    def post(self, request, *args, **kwargs):
        """ ユーザモデル登録APIに対応するハンドラメソッド """
        # シリアライズオブジェクトを作成
        serializer = UserInfoSerializer(data=request.data)
        # バリデーションを実行
        serializer.is_valid(raise_exception=True)
        # モデルオブジェクトを登録
        serializer.save()
        # レスポンスオブジェクトを作成して返す
        return Response(serializer.data, status.HTTP_201_CREATED)

    def put(self, request, user_id, *args, **kwargs):
        """ ユーザモデル修正APIに対応するハンドラメソッド """
        # モデルオブジェクトを取得
        user = get_object_or_404(UserInfo, user_id=user_id)
        # 各値をupdateする
        user.user_name = request.data['user_name']
        user.birthday = request.data['birthday']
        user.profile_image_url = request.data['profile_image_url']
        user.wish_list_url = request.data['wish_list_url']
        # DBにsaveする
        user.save()
        # レスポンスオブジェクトを作成して返す
        return Response(UserInfoSerializer(instance=user).data, status.HTTP_200_OK)

    def delete(self, request, user_id, *args, **kwargs):
        """ ユーザモデル削除APIに対応するハンドラメソッド """
        # モデルオブジェクトを取得
        user = get_object_or_404(UserInfo, user_id=user_id).delete()
        return Response(status.HTTP_200_OK)