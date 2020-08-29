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
        # updateする
        serializer = UserInfoSerializer(user, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        # レスポンスオブジェクトを作成して返す
        return Response(serializer.data, status.HTTP_200_OK)
        
    def delete(self, request, user_id, *args, **kwargs):
        """ ユーザモデル削除APIに対応するハンドラメソッド """
        # モデルオブジェクトを取得
        get_object_or_404(UserInfo, user_id=user_id).delete()
        return Response(status.HTTP_204_NO_CONTENT)

class FriendListAPIView(views.APIView):
    """ 友達情報を取得する """
    def get(self, request, user_id, *args, **kwargs):
        """ 友達情報取得APIに対応するハンドラメソッド """
        # モデルオブジェクトを取得
        friends = FriendInfo.objects.filter(user_id=user_id, status=1)
        # シリアライザオブジェクトを作成
        serializer = FriendInfoSerializer(instance=friends, many=True)
        # 友達情報をUserInfoDBから取得
        friend_list = []
        for friend in serializer.data:
            friend_list.append(UserInfo.objects.get(user_id=friend['friend_id']))
        # シリアライザオブジェクトを作成  
        serializer2 = UserInfoSerializer(instance=friend_list, many=True)
        # レスポンスオブジェクトを作成して返す
        return Response(serializer2.data, status.HTTP_200_OK)

class FriendDeleteAPIView(views.APIView):
    """ 友達を削除する """
    def delete(self, request, user_id, friend_id, *args, **kwargs):
        # モデルオブジェクトを取得
        friend = get_object_or_404(FriendInfo, user_id=user_id, friend_id=friend_id)   
        # updateする
        data = {'status': 2}
        serializer = FriendInfoSerializer(instance=friend, data=data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        # レスポンスオブジェクトを作成して返す
        return Response(serializer.data, status.HTTP_200_OK)

class FriendRequestAPIView(views.APIView):
    """ 友達申請を送る """
    def post(self, request, user_id, friend_id, *args, **kwargs):
        # バリデーション：UserとFriendが存在するかの確認
        user = get_object_or_404(UserInfo, user_id=user_id)
        friend = get_object_or_404(UserInfo, user_id=friend_id)
        # バリデーション：userとfriendが同じじゃないかの確認
        if user == friend:
            return Response('same id', status.HTTP_400_BAD_REQUEST)
        # バリデーション：すでにユーザが申請を出している場合
        if FriendInfo.objects.filter(user_id=user_id, friend_id=friend_id, status=0):
            return Response('already requested', status.HTTP_400_BAD_REQUEST)
        # バリデーション：すでにユーザと友達の場合
        if FriendInfo.objects.filter(user_id=user_id, friend_id=friend_id, status=1):
            return Response('already friend', status.HTTP_400_BAD_REQUEST)
        # バリデーション：ユーザを一度ブロックしている場合 TODO:テストする
        if FriendInfo.objects.filter(user_id=user_id, friend_id=friend_id, status=2):
            friend_info = FriendInfo.objects.filter(user_id=user_id, friend_id=friend_id, status=2)
            serializer = FriendInfoSerializer(friend_info[0], data={"user_id":user_id, "friend_id":friend_id, "status":0})
            serializer.is_valid(raise_exception=True)
            serializer.save()
        # シリアライズオブジェクトを作成
        serializer = FriendInfoSerializer(data={"user_id":user_id, "friend_id":friend_id, "status":0})
        # バリデーションを実行
        serializer.is_valid(raise_exception=True)
        # モデルオブジェクトを登録
        serializer.save()
        # レスポンスオブジェクトを作成して返す
        return Response(serializer.data, status.HTTP_201_CREATED)

class FriendRequestedAPIView(views.APIView):
    """ 自分に来ている友達申請を確認する """
    def get(self, request, user_id, *args, **kwargs):
        # モデルオブジェクトを取得
        friends = FriendInfo.objects.filter(friend_id=user_id, status=0)
        # シリアライザオブジェクトを作成
        serializer = FriendInfoSerializer(instance=friends, many=True)
        # 友達情報をUserInfoDBから取得
        friend_list = []
        for friend in serializer.data:
            friend_list.append(UserInfo.objects.get(user_id=friend['user_id']))
        # シリアライザオブジェクトを作成  
        serializer2 = UserInfoSerializer(instance=friend_list, many=True)
        # レスポンスオブジェクトを作成して返す
        return Response(serializer2.data, status.HTTP_200_OK)

    """ 自分に来ている友達申請を承諾する """
    def post(self, request, user_id, friend_id, *args, **kwargs):
        # バリデーション：UserとFriendが存在するかの確認
        user = get_object_or_404(UserInfo, user_id=user_id)
        friend = get_object_or_404(UserInfo, user_id=friend_id)

        if request.data['accept'] == 'true':
            # すでにあればupdate、なければcreate
            user_to_friend = FriendInfo.objects.filter(user_id=user_id, friend_id=friend_id)
            if not user_to_friend:
                serializer = FriendInfoSerializer(data={"user_id":user_id, "friend_id":friend_id, "status":1})
                serializer.is_valid(raise_exception=True)
                serializer.save()
            else:
                serializer = FriendInfoSerializer(user_to_friend[0], data={"status":1}, partial=True)
                serializer.is_valid(raise_exception=True)
                serializer.save()
            # すでにあればupdate、なければcreate
            friend_to_user = FriendInfo.objects.filter(user_id=friend_id, friend_id=user_id)
            if not friend_to_user:
                serializer = FriendInfoSerializer(data={"user_id":friend_id, "friend_id":user_id, "status":1})
                serializer.is_valid(raise_exception=True)
                serializer.save()
            else:
                serializer = FriendInfoSerializer(friend_to_user[0], data={"status":1}, partial=True)
                serializer.is_valid(raise_exception=True)
                serializer.save()
            # レスポンスオブジェクトを作成して返す
            return Response(serializer.data, status.HTTP_200_OK)
        else:
            # すでにあればupdate、なければcreate
            user_to_friend = FriendInfo.objects.filter(user_id=user_id, friend_id=friend_id)
            if not user_to_friend:
                serializer = FriendInfoSerializer(data={"user_id":user_id, "friend_id":friend_id, "status":2})
                serializer.is_valid(raise_exception=True)
                serializer.save()
            else:
                serializer = FriendInfoSerializer(user_to_friend[0], data={"status":2}, partial=True)
                serializer.is_valid(raise_exception=True)
                serializer.save()
            # すでにあればupdate、なければcreate
            friend_to_user = FriendInfo.objects.filter(user_id=friend_id, friend_id=user_id)
            if not friend_to_user:
                serializer = FriendInfoSerializer(data={"user_id":friend_id, "friend_id":user_id, "status":2})
                serializer.is_valid(raise_exception=True)
                serializer.save()
            else:
                serializer = FriendInfoSerializer(friend_to_user[0], data={"status":2}, partial=True)
                serializer.is_valid(raise_exception=True)
                serializer.save()
            # レスポンスオブジェクトを作成して返す
            return Response(serializer.data, status.HTTP_200_OK)
