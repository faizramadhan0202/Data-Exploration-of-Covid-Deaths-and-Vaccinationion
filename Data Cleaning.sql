-- Select All
select * from PortpolioProject01..NashvilleHousing;

-- Original Date Format (YYYY-MM-DD-Time)
select SaleDate
from PortpolioProject01..NashvilleHousing;

-- Standardlize Date Format (YYYY-MM-DD)
select SaleDate, (CONVERT(date,SaleDate)) as NewDate
from PortpolioProject01..NashvilleHousing;

-- Update SaleDate
Update PortpolioProject01..NashvilleHousing
Set SaleDate = CONVERT(date, SaleDate);

-- Alter Table Add Column SaleDateConverted
Alter Table PortpolioProject01..NashvilleHousing
Add SaleDateConverted Date;

-- Update SaleDateConverted
Update PortpolioProject01..NashvilleHousing
Set SaleDateConverted = CONVERT(Date, SaleDate);

-- Select SaleDateConverted
select SaleDateConverted, (CONVERT(date,SaleDate))
from PortpolioProject01..NashvilleHousing;

-- Populate Property Address Data
select PropertyAddress
from PortpolioProject01..NashvilleHousing
where PropertyAddress is null

-- Select ParcelID
select *
from PortpolioProject01..NashvilleHousing
order by ParcelID

-- Join ParcelID and PropertyAddress
select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortpolioProject01..NashvilleHousing a
Join PortpolioProject01..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is Null

-- Update Null PropertyAddress
Update a
Set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortpolioProject01..NashvilleHousing a
	Join PortpolioProject01..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is Null

/*------------------------------------------------------------------------------------------*/

-- Breaking out Address into Individual Columns (Address, City, State)

select PropertyAddress
from PortpolioProject01..NashvilleHousing

-- Deletion Comma
select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) as Address
from PortpolioProject01..NashvilleHousing

-- Alter Table Add Column PropetySplitAddress
Alter Table PortpolioProject01..NashvilleHousing
Add PropetySplitAddress Nvarchar(255);

-- Update PropetySplitAddress
Update PortpolioProject01..NashvilleHousing
Set PropetySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

-- Alter Table Add Column PropetySplitCity
Alter Table PortpolioProject01..NashvilleHousing
Add PropetySplitCity Nvarchar(255);

-- Update PropetySplitCity
Update PortpolioProject01..NashvilleHousing
Set PropetySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress));

-- Select All
select *
from PortpolioProject01..NashvilleHousing

-- Rename Table
sp_rename 'PortpolioProject01..NashvilleHousing.PropetySplitAddress', 'PropertySplitAddress';

sp_rename 'PortpolioProject01..NashvilleHousing.PropetySplitCity', 'PropertySplitCity';

-- Select All
Select *
from PortpolioProject01..NashvilleHousing

-- Select OwnerAddress
select OwnerAddress
from PortpolioProject01..NashvilleHousing

-- Separator To Column
select
PARSENAME(REPLACE(OwnerAddress, ',','.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',','.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)
from PortpolioProject01..NashvilleHousing

-- Alter Table Add Column OwnerSplitAddress
Alter Table PortpolioProject01..NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

-- Update OwnerSplitAddress
Update PortpolioProject01..NashvilleHousing
Set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',','.'), 3)

-- Alter Table Add Column OwnerSplitCity
Alter Table PortpolioProject01..NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

-- Update OwnerSplitCity
Update PortpolioProject01..NashvilleHousing
Set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',','.'), 2)

-- Alter Table Add Column OwnerSplitState
Alter Table PortpolioProject01..NashvilleHousing
Add OwnerSplitState Nvarchar(255);

-- Update PropetySplitCity
Update PortpolioProject01..NashvilleHousing
Set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)

-- Select All
select *
from PortpolioProject01..NashvilleHousing

/*------------------------------------------------------------------------------------------*/

-- Change Y and N to Yes and No in "Sold as Vacant" field
select Distinct(SoldAsVacant)
from PortpolioProject01..NashvilleHousing

-- Count SoldAsVacant
select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
from PortpolioProject01..NashvilleHousing
Group by SoldAsVacant
order by 2

-- Using Case When
select SoldAsVacant,
CASE When SoldAsVacant = 'Y' THEN 'Yes'
	 When SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END
from PortpolioProject01..NashvilleHousing

-- Update SoldAsVacant 
Update PortpolioProject01..NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	 When SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END

/*------------------------------------------------------------------------------------------*/

-- Remove Duplicate
WITH RowNumCTE AS(
select *,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

from PortpolioProject01..NashvilleHousing
--order by ParcelID
)
DELETE
from RowNumCTE
where row_num > 1
--order by PropertyAddress


--- check Duplicate
WITH RowNumCTE AS(
select *,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

from PortpolioProject01..NashvilleHousing
--order by ParcelID
)
select *
from RowNumCTE
where row_num > 1
order by PropertyAddress


/*------------------------------------------------------------------------------------------*/

-- Delete Unused column
select *
from PortpolioProject01..NashvilleHousing

ALTER TABLE PortpolioProject01..NashvilleHousing
	DROP COLUMN OwnerAddress,
				TaxDistrict,
				PropertyAddress

ALTER TABLE PortpolioProject01..NashvilleHousing
	DROP COLUMN SaleDate