-- Select All
select * from PortpolioProject01..NashvilleHousing;

-- Original Date Format (YYYY-MM-DD-Time)
select SaleDate
from PortpolioProject01..NashvilleHousing;

-- Standardlize Date Format (YYYY-MM-DD)
select SaleDate, (CONVERT(date,SaleDate)) as NewDate
from PortpolioProject01..NashvilleHousing;