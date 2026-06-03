# Cybersecurity Threat Analysis Pipeline: Python + PostgreSQL + Tableau
An end-to-end data engineering &amp; analytics pipeline parsing 100,000 cyber threat incident logs using Python (Pandas) for ETL, PostgreSQL for advanced querying, and Tableau for interactive dashboarding to audit SLA breaches, severity in country, KPIs and structural security anomalies.
---

![](https://img.shields.io/badge/Python-3.x-blue?style=for-the-badge&logo=python)
![](https://img.shields.io/badge/PostgreSQL-15+-blue?style=for-the-badge&logo=postgresql)
![](https://img.shields.io/badge/Tableau-Interactive-red?style=for-the-badge&logo=tableau)
![](https://img.shields.io/badge/Pandas-Data_Cleaning-orange?style=for-the-badge&logo=pandas)


## 📌 Project Overview
This project establishes a comprehensive, end-to-end data engineering and business intelligence pipeline designed to process, model, and analyze **100,000 enterprise cyber threat incident logs**. 

The lifecycle of this project showcases the complete breakdown of a modern data analyst workflow: programmatically extracting data within an isolated development environment, executing meticulous data sanitization and feature engineering via **Python (Jupyter Notebook)**, scaling ingestion into a production-ready **PostgreSQL relational database**, resolving 25 highly intricate real-world cybersecurity business challenges using advanced analytical SQL queries, and compiling those insights into an interactive **Tableau Executive Dashboard**.

---

## 🕹️ Interactive Executive Dashboard

To translate technical database tables into corporate strategy, I developed a centralized **Cyber Security Threat Analysis Dashboard**. It allows executive stakeholders to track real-time metric distributions across global perimeters, monitor SLA compliance, and identify high-risk targeting vulnerabilities instantly.

### Live Interaction Demo
<!-- Embed your animated demo GIF here -->
![Tableau Interactive Demo](https://github.com/ommoryani/Cyber_Threat_Analysis_Pipleline/blob/main/DASHBOARD.gif)

### High-Resolution Static Snapshot
<details>
<summary>🔍 Click here to expand the high-resolution dashboard snapshot</summary>

![Tableau Static Dashboard](https://github.com/ommoryani/Cyber_Threat_Analysis_Pipleline/blob/main/DASHBOARD.png)
</details>

---

## 🎯 Project Objectives
- **Isolated Infrastructure Setup:** Configure a dedicated Python virtual environment (`cta`) within Visual Studio Code to manage workspace dependencies seamlessly.
- **Programmatic Data Extraction & ETL:** Build a modular Python pipeline utilizing `zipfile` extraction and Pandas to read, profile, and normalize unstructured data logs.
- **Corporate Standard Data Cleansing:** Standardize data schemas, correct text string casings, validate numerical bounds, and enforce structural normalization rules.
- **Relational Database Engineering:** Seed a local PostgreSQL database with a structured relational schema to run highly optimized analysis queries.
- **Advanced Security Auditing:** Write and execute complex SQL operations (including Common Table Expressions (CTEs), Sliding Window Functions, and Data Type Interval Casting) to address 25 business-critical security vectors.

---

## 🛠️ Technical Architecture & Workflow Pipeline

```text
┌────────────────┐      ┌────────────────────────┐      ┌──────────────────────┐
│  Raw Data Drop │ ───> │  Python Data Cleaning  │ ───> │   Cleaned Data CSV   │
│ (archive.zip)  │      │ (Pandas & Try-Except)  │      │ (Staging/Validation) │
└────────────────┘      └────────────────────────┘      └──────────────────────┘
                                                                   │
                                                                   ▼
┌────────────────┐      ┌────────────────────────┐      ┌──────────────────────┐
│ Tableau BI KPI │ <─── │ 25 Business Solutions  │ <─── │ PostgreSQL Database  │
│  (Live Studio) │      │  (Complex SQL Queries) │      │ (security_incident)  │
└────────────────┘      └────────────────────────┘      └──────────────────────┘


```
## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Cyber Dataset](https://www.kaggle.com/datasets/mustafahabeeb90/cybersecurity-incident-dataset)
---
## 👨🏻‍💻DataBase Schema 

```text
DROP TABLE IF EXISTS security_incident_logs;

CREATE TABLE security_incident_logs
(
    "Attack Type"              VARCHAR(100),
    "Target System"            VARCHAR(100),
    "Outcome"                  VARCHAR(50),
    "Attacker IP"              VARCHAR(50),
    "Target IP"                VARCHAR(50),
    "Data Compromised (GB)"    NUMERIC(10, 2),
    "Attack Duration (Min)"    INT,
    "Security Tool Used"       VARCHAR(100),
    "User Role"                VARCHAR(100),
    "Country"                  VARCHAR(100),
    "Attack Severity Scale"    INT,
    "Industry"                 VARCHAR(100),
    "SOC Response Time (Min)"  INT,
    "Mitigation Method"        VARCHAR(100),
    "Incident Date"            DATE,
    "Incident Year"            INT,
    "Incident Month"           VARCHAR(50),
    "Incident Hour"            INT
);
```
## 🔍 Categorization & Threat Distribution

- **Geographical Vector Mapping:** Tracking incident occurrences across global perimeters isolates the physical distribution of malicious threat activity, highlighting which sovereign networks encounter the heaviest concentration of attacks.
- **Incident Categorization:** Classifying system threats based on infrastructure target layers (e.g., Active Directory, cloud storage buckets, or network endpoints) provides deep operational insights into active adversary vectors and corporate exposure risks.

This structural analysis yields an exhaustive perspective on global enterprise vulnerabilities, providing the foundational metrics required to drive corporate risk management and dictate proactive defensive tool deployment.

---

## 📈 Results and Deep Analytical Insights

This section outlines the critical macro findings uncovered by merging the programmatic Python engineering pipeline with complex PostgreSQL analytics and visual validation matrices:

- **Defensive Tooling & Outcome Friction:** The enterprise infrastructure exhibits a highly contested operational perimeter, with a total global **Breach Success Rate locked at 50.03%**. This indicates an exact equal distribution between successful network penetrations and successful tool blocks, validating the need for dynamic perimeter hardening.
- **Critical SLA Deficiencies & Leakage:** A deep audit of response timelines exposed severe operational bottlenecks—the global infrastructure experiences an **SLA Leakage Rate of 66.54%** where incident mitigations routinely breach the standard 60-minute containment threshold, pulling the average corporate SOC response time down to **90.45 minutes**.
- **Privilege Escalation & High-Value Targeting:** Cross-referencing infrastructure targets with identity access logs reveals that privilege escalation vectors attacking administrative and executive user accounts are highly clustered around corporate infrastructure shift handovers, generating disproportionately severe blast radiuses and massive data exposure rates.
- **Data Integrity & Logging Anomaly Vectors:** The Python staging phase successfully flagged severe logging anomalies—specifically, record fragments where an attack status was officially logged as a blocked "Failure," yet anomalous data metrics registered active data exposure volumes exceeding 0 GB. Isolating these rows establishes automated validation triggers for future audit cycles.

---

## 🛠️ Future Enhancements

To build upon this operational data pipeline, the following high-priority production-tier extensions are scheduled for future deployment:

- **Live Database Streaming:** Transition the visual layer from static workbook staging to an active live production connection between the local PostgreSQL server instance and Tableau, establishing real-time security operations center performance tracking.
- **Anomalous Threat Clustering (Machine Learning):** Expand the Python data pipeline using `scikit-learn` to execute unsupervised clustering algorithms (such as Isolation Forests or K-Means) on attacker IP behaviors to programmatically flag zero-day threat actors.
- **Automated ELT Pipeline Orchestration:** Move from manual Jupyter Notebook local executions to a completely automated enterprise data pipeline orchestrated via **Apache Airflow**, allowing for seamless automated data ingestion, cleaning, and database seeding whenever fresh log files are dumped.

---

## 📄 License

This project is licensed under the MIT License. Feel free to use, modify, and distribute the scripts for educational and career portfolio purposes.

---

## 👨‍💻 Author

**Om Moryani** 
*B.Tech - CSE (Internet of Things, Cybersecurity including Blockchain Technology)* REVA University, Bengaluru  

---

## 🤝 Acknowledgments

- **Data Source:** Sourced via Kaggle's Enterprise Security Incident Repository.
- **Inspiration:** Global security operations center (SOC) metric modeling, threat hunting compliance auditing, and advanced database normalization frameworks.
