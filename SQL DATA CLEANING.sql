
--Clean Data in SQL Queries

select * from [dbo].[NashvilleHousing]




--Standardize Data Format

select SaleDateConverted , CONVERT(Date,saledate)
from [portfolioProject].[dbo].[NashvilleHousing]

update [dbo].[NashvilleHousing]
set saledate=CONVERT(Date,saledate)

ALTER  table [dbo].[NashvilleHousing]
add SaleDateConverted Date;


UPDATE [dbo].[NashvilleHousing]
SET SaleDateConverted =CONVERT(date,saledate)

--populate Property Address data

select *
from [dbo].[NashvilleHousing]
order by [ParcelID]




select a.[ParcelID],a.PropertyAddress,b.parcelid,b.PropertyAddress,isnull(a.PropertyAddress,b.PropertyAddress)
from [dbo].[NashvilleHousing] a
join [dbo].[NashvilleHousing] b
     on a.parcelid=b.parcelid
	 and a.uniqueid<>b.uniqueid
where a.PropertyAddress is null


update a
set [PropertyAddress]=isnull(a.PropertyAddress,b.PropertyAddress)
from [dbo].[NashvilleHousing] a
join [dbo].[NashvilleHousing] b
     on a.parcelid=b.parcelid
	 and a.uniqueid<>b.uniqueid
where a.PropertyAddress is null




--Breaking out Address onto Individual Columns (Address,City,State


select [PropertyAddress]
from [dbo].[NashvilleHousing]


select 
SUBSTRING([PropertyAddress],1,CHARINDEX(',',[PropertyAddress])-1) as Address
,SUBSTRING([PropertyAddress],CHARINDEX(',',[PropertyAddress])+1,len([PropertyAddress])) as Address
from [dbo].[NashvilleHousing] 


Alter table [dbo].[NashvilleHousing]
add PropertySplitAddress Nvarchar(255);

Update [dbo].[NashvilleHousing]
set PropertySplitAddress=SUBSTRING([PropertyAddress],1,CHARINDEX(',',[PropertyAddress])-1)

ALTER TABLE [dbo].[NashvilleHousing]
ADD propertySplitCity Nvarchar(255);

UPDATE [dbo].[NashvilleHousing]
SET propertySplitCity =SUBSTRING([PropertyAddress],CHARINDEX(',',[PropertyAddress])+1,len([PropertyAddress]))

select*
from [dbo].[NashvilleHousing]


select [OwnerAddress]
from [dbo].[NashvilleHousing]

SELECT 
PARSENAME(REPLACE([OwnerAddress],',','.'),3)
,PARSENAME(REPLACE([OwnerAddress],',','.'),2)
,PARSENAME(REPLACE([OwnerAddress],',','.'),1)
FROM [dbo].[NashvilleHousing]

ALTER TABLE [dbo].[NashvilleHousing]
ADD OwnerAdrress Nvarchar(255);

UPDATE [dbo].[NashvilleHousing]
SET OwnerAdrress =PARSENAME(REPLACE([OwnerAddress],',','.'),3)

ALTER TABLE [dbo].[NashvilleHousing]
ADD OwnerCity Nvarchar(255);

UPDATE [dbo].[NashvilleHousing]
SET OwnerCity =PARSENAME(REPLACE([OwnerAddress],',','.'),2)

ALTER TABLE [dbo].[NashvilleHousing]
ADD OwnerState Nvarchar(255);

UPDATE [dbo].[NashvilleHousing]
SET OwnerState =PARSENAME(REPLACE([OwnerAddress],',','.'),1)


select*
from [dbo].[NashvilleHousing]


--Chang Y and N to Yes and No in 'Sold as Vacant' field

SELECT DISTINCT ([SoldAsVacant]),count ([SoldAsVacant])
from [dbo].[NashvilleHousing]
Group by [SoldAsVacant]
order by 2


select [SoldAsVacant]
,CASE WHEN [SoldAsVacant]='Y' THEN 'Yes'
     when [SoldAsVacant]='N' THEN 'No'
	 else [SoldAsVacant]
	 END
FROM [dbo].[NashvilleHousing]

UPDATE [dbo].[NashvilleHousing]
SET
[SoldAsVacant]=CASE WHEN [SoldAsVacant]='Y' THEN 'Yes'
     when [SoldAsVacant]='N' THEN 'No'
	 else [SoldAsVacant]
	 END



--Remove Duplicates

with RowNumCTE AS(
SELECT *,
  ROW_NUMBER() OVER(
  PARTITION BY [ParcelID],
               [PropertyAddress],
               [SalePrice],
               [LegalReference]
			   order by
			      [UniqueID ]
			      ) row_num
from [dbo].[NashvilleHousing]
)
delete
FROM RowNumCTE
WHERE row_num>1


--DELATE  Unused COLUMNS

select *
from [dbo].[NashvilleHousing]

ALTER TABLE [dbo].[NashvilleHousing]
DROP COLUMN [PropertyAddress],[OwnerAddress],[TaxDistrict]







select *
from [dbo].[NashvilleHousing]