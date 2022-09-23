import pandas as pd
df = pd.read_excel('노원구.xlsx')

import folium
from folium import Choropleth, Circle, Marker

m = folium.Map(location=[37.6429841, 127.0742628], zoom_start=15)

for 위도, 경도, 시설명 in zip(df['위도'], df['경도'], df['코드']):
    folium.Circle(
        location=[위도, 경도],
        radius=250,
        fill=True,
        color="#800000",
        fill_color="#FFFFFF",
        popup=시설명).add_to(m)
    
m