select * 
from PortfolioProject.dbo.NashvilleHousing


select SaleDate , convert(date,Saledate)
from PortfolioProject.dbo.NashvilleHousing


Update NashvilleHousing
set Saledate = convert(date, saledate)


Alter table NashvilleHousing
add SaleDateConverted Date;

Update NashvilleHousing
set SaledateConverted = convert(date, saledate)


select *
from PortfolioProject.dbo.NashvilleHousing
--where propertyaddress is null
order by ParcelID



select a.parcelid, a.propertyaddress, b.parcelid, b.propertyaddress, isnull(a.propertyaddress, b.propertyaddress)
from PortfolioProject.dbo.NashvilleHousing a
join PortfolioProject.dbo.NashvilleHousing b
     on a.ParcelID=b.ParcelID
	 and a.[UniqueID ] <> b.[UniqueID ]
where a.propertyaddress is null


update a
set propertyaddress=isnull(a.propertyaddress, b.propertyaddress)
from PortfolioProject.dbo.NashvilleHousing a
join PortfolioProject.dbo.NashvilleHousing b
     on a.ParcelID=b.ParcelID
	 and a.[UniqueID ] <> b.[UniqueID ]
where a.propertyaddress is null


select PropertyAddress
from PortfolioProject.dbo.NashvilleHousing
--where propertyaddress is null
order by ParcelID

select 
substring(propertyaddress, 1, CHARINDEX(',', propertyaddress)-1) as address,
substring(propertyaddress, CHARINDEX(',', propertyaddress)+1, len(PropertyAddress)) as address
from PortfolioProject.dbo.NashvilleHousing


select OwnerAddress 
from PortfolioProject.dbo.NashvilleHousing

select 
parsename(Replace(owneraddress,',','.'), 3),
parsename(Replace(owneraddress,',','.'), 2),
parsename(Replace(owneraddress,',','.'), 1)
from PortfolioProject.dbo.NashvilleHousing


select distinct(SoldAsVacant), count(SoldAsVacant)
from  PortfolioProject.dbo.NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant,
case when SoldAsVacant='Y' then 'Yes'
     when SoldAsVacant='N' then 'No'
	 else SoldAsVacant
	 end
from  PortfolioProject.dbo.NashvilleHousing



update NashvilleHousing
set SoldAsVacant=case when SoldAsVacant='Y' then 'Yes'
     when SoldAsVacant='N' then 'No'
	 else SoldAsVacant
	 end


with RownumCTE as(
select *, 
Row_number() over (
partition by ParcelID,
PropertyAddress,
saleprice,
SaleDate,
LegalReference
order by
  uniqueID
  ) row_num
from PortfolioProject.dbo.NashvilleHousing
--order by ParcelID
)

select *  
from RownumCTE
where row_num > 1
--order by propertyaddress


select * 
from PortfolioProject.dbo.NashvilleHousing


alter table PortfolioProject.dbo.NashvilleHousing
drop column owneraddress,taxdistrict,propertyaddress

alter table PortfolioProject.dbo.NashvilleHousing
drop column saledate
