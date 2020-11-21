from requests import get
import os

os["PUBLIC_IP"] = get('https://api.ipify.org').text

