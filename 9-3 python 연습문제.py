from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from bs4 import BeautifulSoup
import pandas as pd
from IPython.display import display
import time

chrome_options = webdriver.ChromeOptions()
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)

driver.implicitly_wait(3)
driver.get("https://v.daum.net/v/20220902205233695")

# 소스를 읽어 BeautifulSoup 이용해 파싱 
html = driver.page_source
soup = BeautifulSoup(html, "html.parser")

# 명시적으로 1초 기다림 -> 없어도 됨.
time.sleep(1) # javascript 


# 이 문법이 의미하는 게 정확히 뭐지? 데이터 = soup에서 slector 가져온 거다
# ㅋㅋㅋ 데이터가 아니라 date 였어. 날짜 가져온 듯 ㅎㅎ
date = soup.select("#mArticle > div.head_view > div.info_view > span:nth-child(2) > span") 

# soup = soup 명령어
# soup 으로 가져올 때 막히면, timesleep + javascript로 가져올 수 있음.
# return document.querySelector = javascript 명령어임
# 가져올 게 하나밖에 없어 : [0] + text 형태로 가져와 : .text      
comment_count = soup.select('#mArticle > div.head_view > div.util_wrap > button > span.num_cmt.alex-count-area')[0].text
comment_count = driver.execute_script('return document.querySelector("#mArticle > div.head_view > div.util_wrap > button > span.num_cmt.alex-count-area").textContent')

# like_count =  soup.select
like_count = soup.select("#alex_action_emotion > div > div > button:nth-child(2) > span")[0].text
                              


# 아 프린트해야 가져올 수 있구나!!!!!
print("date :", date[0].text)
print("comment: ", comment_count)
print("like_count: ", like_count)


# driver.close()






----------------------------------------------------------
3번