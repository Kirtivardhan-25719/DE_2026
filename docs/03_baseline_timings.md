# 03 – Baseline Timings

## Objective
To measure the execution performance of all 30 SQL queries before applying any database optimization or indexing.

## Testing Details
- Total Queries: 30
- Read Queries: 25 (R01–R25)
- Write Queries: 5 (W01–W05)
- Executions per Query: 3
- Database: PostgreSQL
- Optimization: No additional indexes applied

## Execution Timings

| Query ID | Run 1 (ms) | Run 2 (ms) | Run 3 (ms) | Average (ms) |
|---|---:|---:|---:|---:|
| R01 | | | | |
| R02 | | | | |
| R03 | | | | |
| R04 | | | | |
| R05 | | | | |
| R06 | | | | |
| R07 | | | | |
| R08 | | | | |
| R09 | | | | |
| R10 | | | | |
| R11 | | | | |
| R12 | | | | |
| R13 | | | | |
| R14 | | | | |
| R15 | | | | |
| R16 | | | | |
| R17 | | | | |
| R18 | | | | |
| R19 | | | | |
| R20 | | | | |
| R21 | | | | |
| R22 | | | | |
| R23 | | | | |
| R24 | | | | |
| R25 | | | | |
| W01 | | | | |
| W02 | | | | |
| W03 | | | | |
| W04 | | | | |
| W05 | | | | |

## Execution Plan Analysis

For each query, record:
- Execution Time
- Planning Time
- Scan Type (Sequential Scan / Index Scan / Bitmap Scan)
- Rows Returned
- Shared Buffer Hits and Reads

Use the following PostgreSQL command:

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT ...;
```

## Conclusion

The baseline timings provide a reference for comparing database performance before and after optimization. These results will be used to evaluate the impact of indexing and other database optimization techniques.
