CREATE VIEW PurchaseLog AS
SELECT 
    ThePeople.Id AS PersonId,
    ThePeople.FirstName,
    ThePeople.LastName,
    TheOrders.OrderTime,    
    TheProducts.ProductName,
    TheProducts.ProductPrice,
	TheOrders.OrderAmount
FROM 
    ThePeople
INNER JOIN 
    TheOrders ON ThePeople.Id = TheOrders.CustomerId
INNER JOIN 
    TheOrdersTheProducts ON TheOrders.Id = TheOrdersTheProducts.OrderId
INNER JOIN 
    TheProducts ON TheOrdersTheProducts.ProductId = TheProducts.Id;

------------------------

SELECT * FROM PurchaseLog
ORDER BY OrderTime DESC;