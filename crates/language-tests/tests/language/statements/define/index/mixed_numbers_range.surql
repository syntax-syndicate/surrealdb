/**
[test]

[[test.results]]
value = "'OK'"

[[test.results]]
value = "[{ id: test:float0, number: 0.5f }, { id: test:float1, number: 1.5f }, { id: test:int1, number: 1 }]"

[[test.results]]
value = "[{ detail: { plan: { from: { inclusive: false, value: 0 }, index: 'index', to: { inclusive: false, value: 2 } }, table: 'test' }, operation: 'Iterate Index' }, { detail: { type: 'MemoryOrdered' }, operation: 'Collector' }]"

[[test.results]]
value = "[{ id: test:float0, number: 0.5f }, { id: test:float1, number: 1.5f }, { id: test:int1, number: 1 }]"

[[test.results]]
value = "[{ detail: { plan: { from: { inclusive: false, value: 0.1f }, index: 'index', to: { inclusive: false, value: 2 } }, table: 'test' }, operation: 'Iterate Index' }, { detail: { type: 'MemoryOrdered' }, operation: 'Collector' }]"

[[test.results]]
value = "[{ id: test:float0, number: 0.5f }, { id: test:int1, number: 1 }]"

[[test.results]]
value = "[{ detail: { plan: { from: { inclusive: false, value: 0.1f }, index: 'index', to: { inclusive: false, value: 1.5f } }, table: 'test' }, operation: 'Iterate Index' }, { detail: { type: 'MemoryOrdered' }, operation: 'Collector' }]"

[[test.results]]
value = "[{ id: test:float0, number: 0.5f }, { id: test:int1, number: 1 }]"

[[test.results]]
value = "[{ detail: { plan: { from: { inclusive: false, value: 0 }, index: 'index', to: { inclusive: false, value: 1.5f } }, table: 'test' }, operation: 'Iterate Index' }, { detail: { type: 'MemoryOrdered' }, operation: 'Collector' }]"

[[test.results]]
value = "[{ id: test:float0, number: 0.5f }, { id: test:float1, number: 1.5f }, { id: test:int1, number: 1 }, { id: test:int2, number: 2 }]"

[[test.results]]
value = "[{ detail: { plan: { from: { inclusive: false, value: 0.1f }, index: 'index', to: { inclusive: false, value: NONE } }, table: 'test' }, operation: 'Iterate Index' }, { detail: { type: 'MemoryOrdered' }, operation: 'Collector' }]"

[[test.results]]
value = "[{ id: test:float0, number: 0.5f }, { id: test:float1, number: 1.5f }, { id: test:int1, number: 1 }, { id: test:int2, number: 2 }]"

[[test.results]]
value = "[{ detail: { plan: { from: { inclusive: false, value: 0 }, index: 'index', to: { inclusive: false, value: NONE } }, table: 'test' }, operation: 'Iterate Index' }, { detail: { type: 'MemoryOrdered' }, operation: 'Collector' }]"

[[test.results]]
value = "[{ id: test:float0, number: 0.5f }, { id: test:float1, number: 1.5f }, { id: test:int0, number: 0 }, { id: test:int1, number: 1 }]"

[[test.results]]
value = "[{ detail: { plan: { from: { inclusive: false, value: NONE }, index: 'index', to: { inclusive: false, value: 2 } }, table: 'test' }, operation: 'Iterate Index' }, { detail: { type: 'MemoryOrdered' }, operation: 'Collector' }]"

[[test.results]]
value = "[{ id: test:float0, number: 0.5f }, { id: test:float1, number: 1.5f }, { id: test:int0, number: 0 }, { id: test:int1, number: 1 }]"

[[test.results]]
value = "[{ detail: { plan: { from: { inclusive: false, value: NONE }, index: 'index', to: { inclusive: false, value: 1.9f } }, table: 'test' }, operation: 'Iterate Index' }, { detail: { type: 'MemoryOrdered' }, operation: 'Collector' }]"


*/
BEGIN;
DEFINE INDEX index ON TABLE test COLUMNS number;
CREATE test:int0 SET number = 0;
CREATE test:float0 SET number = 0.5;
CREATE test:int1 SET number = 1;
CREATE test:float1 SET number = 1.5;
CREATE test:int2 SET number = 2;
RETURN "OK";
COMMIT;

SELECT * FROM test WHERE number > 0 AND number < 2 ORDER BY id;
SELECT * FROM test WHERE number > 0 AND number < 2 ORDER BY id EXPLAIN;

SELECT * FROM test WHERE number > 0.1 AND number < 2 ORDER BY id;
SELECT * FROM test WHERE number > 0.1 AND number < 2 ORDER BY id EXPLAIN;

SELECT * FROM test WHERE number > 0.1 AND number < 1.5 ORDER BY id;
SELECT * FROM test WHERE number > 0.1 AND number < 1.5 ORDER BY id EXPLAIN;

SELECT * FROM test WHERE number > 0 AND number < 1.5 ORDER BY id;
SELECT * FROM test WHERE number > 0 AND number < 1.5 ORDER BY id EXPLAIN;

SELECT * FROM test WHERE number > 0.1 ORDER BY id;
SELECT * FROM test WHERE number > 0.1 ORDER BY id EXPLAIN;

SELECT * FROM test WHERE number > 0 ORDER BY id;
SELECT * FROM test WHERE number > 0 ORDER BY id EXPLAIN;

SELECT * FROM test WHERE number < 2 ORDER BY id;
SELECT * FROM test WHERE number < 2 ORDER BY id EXPLAIN;

SELECT * FROM test WHERE number < 1.9 ORDER BY id;
SELECT * FROM test WHERE number < 1.9 ORDER BY id EXPLAIN;
