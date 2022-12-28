Select*
from PortfolioProject1.dbo.[Housing Data]



Select SaleDate
from PortfolioProject1.dbo.[Housing Data]



Select SaleDate Converted, CONVERT(Date, SaleDate)
from PortfolioProject1.dbo.[Housing Data]



UPDATE PortfolioProject1.dbo.[Housing Data]
Set Saledate= Convert(Date, Saledate) 



ALTER TABLE PortfolioProject1.dbo.[Housing Data]
Add SalesDataConverted DATE;



UPDATE PortfolioProject1.dbo.[Housing Data]
SET SalesDataConverted = CONVERT(Date, SaleDate)



Select*
from PortfolioProject1.dbo.[Housing Data]
--Where PropertyAddress is null
Order by ParcelID



Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortfolioProject1.dbo.[Housing Data] a
Join PortfolioProject1.dbo.[Housing Data] b
   On a.ParcelID = b.ParcelID
   And a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null



UPDATE a
SET PropertyAddress= ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortfolioProject1.dbo.[Housing Data] a
Join PortfolioProject1.dbo.[Housing Data] b
   On a.ParcelID = b.ParcelID
   And a.[UniqueID ] <> b.[UniqueID ]



Select PropertyAddress
from PortfolioProject1.dbo.[Housing Data]
--Where PropertyAddress is null
--Order by ParcelID

SELECT 
SUBSTRING(PropertyAddress, 1, Charindex(',', PropertyAddress)-1) as Address
,SUBSTRING(PropertyAddress, Charindex(',', PropertyAddress)+1, LEN (PropertyAddress)) as Address
from PortfolioProject1.dbo.[Housing Data] 


ALTER TABLE PortfolioProject1.dbo.[Housing Data]
Add PropertySplitAddress Nvarchar(255)

UPDATE PortfolioProject1.dbo.[Housing Data]
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE PortfolioProject1.dbo.[Housing Data]
Add PropertySplitCity Nvarchar(255)

UPDATE PortfolioProject1.dbo.[Housing Data]
Set PropertySplitCity = SUBSTRING(PropertyAddress, Charindex(',', PropertyAddress)+1, LEN (PropertyAddress))

Select*
from PortfolioProject1.dbo.[Housing Data]

Select OwnerAddress
from PortfolioProject1.dbo.[Housing Data]

SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
from PortfolioProject1.dbo.[Housing Data]



ALTER TABLE PortfolioProject1.dbo.[Housing Data]
Add OwnerSplitAddress Nvarchar(255)

UPDATE PortfolioProject1.dbo.[Housing Data]
Set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE PortfolioProject1.dbo.[Housing Data]
Add OwnerSplitCity Nvarchar(255)

UPDATE PortfolioProject1.dbo.[Housing Data]
Set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE PortfolioProject1.dbo.[Housing Data]
Add OwnerSplitState Nvarchar(255)

UPDATE PortfolioProject1.dbo.[Housing Data]
Set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


Select*
from PortfolioProject1.dbo.[Housing Data]



Select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
from PortfolioProject1.dbo.[Housing Data]
Group by SoldAsVacant
Order by 2


Select SoldasVacant
, CASE WHEN SoldasVacant= 'Y' THEN 'Yes'
       WHEN SoldasVacant= 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
from PortfolioProject1.dbo.[Housing Data]


UPDATE PortfolioProject1.dbo.[Housing Data]
SET SoldAsVacant= CASE WHEN SoldasVacant= 'Y' THEN 'Yes'
       WHEN SoldasVacant= 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END


Select*
from PortfolioProject1.dbo.[Housing Data]


WITH RowNumCTE as(
Select*,
     ROW_NUMBER() OVER (
	 PARTITION BY ParcelID,
	 PropertyAddress,
	 SalePrice,
	 SaleDate,
	 LegalReference
	 ORDER BY 
	   UniqueID
	   ) row_num

from PortfolioProject1.dbo.[Housing Data] 
)
Select*
--Delete
From RowNumCTE
Where row_num > 1
Order By PropertyAddress


Select*
from PortfolioProject1.dbo.[Housing Data] 

ALTER TABLE PortfolioProject1.dbo.[Housing Data] 
DROP COLUMN OwnerAddress, TaxDistrict,PropertyAddress

ALTER TABLE PortfolioProject1.dbo.[Housing Data] 
DROP COLUMN SaleDate













