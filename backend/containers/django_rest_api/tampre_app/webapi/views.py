from webapi.models import UserInfo, FriendInfo
from webapi.serializers import UserInfoSerializer, FriendInfoSerializer
from rest_framework import generics, status, views
from rest_framework.response import Response
from django.shortcuts import get_object_or_404
from google.cloud import storage
from google.oauth2 import service_account
import base64

# gcpの情報
SERVICE_ACCOUNT_INFO = {
  "type": "service_account",
  "project_id": "tampre",
  "private_key_id": "2fa59c6736e149fe23b7dc3b02cdb37c1dfca8b7",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCty53qAyHVR/Do\n0t9wxuXfma3oVwCXAhRZ8WSUiXhIoIzZsxUv340Dx1JDa/tKcXd1Z+7aoJ727Zcf\n4IIuUbBj3YdxpmPKtKScwNNtXD18vNOjEw3NLCcT41qa6q1oMl4/RlwA2d+JAxa1\nPMpAHWkxZ0VuKnwQuFFIZxW1MsOF+tam4ZRp/xnSaywNi6ab6hBmeAih2s2IEfEf\n99MOffvJAMLNoB05zYgaCs9rzvSEQVK4V0wCKbJii8U/2mCMzfbF7Wn4IpH4NhH1\nDxaP2r2v0aIZxs8n6GobwOWvKqGgzeCmQTigfciZ++f+4DhLeR9z/gP1sQ1EqRUf\n69kaVbaZAgMBAAECggEAAciLm8mhcL9WvQTg7xbTaAp7Kt2tr18Bl3SvLAkHF3Oy\nTk+UoZOhLk8+zFtQzlBAwg8pd8vbJbyFZvnWTCRhc3zj9WoYLw3QfJ1L7hzasqt7\nXnqFEzxnQEB+fwV2dxHBPtP5gLa7oPvLoVt41dSXbj7ZiwpbkI5boysPoXbeY8MN\nUcYtIIYf149RP+7liOzEN5BG62cSiut9HJhKlo70czEIP+nXc7DY9U94qeBwvLUd\nZyO+lvkB0iAHrAHUdcVQVWwr+gazCg7EaScMmPmydapYW0ZGlo8Z6mby2If//oCG\nZFPPpDZ5BuZx1nH6Asn0al9GcBFEpVhSTcdumThGkwKBgQDtkVBytbQe5sgpidwO\nBI9sCrYEpMTIbLTVsEg929NXIdp5NQoP3OVJhVXUbBpUCQKZgLtEFAhSLeLN7eBI\n089ytPwmjfM+4hJs1h9Qbd13Jol1PfOKO4q824JRdYMXZpGoXb/fsyWaZX2WbzeO\nKkSomMufSE/9qrLdc4AICzEViwKBgQC7R6BlYx1Z08jEwCgXCpUFTazlFgXcwkZy\nAbWalZ/KeUkkHu13jqkv3XEKeUovv0A0RE5Jg1DZBI/rUKTV1BuY6bs/Ju4DzzfV\nHZ6Yoiml8jsIpkp4kR+jKXS63uxucBe3Sub/dfYRIdn4JVUf2IKdLet4iC9+JImr\njIumLRLQ6wKBgC7YV6+26sSpJ1EhkRXmik14szmpL/CBlwsIDsa74SmuUEFUVx6X\npVLhCvKvOmXVvQB95O9gr99ckvuea3qQ4bgxvgLwPMXqmE2Dz3rxnxkOrU5EIBDi\n+tGQy1q6vFXR8OjtS5eV4NVYK/KNDbxn01AXiRdoj/VqQojubJGpe01PAoGBAJL4\nX/iQ8sy2tj0pa4zBgjcaQQ+627jmQXBgxQreVvsHeY2+M696pm1ow7hrfPvBg/pA\njIuGYSEeQm9x5xnjjhDPhGHIBEu7B97YksjHohWX5hognhrGEOTzuKaaIUN99i6i\numtKQGQrg6oIaihGuiHtkngRr+u3cs7Myh8MClMnAoGAVcjaA5mkV0CxEWx9IQbX\nVQ2jIJwEB5dnVLrqwt+N8Tk5KOmqCTje9d6f8+n9OrJ3pAtMwt7CZTvyt3FxZb06\n6jr9L4wfqpikRb4F+uTblUo03a90fQ0Y4S4J3uH/uNpHzWbrqU1rV1cJcC+J1Dvc\nggzlt8hzIg/NTmCFNWFawck=\n-----END PRIVATE KEY-----\n",
  "client_email": "tampre@tampre.iam.gserviceaccount.com",
  "client_id": "107211330647696608325",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/tampre%40tampre.iam.gserviceaccount.com"
}
BUCKET_NAME = "tampre_profile_images"

