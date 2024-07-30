# Crowdfunding_ETL
hands-on experience in building an ETL (Extract, Transform, Load) pipeline using Python Pandas, and creating a PostgreSQL database


## UCB-VIRT-DATA-PT-04-2024-U-LOLC
# ReadMe

dataviz project 2 ETL

## Installation

Use the package manager [pip](https://pip.pypa.io/en/stable/) to install.

```bash
import pandas as pd
import numpy as np
```

## Usage

### Read the data into a Pandas DataFrame
```
crowdfunding_info_df = pd.read_excel('Resources/crowdfunding.xlsx')

crowdfunding_info_df.head()
```
<img width="453" alt="Screenshot 2024-07-29 at 8 19 43 PM" src="https://github.com/user-attachments/assets/b234e622-2571-47b1-b754-24da5aca7415">

### Assign the category and subcategory values to category and subcategory columns.
```
crowdfunding_info_df[['category','subcategory']] = crowdfunding_info_df['category & sub-category'].str.split('/', expand=True)
crowdfunding_info_df.head()
```
#### Create category and subcategory DataFrames
<img width="203" alt="Screenshot 2024-07-29 at 8 20 32 PM" src="https://github.com/user-attachments/assets/b7dd8157-8759-4f78-a0a4-3a3a5ddbb73c">
<img width="265" alt="Screenshot 2024-07-29 at 8 20 45 PM" src="https://github.com/user-attachments/assets/e2ea67dd-6a34-4120-a718-0be44db0be6b">

### Edit Campaign DataFrame and Format From Copy of Crowdfunding DataFram

```
campaign_df = crowdfunding_info_df.copy()
campaign_df.head()

campaign_df.rename(columns={'blurb': 'description', 'launched_at': 'launch_date', 'deadline': 'end_date'}, inplace=True)
campaign_df.head()

campaign_df[["goal", "pledged"]] = campaign_df[["goal", "pledged"]].astype(float)

from datetime import datetime as dt
campaign_df["launch_date"] = pd.to_datetime(campaign_df["launch_date"], unit='s').dt.strftime('%Y-%m-%d') 
campaign_df["end_date"] = pd.to_datetime(campaign_df["end_date"], unit='s').dt.strftime('%Y-%m-%d')
campaign_df.head()
```
### Merge with category and subcategory DataFrames
```
campaign_merged_df = campaign_df.merge(category_df, on='category', how='left').merge(subcategory_df, on='subcategory', how='left')
campaign_merged_df.tail(10)
```

### Drop unwanted columns
```
campaign_merged_df.drop(columns=['staff_pick','spotlight','category & sub-category', 'category', 'subcategory'], inplace=True)
```
<img width="218" alt="Screenshot 2024-07-29 at 8 24 30 PM" src="https://github.com/user-attachments/assets/17e4b702-4cc8-4047-a635-cf6bf88fa6e4">

## Use Regex for Contacts DataFrames
```
contact_info_df_copy['contact_id'] = contact_info_df_copy['contact_info'].str.extract(r'"contact_id": (\d{4})')
contact_info_df_copy['name'] = contact_info_df_copy['contact_info'].str.extract(r'"name": "([^"]+)"')
contact_info_df_copy['email'] = contact_info_df_copy['contact_info'].str.extract(r'"email": "([^"]+)"')
```

## Final Tables in pgAdmin
### Contacts
<img width="754" alt="Screenshot 2024-07-29 at 7 52 13 PM" src="https://github.com/user-attachments/assets/a7cdf8e3-aec4-40d0-87be-c99f05138a8c">

### Categories
<img width="447" alt="Screenshot 2024-07-29 at 7 52 23 PM" src="https://github.com/user-attachments/assets/f29cf30f-a37a-471c-bffe-e82804da6b1e">

### Sub Categories
<img width="468" alt="Screenshot 2024-07-29 at 7 52 33 PM" src="https://github.com/user-attachments/assets/8d154933-b8f9-44f6-902a-9ccec7587309">

### Campaigns
<img width="1111" alt="Screenshot 2024-07-29 at 7 52 01 PM" src="https://github.com/user-attachments/assets/f59ef95c-6669-4a51-9f2b-4863d7578b7b">

### ERD
<img width="738" alt="Screenshot 2024-07-27 at 9 39 05 PM" src="https://github.com/user-attachments/assets/2b34b8f8-f27a-45c6-95d0-5b997286ceb8">

## 
