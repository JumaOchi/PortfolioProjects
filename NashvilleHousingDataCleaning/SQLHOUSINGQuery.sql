
--SELECT THE DATABASE IN USE

USE PortfolioProject;

-- view the relevant table

SELECT * FROM Nashville_Housing_Data;

-- Populate Property Adress data 

SELECT * FROM Nashville_Housing_Data
--WHERE PropertyAddress is null
ORDER BY ParcelID
    -- SUBSTRING(parcelid, 1, 3),   -- First numeric part (e.g., '052')
    -- SUBSTRING(parcelid, 5, 2),   -- Second numeric part (e.g., '14')
    -- SUBSTRING(parcelid, 8, 2),   -- Alphanumeric part (e.g., '0A')
    -- CAST(SUBSTRING(parcelid, 11, LEN(parcelid)) AS DECIMAL(10,2)); -- Decimal part

SELECT  a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Nashville_Housing_Data a
JOIN Nashville_Housing_Data b
on a.ParcelID = b.ParcelID
AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress is null

 UPDATE a 
 SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
 FROM Nashville_Housing_Data a
JOIN Nashville_Housing_Data b
on a.ParcelID = b.ParcelID
AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress is null

-- Breaking out Address Into Individual Columns (Address, City, State)

SELECT * --PropertyAddress 
FROM Nashville_Housing_Data

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress) ) as city

FROM Nashville_Housing_Data

ALTER TABLE Nashville_Housing_Data
ADD 
	PropertySplitAddress NVARCHAR(40),
	PropertySplitCity NVARCHAR(30)

UPDATE Nashville_Housing_Data
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ),
	PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress) )
	

-- owner address 

SELECT * -- OwnerAddress 
FROM Nashville_Housing_Data

SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM Nashville_Housing_Data

ALTER TABLE Nashville_Housing_Data
ADD OwnerSplitAddress NVARCHAR(255),
	OwnerSplitCity NVARCHAR(255),
	OwnerSplitState NVARCHAR(60)

UPDATE Nashville_Housing_Data
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
	OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
	OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

	 
-- Change Y and N to Yes and No in "Sold as Vaccant" field STANDARDIZING THE COLUMN)

SELECT DISTINCT(SoldAsVacant), Count(SoldAsVacant)
FROM Nashville_Housing_Data
GROUP BY SoldAsVacant
Order By 2

UPDATE Nashville_Housing_Data
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END



-- Removing Duplicates

WITH RowNumCTE AS (
SELECT * ,
 ROW_NUMBER() OVER (
 PARTITION BY ParcelID,
			  PropertyAddress,
			  SalePrice,
			  SaleDate,
			  LegalReference
			  ORDER by UniqueID) row_num

FROM Nashville_Housing_Data
)

SELECT * 
FROM RowNumCTE
WHERE row_num > 1
-- Order By PropertyAddress



