USE e_commerce;
SELECT
    T1.CustomerID,
    C.FirstName,
    T1.TotalSpent,
    -- CTEs / Window Functions bhi istemal ho sakti hain, lekin subquery focus hai
    -- Yahan hum sirf Total Spent hi dikhayenge.
    ROW_NUMBER() OVER (ORDER BY T1.TotalSpent DESC) AS SpendingRank -- Ranking ke liye
FROM
    Customer C
INNER JOIN
    -- Inner Query (Derived Table) - FROM clause mein istemal hui.
    (
        SELECT
            CustomerID,
            SUM(TotalAmount) AS TotalSpent
        FROM
            Orders
        GROUP BY
            CustomerID
    ) AS T1 -- Alias (T1) dena zaroori hai!
ON
    C.CustomerID = T1.CustomerID
ORDER BY
    T1.TotalSpent DESC;
