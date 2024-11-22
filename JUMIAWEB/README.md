Jumia Store Data Analysis Project

This project involves web scraping, data cleaning, exploratory data analysis (EDA), and simple visualizations to analyze the top 160 most expensive mobile phones listed on the Jumia Kenya platform. It highlights the process of extracting specific phone features, prices, and performing analysis on the cleaned data.
Features of the Project

    Web Scraping:
        Utilized Beautiful Soup and Python to scrape mobile phone data from Jumia's website.
        Extracted key features of the phones, such as:
            Brand and Model
            Screen Size
            RAM and ROM Specifications
            Price
        Implemented pagination scraping to collect data from multiple pages of the website.
        Saved the extracted data into a CSV file.

    Data Cleaning:
        Loaded the scraped data into a Pandas DataFrame.
        Dropped irrelevant or null values and handled missing data.
        Parsed and formatted columns to ensure consistency (e.g., converting prices to integers and removing unnecessary characters like "KSh").
        Corrected mislabeled data (e.g., swapped RAM and ROM where appropriate).

    Exploratory Data Analysis (EDA):
        Analyzed key trends and distributions in the dataset.
        Identified the most expensive brands and their price ranges.
        Focused on comparisons between popular brands such as Apple and Samsung.

    Visualization:
        Used Matplotlib and Seaborn to create meaningful visualizations, including:
            Box plots to compare price ranges across brands.
            Distribution of phone prices and other key features.

Tools & Libraries Used

    Web Scraping:
        Beautiful Soup
        requests for fetching webpage data
    Data Cleaning and Analysis:
        Pandas for DataFrame operations
        Python's built-in regex (re) for text cleaning
    Data Visualization:
        Matplotlib for creating static visualizations
        Seaborn for enhanced statistical visuals

Key Findings

    Top Brands:
        Apple and Samsung dominate the premium phone market.
        Apple phones consistently appear in higher price brackets.

    Price Trends:
        The average price of high-end phones on Jumia is around KES 200,000.
        Outliers were identified, with some phones priced as low as KES 120,000.

    Specifications:
        Larger storage (ROM) capacities correlate with higher prices.
        Some data irregularities (e.g., swapped RAM and ROM) were cleaned during preprocessing.

        
