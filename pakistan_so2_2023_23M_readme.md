# 🛰️ Pakistan SO2 Satellite Telemetry & BI Pipeline

> **Local Data Engineering & Business Intelligence on Constrained Hardware (23.89 Million Records)**

![GitHub R Version](https://img.shields.io/badge/R-%3E%3D_4.6.1-blue?logo=R&logoColor=white)
![Data Size](https://img.shields.io/badge/Dataset-23.89M_Rows-orange)
![Memory Footprint](https://img.shields.io/badge/RAM_Usage-988_MiB-success)
![Hardware](https://img.shields.io/badge/Hardware-Intel_Core_i3_1.2GHz_|_4GB_RAM-red)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 📌 Executive Summary
This project demonstrates high-level data engineering mastery by building an end-to-end, high-performance geospatial data pipeline and Tableau Public dashboard entirely on **resource-constrained local hardware** (~2.0 GB Windows 10 OS overhead on 4GB RAM, zero cloud infrastructure). 

Processing over **23.89 million raw satellite telemetry records** for Pakistan's sulfur dioxide ($\text{SO}_2$) column density, the pipeline successfully filters, cleans, aggregates, and visualizes environmental metrics without triggering Out-Of-Memory (OOM) crashes.

---

## 💻 Hardware Constraints & Architecture
* **Processor:** Intel Core i3 (1.2 GHz, Dual-Core)
* **Total Physical RAM:** 4.0 GB (~2.0 GB occupied by Windows 10 OS baseline overhead)
* **Execution Model:** 100% Local / Offline (No cloud infrastructure or remote compute clusters)
* **Active R Footprint:** $\le$ 988 MiB (Optimized via early filtering, precise type casting, and garbage collection)

---

## 🔄 System Architecture & Data Flow

```text
[ Raw CSV: 23.89M Rows ] 
       │
       ▼ (read_csv & distinct deduplication)
[ Quality Filter: so2_quality >= 1 & !is.na() ]
       │
       ▼ (mutate & type casting: double precision & integers)
[ R Aggregation: group_by(day, month) & summarise ]
       │
       ▼ (Export: pak_so2_23M_2023_data.csv)
[ Tableau Public BI Dashboard ] ➔ [ Interactive Geospatial Insights ]
```

---

## 📂 Repository Structure
```text
├── pak_so2_2023_23M_data_script.R     # Main Tidyverse ETL & aggregation script
├── pak_so2_23M_2023_data.csv          # Compressed daily aggregated output (365 rows)
├── pak_so2_2023_23M_record_data_dashboard.twbx # Tableau Public packaged dashboard
├── pak_so2_23M_2023.png               # Live RStudio console & global environment proof
└── README.md                          # Project documentation
```

---

## 🛠️ R Tidyverse ETL Pipeline Code
Here is the core memory-efficient pipeline script used to process the 23.89M record dataset:

```r
library(tidyverse)
library(readr)

# 1. Ingest raw CSV data locally
data_raw <- read_csv(file.choose())

# 2. Memory-optimized ETL pipeline
final_so2_imission_23m_record_2023_data <- data_raw %>% 
  distinct() %>%
  mutate(
    so2_column = as.numeric(so2_column),
    month      = as.integer(month),
    day        = as.integer(day)
  ) %>% 
  filter( 
    !is.na(latitude),
    !is.na(longitude),
    !is.na(so2_column),
    so2_quality >= 1
  ) %>% 
  group_by(day, month) %>%
  summarise(
    Avg_so2       = mean(so2_column, na.rm = TRUE),
    Total_Records = n(),
    .groups       = 'drop'
  ) %>% 
  arrange(desc(Total_Records))

# 3. Export aggregated results for Tableau
write.csv(final_so2_imission_23m_record_2023_data, 
          'pak_so2_23M_2023_data.csv', 
          row.names = FALSE)
```

---

## 📊 Key Telemetry & Dashboard Metrics
* **Total Processed Records:** 23,892,452 observations across Pakistan spatial grid.
* **Peak Daily Observation Volume:** **83,191 passes** (September 01).
* **Peak Daily $\text{SO}_2$ Concentration:** **$4.58 \times 10^{-19}$** (September 11 density spike).
* **Compression Efficiency:** Reduced 23.89 million raw rows down to **365 clean daily summary records** for instant Tableau rendering.

---

## 🚀 How to Run Locally
1. Clone or download this repository.
2. Ensure you have **R** ($\ge$ 4.6.1) and **RStudio** installed along with the `tidyverse` package.
3. Open `pak_so2_2023_23M_data_script.R`.
4. Run the script and select your local `so2` satellite CSV file when prompted.
5. Import the generated `pak_so2_23M_2023_data.csv` into Tableau Public to explore the interactive visual dashboard.

---

## 👤 Author & Professional Links
* **Name:** Niaz Mohammad Shoyab
* **Role:** Satellite Telemetry Analyst & Business Intelligence Developer
* **LinkedIn:** [www.linkedin.com/in/niaz-shoyab-495061b8](https://www.linkedin.com/in/niaz-shoyab-495061b8)
* **GitHub:** [github.com/talkmridul-bit](https://github.com/talkmridul-bit)
* **Tableau Public:** [public.tableau.com/app/profile/niaz.mohammad.shoyab](https://public.tableau.com/app/profile/niaz.mohammad.shoyab)
* **Email:** talkmridul@gmail.com