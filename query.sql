use WideWorldImporters

/* Orders placed on the 26th june 2015 */
select count( SO.OrderID )
from Sales.Orders as SO
where SO.OrderDate = '2015-06-26'

/* Total transaction amount done by the client whose CustomerId = 1 */
select sum( SCT.TransactionAmount )
from Sales.CustomerTransactions as SCT
where SCT.CustomerID = 1

/* Average tax amount */
select avg( SCT.TaxAmount )
from Sales.CustomerTransactions as SCT

/* Display all the details of the StockItemID "10" , last edited from 1st january 2013 to 31st december 2013 */
select *
from Sales.InvoiceLines as SIL
where ( SIL.StockItemID = 10 ) and (( SIL.LastEditedWhen ) between '2013-01-01' and '2013-12-31' )



