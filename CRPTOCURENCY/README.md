README: Cryptocurrency Analysis Using CoinMarketCap API
Project Title

Cryptocurrency Market Analysis: Top 15 Coins
Project Description

This project focuses on consuming the CoinMarketCap API to fetch data about the top 15 cryptocurrencies and perform an in-depth analysis of their performance over various time periods. The analysis involves cleaning the raw data, processing it using Python (Pandas), and visualizing the changes in cryptocurrency values across multiple timeframes (1 hour, 24 hours, 7 days, 30 days, 60 days, and 90 days).

The insights gained from this analysis can help identify trends, volatility, and key patterns in the cryptocurrency market. This project highlights my ability to work with APIs, handle data programmatically, and perform data analysis effectively.
Features

    API Integration:
        Fetched live cryptocurrency data from CoinMarketCap API after obtaining an API key.
        Utilized requests library to interact with the API and retrieve data in JSON format.

    Data Processing:
        Used pandas to normalize the API response and structure the data into a clean DataFrame.
        Cleaned and prepared the data for analysis by handling missing values, formatting timestamps, and setting up columns for calculations.

    Analysis:
        Analyzed the performance of the top 15 cryptocurrencies based on their percentage change in value over the following periods:
            1 hour
            24 hours
            7 days
            30 days
            60 days
            90 days
        Explored patterns in volatility and highlighted the best- and worst-performing coins.

    Visualizations:
        Created visualizations to showcase changes over time using libraries like Matplotlib and Seaborn.
        Highlighted insights with:
            Line plots for trend analysis.
            Bar plots for comparisons across coins and time periods.
            Stacked area charts for cumulative trends.

Technologies Used

    Programming Language: Python
    Libraries:
        pandas: Data manipulation and cleaning.
        requests: API interaction.
        matplotlib & seaborn: Data visualization.
        json: Handling API responses in JSON format.
    Data Source: CoinMarketCap API

Project Workflow

    Data Collection: Fetched data for the top 15 cryptocurrencies using the CoinMarketCap API.
    Data Cleaning:
        Normalized nested JSON data into a DataFrame.
        Added timestamps and reformatted columns for clarity.
    Exploratory Data Analysis (EDA):
        Calculated trends in percentage changes over time.
        Identified the top-performing and worst-performing coins.
    Visualization:
        Used clear and concise visualizations to communicate findings.
        Answered questions such as:
            Which coins are the most volatile?
            Which coins have shown consistent growth/decline?

Key Insights

    The most volatile cryptocurrencies over shorter time periods (1h, 24h) differ significantly from those with longer-term trends (60d, 90d).
    Coins like Bitcoin and Ethereum show relatively stable growth trends, whereas smaller coins exhibit higher volatility.
    Certain coins, despite being ranked lower in terms of market cap, performed exceptionally well over specific timeframes, highlighting potential investment opportunities.