def upload_profile_image(image, fileName):
    """プロフィール画像をgcpのストレージにアップロードしURLを取得"""
    credentials = service_account.Credentials.from_service_account_info(SERVICE_ACCOUNT_INFO)
    client = storage.Client(
        credentials=credentials,
        project=credentials.project_id
    )
    bucket = client.get_bucket(BUCKET_NAME)
    blob = bucket.blob(fileName)
    blob.upload_from_file(image)
    url = blob.public_url
    if isinstance(url, six.binary_type):
        url = url.decode('utf-8')
    return url

class UserInfoAPIView(views.APIView):
    """ ユーザモデルの登録、修正、削除 """

    def get(self, request, user_id, *args, **kwargs):
        """ ユーザモデル取得APIに対応するハンドラメソッド """
        # モデルオブジェクトを取得
        user = get_object_or_404(UserInfo, userId=user_id)
        # シリアライザオブジェクトを作成
        serializer = UserInfoSerializer(instance=user)
        # レスポンスオブジェクトを作成して返す
        return Response(serializer.data, status.HTTP_200_OK)
        
    def post(self, request, *args, **kwargs):
        """ ユーザモデル登録APIに対応するハンドラメソッド """
        # 画像のBase64をdecode
        image = base64.b64decode(request.data['profileImageBase64'])
        # 画像をアップロード
        url = upload_profile_image(image, request.data['userId'])
        # 画像のurlを付与
        request.data['profileImageURL'] = url
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
        user = get_object_or_404(UserInfo, userId=user_id)
        # updateする
        serializer = UserInfoSerializer(user, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        # レスポンスオブジェクトを作成して返す
        return Response(serializer.data, status.HTTP_200_OK)
        
    def delete(self, request, user_id, *args, **kwargs):
        """ ユーザモデル削除APIに対応するハンドラメソッド """
        # モデルオブジェクトを取得
        get_object_or_404(UserInfo, userId=user_id).delete()
        return Response(status.HTTP_204_NO_CONTENT)

class FriendListAPIView(views.APIView):
    """ 友達情報を取得する """
    def get(self, request, user_id, *args, **kwargs):
        """ 友達情報取得APIに対応するハンドラメソッド """
        # モデルオブジェクトを取得
        friends = FriendInfo.objects.filter(userId=user_id, status=1)
        # シリアライザオブジェクトを作成
        serializer = FriendInfoSerializer(instance=friends, many=True)
        # 友達情報をUserInfoDBから取得
        friend_list = []
        for friend in serializer.data:
            friend_list.append(UserInfo.objects.get(userId=friend['friendId']))
        # シリアライザオブジェクトを作成  
        serializer2 = UserInfoSerializer(instance=friend_list, many=True)
        # レスポンスオブジェクトを作成して返す
        return Response(serializer2.data, status.HTTP_200_OK)

class FriendDeleteAPIView(views.APIView):
    """ 友達を削除する """
    def delete(self, request, user_id, friend_id, *args, **kwargs):
        # モデルオブジェクトを取得
        friend = get_object_or_404(FriendInfo, userId=user_id, friendId=friend_id)
        # updateする
        data = {'status': 2}
        serializer = FriendInfoSerializer(instance=friend, data=data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        user = get_object_or_404(FriendInfo, userId=friend_id, friendId=user_id)
        # updateする
        data = {'status': 2}
        serializer = FriendInfoSerializer(instance=user, data=data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        # レスポンスオブジェクトを作成して返す
        return Response(status.HTTP_200_OK)

class FriendRequestAPIView(views.APIView):
    """ 友達申請を送る """
    def post(self, request, user_id, friend_id, *args, **kwargs):
        # バリデーション：UserとFriendが存在するかの確認
        user = get_object_or_404(UserInfo, userId=user_id)
        friend = get_object_or_404(UserInfo, userId=friend_id)
        # バリデーション：userとfriendが同じじゃないかの確認
        if user == friend:
            return Response('same id', status.HTTP_400_BAD_REQUEST)
        # バリデーション：すでにユーザが申請を出している場合
        if FriendInfo.objects.filter(userId=user_id, friendId=friend_id, status=0):
            return Response('already requested', status.HTTP_400_BAD_REQUEST)
        # バリデーション：すでにユーザと友達の場合
        if FriendInfo.objects.filter(userId=user_id, friendId=friend_id, status=1):
            return Response('already friend', status.HTTP_400_BAD_REQUEST)
        # バリデーション：ユーザを一度ブロックしている場合 TODO:テストする
        if FriendInfo.objects.filter(userId=user_id, friendId=friend_id, status=2):
            friend_info = FriendInfo.objects.filter(userId=user_id, friendId=friend_id, status=2)
            serializer = FriendInfoSerializer(friend_info[0], data={"userId":user_id, "friendId":friend_id, "status":0})
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data, status.HTTP_201_CREATED)
        # シリアライズオブジェクトを作成
        serializer = FriendInfoSerializer(data={"userId":user_id, "friendId":friend_id, "status":0})
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
        friends = FriendInfo.objects.filter(friendId=user_id, status=0)
        # シリアライザオブジェクトを作成
        serializer = FriendInfoSerializer(instance=friends, many=True)
        # 友達情報をUserInfoDBから取得
        friend_list = []
        for friend in serializer.data:
            friend_list.append(UserInfo.objects.get(userId=friend['userId']))
        # シリアライザオブジェクトを作成  
        serializer2 = UserInfoSerializer(instance=friend_list, many=True)
        # レスポンスオブジェクトを作成して返す
        return Response(serializer2.data, status.HTTP_200_OK)
    
    """ 自分に来ている友達申請を承諾する """
    def post(self, request, user_id, friend_id, *args, **kwargs):
        # バリデーション：UserとFriendが存在するかの確認
        user = get_object_or_404(UserInfo, userId=user_id)
        friend = get_object_or_404(UserInfo, userId=friend_id)

        if request.data['accept'] == 'true':
            # すでにあればupdate、なければcreate
            user_to_friend = FriendInfo.objects.filter(userId=user_id, friendId=friend_id)
            if not user_to_friend:
                serializer = FriendInfoSerializer(data={"userId":user_id, "friendId":friend_id, "status":1})
                serializer.is_valid(raise_exception=True)
                serializer.save()
            else:
                serializer = FriendInfoSerializer(user_to_friend[0], data={"status":1}, partial=True)
                serializer.is_valid(raise_exception=True)
                serializer.save()
            # すでにあればupdate、なければcreate
            friend_to_user = FriendInfo.objects.filter(userId=friend_id, friendId=user_id)
            if not friend_to_user:
                serializer = FriendInfoSerializer(data={"userId":friend_id, "friendId":user_id, "status":1})
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
            user_to_friend = FriendInfo.objects.filter(userId=user_id, friendId=friend_id)
            if not user_to_friend:
                serializer = FriendInfoSerializer(data={"userId":user_id, "friendId":friend_id, "status":2})
                serializer.is_valid(raise_exception=True)
                serializer.save()
            else:
                serializer = FriendInfoSerializer(user_to_friend[0], data={"status":2}, partial=True)
                serializer.is_valid(raise_exception=True)
                serializer.save()
            # すでにあればupdate、なければcreate
            friend_to_user = FriendInfo.objects.filter(userId=friend_id, friendId=user_id)
            if not friend_to_user:
                serializer = FriendInfoSerializer(data={"userId":friend_id, "friendId":user_id, "status":2})
                serializer.is_valid(raise_exception=True)
                serializer.save()
            else:
                serializer = FriendInfoSerializer(friend_to_user[0], data={"status":2}, partial=True)
                serializer.is_valid(raise_exception=True)
                serializer.save()
            # レスポンスオブジェクトを作成して返す
            return Response(serializer.data, status.HTTP_200_OK)
