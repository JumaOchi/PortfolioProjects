import requests
from bs4 import BeautifulSoup
import pandas as pd

url = 'https://en.wikipedia.org/wiki/List_of_largest_companies_in_the_United_States_by_revenue#List_of_the_largest_public_/_publicly_traded_companies'

page = requests.get(url)
soup = BeautifulSoup(page.text, 'html.parser')

#print(soup)

table = soup.find_all('table')[0]

world_titles = table.find_all('th')

world_table_titles = [title.text.strip() for title in world_titles]
#print(world_table_titles)

df = pd.DataFrame(columns= world_table_titles)

column_data = table.find_all('tr')
#print(column_data)

for row in column_data[1:] :
    row_data = row.find_all('td')
    individual_row_data = [data.text.strip() for data in row_data]
    #print(individual_row_data)
    length = len(df)
    df.loc[length] = individual_row_data

first_rows = df.head()
print(first_rows)

anal = df.describe()
print(anal)