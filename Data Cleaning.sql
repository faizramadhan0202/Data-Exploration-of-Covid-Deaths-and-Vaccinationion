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

-- Breaking out Address into Individual Columns (Address, City, State)