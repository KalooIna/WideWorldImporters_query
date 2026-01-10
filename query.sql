use WideWorldImporters

/* 1 . Orders placed on the 26th june 2015 */
select count( SO.OrderID )
from Sales.Orders as SO
where SO.OrderDate = '2015-06-26'

/* 2 . Total transaction amount done by the client whose CustomerId = 1 */
select sum( SCT.TransactionAmount )
from Sales.CustomerTransactions as SCT
where SCT.CustomerID = 1

/* 3 . Average tax amount */
select avg( SCT.TaxAmount )
from Sales.CustomerTransactions as SCT

/* 4 . Details of the StockItemID "10" , last edited from 1st january 2013 to 31st december 2013 */
select *
from Sales.InvoiceLines as SIL
where ( SIL.StockItemID = 10 ) and (( SIL.LastEditedWhen ) between '2013-01-01' and '2013-12-31' )

/* 5 . Average unit price of all the StockItemIDs where the average line profit exceeds 150 */

select SIL.StockItemID , avg( SIL.UnitPRice )
from Sales.InvoiceLines as SIL
group by SIL.StockItemID
having avg( SIL.LineProfit ) > 150

/* 6 . Complete address of client with DeliveryAddress lines 1 and 2 and PostalAddress */
select 
	SC.CustomerID , 
	SC.CustomerName , 
	concat( SC.DeliveryAddressLine1 , SC.DeliveryAddressLine2 , ' ' , SC.DeliveryPostalCode )
from Sales.Customers as SC

/* 7 . Records for stock item names starting with "USB".  */
select *
from Warehouse.StockItems as WSI
where upper( WSI.StockItemName ) like 'USB%'

/* 8 . Round off the transaction amount to the nearest integer value */
select round( SCT.TransactionAmount , 0 )
from Sales.CustomerTransactions as SCT

/* 9 . Top 10 customers with the highest total purchase amount */
select top 10 
	SCT.CustomerID , 
	sum( SCT.TransactionAmount ) as TotalTransactionAmount
from Sales.CustomerTransactions as SCT
group by SCT.CustomerID
order by TotalTransactionAmountByCustomer desc

/* 10 . Total transaction amount for each year */
select 
	year( SCT.TransactionDate ) as TransactionYear , 
	sum( SCT.TransactionAmount ) as TotalTransactionAmount
from Sales.CustomerTransactions as SCT
group by year( SCT.TransactionDate )
order by TransactionYear asc

/* 11 . Number of customers who made more than 5 repeat purchases */
select 
	SO.CustomerID ,
	count( SO.CustomerID ) as n_orders
from Sales.Orders as SO
group by SO.CustomerID
having count( SO.CustomerID ) >= 5

/* 12 . Stock items in the warehouse with a quantity on hand below the reorder level */
select count( * ) as n_stockitems_quantonhand_inf_reorderlevel
from Warehouse.StockItemHoldings as WSIH
where WSIH.QuantityOnHand < WSIH.ReorderLevel

/* 13 . Total value of stock items held in the warehouse */
select sum( WSIH.QuantityOnHand * WSI.UnitPrice ) as warehouse_totval
from 
	Warehouse.StockItems as WSI 
	inner join 
	Warehouse.StockItemHoldings as WSIH 
	on ( WSI.StockItemID = WSIH.StockItemID ) 

/* 14 . Average quantity on hand for each stock item name in the warehouse ? */
select 
	WSI.StockItemName ,
	avg( WSIH.QuantityOnHand ) as avg_QuantityOnHand
from 
	Warehouse.StockItems as WSI 
	inner join 
	Warehouse.StockItemHoldings as WSIH 
	on ( WSI.StockItemID = WSIH.StockItemID )
group by WSI.StockItemName

/* 15 . Stock item woth the highest quantity on hand in the warehouse */
select top 1 
	WSI.StockItemID , 
	WSI.StockItemName , 
	WSIH.QuantityOnHand
from 
	Warehouse.StockItems as WSI
	inner join 
	Warehouse.StockItemHoldings as WSIH 
	on ( WSI.StockItemID = WSIH.StockItemID )
order by WSIH.QuantityOnHand desc

/* 16 . Rank of each customer transaction based on the amount transacted for each transaction type */
select 
	rank() over ( partition by SCT.TransactionTypeID order by SCT.TransactionAmount asc ) as rank ,
	SCT.CustomerID ,
	ATT.TransactionTypeName , 
	SCT.TransactionAmount
from 
	Sales.CustomerTransactions as SCT
	inner join
	Application.TransactionTypes as ATT
	on ( SCT.TransactionTypeID = ATT.TransactionTypeID )

/* 17 . Total sales revenue for each year and month + grand total for all years and months */
select 
	year( SO.OrderDate ) as OrderYear ,
	month( SO.OrderDate ) as OrderMonth ,
	sum( SOL.Quantity * SOL.UnitPrice ) as tot_salesrevenue
from 
	Sales.Orders as SO
	inner join
	Sales.OrderLines as SOL
	on ( SO.OrderID = SOL.OrderLineID )
group by rollup ( year( SO.OrderDate ) , month( SO.OrderDate ))
order by OrderYear asc , OrderMonth asc

/* 18 . Order details ( OrderID , CustomerName , OrderDate ) for all orders placed in the year 2015 and in the month of May */
select 
	SO.OrderID ,
	SC.CustomerName , 
	SO.OrderDate
from 
	Sales.Orders as SO 
	inner join
	Sales.Customers as SC
	on ( SO.CustomerID = SC.CustomerID )
where ( year( SO.OrderDate ) = 2015 ) and ( month( SO.OrderDate ) = 5 )

/* 19 . Create a transaction that updates the amount of supplier transactionn where SupplierTransaction ID is 12345 , and rollback the transaction */
select *
from Purchasing.SupplierTransactions




