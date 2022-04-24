# _Lego SQL_

#### By _**Jarret Jeter**_

#### _This project was made to show competence of using SQL to read and work with a database_

## Technologies Used

* _SQL_
* _Docker_
* _Beekeeper Studio_
* _MariaDB_

## Description

_The code begins with simple queries like selecting columns and finding substrings to narrow information, and then on to subqueries. Next is updating columns and also adding to them. I use aggregation on tables and filter then to find particular details. The last three blocks of code use different joins on table id's to find what they have in common._

## Setup/Installation Requirements

* _Clone this repository onto your machine._
* _In your command line, run ./start_db.sh_
* _Open Beekeeper Studio and start a new connection(Connection type: MariaDB, Host: localhost, Port: 3306, User: root, Password: mysql) and connect_
* _Select lego from the left dropdown list_
* _Type in 'show tables' to check that you're connected to the lego database_
* _Now you can input the code I've written to see how it works_


## Known Bugs

_Possible incorrect code here:_
* _UPDATE inventory_parts SET quantity = quantity * 2
WHERE quantity > 1;_
* _SELECT *
FROM inventory_parts
ORDER BY quantity LIMIT 20;_

## License

_If you have any questions or concerns, please email me at jarretjeter@gmail.com_

[MIT](https://github.com/jarretjeter/Lego-SQL/blob/main/LICENSE.txt)
Copyright (c) _04/23/2022_ _Jarret Jeter_
