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
