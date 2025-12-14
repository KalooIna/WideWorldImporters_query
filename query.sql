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

/* 4 . Display all the details of the StockItemID "10" , last edited from 1st january 2013 to 31st december 2013 */
select *
from Sales.InvoiceLines as SIL
where ( SIL.StockItemID = 10 ) and (( SIL.LastEditedWhen ) between '2013-01-01' and '2013-12-31' )

/* 5 . Display the average unit price of all the StockItemIDs where the average line profit exceeds 150 */

select SIL.StockItemID , avg( SIL.UnitPRice )
from Sales.InvoiceLines as SIL
group by SIL.StockItemID
having avg( SIL.LineProfit ) > 150

/* 6 . Complete address of client with DeliveryAddress lines 1 and 2 and PostalAddress */
select SC.CustomerID , SC.CustomerName , concat( SC.DeliveryAddressLine1 , SC.DeliveryAddressLine2 , ' ' , SC.DeliveryPostalCode )
from Sales.Customers as SC

/* 7 . Fetch all records for stock item names starting with "USB".  */
select *
from Warehouse.StockItems as WSI
where upper( WSI.StockItemName ) like 'USB%'

