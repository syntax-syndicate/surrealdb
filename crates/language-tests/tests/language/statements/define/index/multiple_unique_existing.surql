/**
[test]

[[test.results]]
value = "[{ account: 'apple', email: 'test@surrealdb.com', id: user:1 }]"

[[test.results]]
value = "[{ account: 'tesla', email: 'test@surrealdb.com', id: user:2 }]"

[[test.results]]
value = "[{ account: 'apple', email: 'test@surrealdb.com', id: user:3 }]"

[[test.results]]
value = "[{ account: 'tesla', email: 'test@surrealdb.com', id: user:4 }]"

[[test.results]]
error = "Database index `test` already contains ['apple', 'test@surrealdb.com'], with record `user:1`"

[[test.results]]
error = "Database index `test` already contains ['apple', 'test@surrealdb.com'], with record `user:1`"

[[test.results]]
value = "{ events: {  }, fields: {  }, indexes: {  }, lives: {  }, tables: {  } }"

*/
CREATE user:1 SET account = 'apple', email = 'test@surrealdb.com';
CREATE user:2 SET account = 'tesla', email = 'test@surrealdb.com';
CREATE user:3 SET account = 'apple', email = 'test@surrealdb.com';
CREATE user:4 SET account = 'tesla', email = 'test@surrealdb.com';
DEFINE INDEX test ON user FIELDS account, email UNIQUE;
DEFINE INDEX test ON user COLUMNS account, email UNIQUE;
INFO FOR TABLE user;
