## 📊 Spark Data Profiling Engine

A **production-grade, generic data profiling engine built with Apache Spark** to automatically analyze **any CSV dataset** at scale.

This project focuses on **data quality, distribution analysis, cardinality, and skew detection**, helping data engineers identify performance risks (e.g., join skew, hot keys) and data issues **before pipelines break in production**.

---

## 🚀 Features

### 🔹 Schema & Type Inference

* Reads raw CSV safely with **all columns as strings**
* Automatically detects:

  * Numeric columns
  * Categorical columns
* Robust against dirty or inconsistent data

### 🔹 Data Quality Metrics

* Null count and null percentage
* Approximate distinct count (scalable)
* Cardinality ratio (low / medium / high)
* Quality flags:

  * `HIGH_NULLS`
  * `LOW_VARIANCE`
  * `SKEW_RISK`
  * `OK`

### 🔹 Statistical Profiling (Numeric Columns)

* Min, Max, Mean, Stddev
* Approximate percentiles:

  * P01, P25, P50, P75, P99
* Outlier risk detection (no expensive full scans)

### 🔹 Advanced Skew Detection (Senior-Level)

**Two independent skew strategies:**

#### 1️⃣ Numeric Distribution Skew

* Detects:

  * `RIGHT_SKEWED`
  * `LEFT_SKEWED`
  * `SYMMETRIC`
* Uses percentile-based logic (robust to outliers)

#### 2️⃣ Categorical Hot-Key Skew

* Identifies dominant values using dominance ratio
* Flags:

  * `HOT_KEY_RISK`
  * `HIGH_SKEW`
  * `BALANCED`
* Prevents Spark join & shuffle bottlenecks

### 🔹 Performance-Aware Design

* Single-pass aggregations
* Uses `approx_count_distinct` and `approxQuantile`
* Avoids per-column scans
* Stack-based categorical frequency computation
* Cache used intentionally (not blindly)

---

## 🛠 Tech Stack

* Apache Spark (PySpark)
* Spark SQL
* Jupyter Notebook (development)
* Python

---

## 📌 Example Output Columns

| Column              | Description                        |
| ------------------- | ---------------------------------- |
| `null_pct`          | Percentage of null or empty values |
| `distinct_count`    | Approximate unique values          |
| `cardinality_level` | low / mid / high                   |
| `skew_score`        | Numeric or dominance-based skew    |
| `skew_label`        | RIGHT_SKEWED / HOT_KEY_RISK etc    |
| `quality_flag`      | Data quality assessment            |

---

## 🧠 Why This Project Matters

In real-world data platforms:

* Skewed data causes **slow Spark jobs**
* Hot keys break joins
* Dirty CSVs cause silent failures

This engine helps detect these issues **early**, before they reach production.

---

## ▶️ How to Run

```python
spark-submit profiling/spark_data_profiler.py
```

Or run interactively in Jupyter for exploration.

---

## 📈 Future Enhancements

* Partition recommendation engine
* Join skew mitigation suggestions
* Parquet / Delta support
* Integration with AWS Glue / Databricks
* Export profiling results to JSON / Data Catalog


Just say the word.
