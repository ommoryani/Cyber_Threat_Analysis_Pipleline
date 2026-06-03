select * from security_incident_logs;

--SOLUTION 1--
SELECT 
    "Industry",
    COUNT(*) AS total_successful_attacks,
    AVG("SOC Response Time (Min)") AS avg_response_time,
    SUM("Data Compromised (GB)") AS total_data_compromised
FROM security_incident_logs
WHERE "Outcome" = 'Success'
GROUP BY "Industry"
ORDER BY total_successful_attacks DESC
LIMIT 1;

--SOLUTION 2--
WITH YearlyCounts AS (
    SELECT "Incident Year", COUNT(*) AS total_attacks
    FROM security_incident_logs
    GROUP BY "Incident Year"
)
SELECT 
    (SELECT "Incident Year" FROM YearlyCounts ORDER BY total_attacks DESC LIMIT 1) AS highest_volume_year,
    (SELECT "Incident Year" FROM YearlyCounts ORDER BY total_attacks ASC LIMIT 1) AS lowest_volume_year;

--SOLUTION 3--
SELECT "Country", COUNT(*) AS total_attacks
FROM security_incident_logs
WHERE "Incident Year" >= 2020
GROUP BY "Country"
ORDER BY total_attacks ASC
LIMIT 1;

--SOLUTION 4--
SELECT *
FROM security_incident_logs
WHERE "Country" = 'Uk'
ORDER BY "Attack Severity Scale" DESC
LIMIT 1 OFFSET 1;

--SOLUTION 5--
SELECT *
FROM security_incident_logs
WHERE "Incident Year" = 2023
ORDER BY ("Attack Severity Scale" * "Attack Duration (Min)" * "Data Compromised (GB)") DESC
LIMIT 1;

--SOLUTION 6--
SELECT "Incident Month", COUNT(*) AS blocked_activity
FROM security_incident_logs
WHERE "Incident Year" = 2023 
  AND "Outcome" = 'Failure'
GROUP BY "Incident Month"
ORDER BY blocked_activity ASC
LIMIT 1;

--SOLUTION 7--
SELECT "Incident Month", "Incident Hour"
FROM security_incident_logs
WHERE "Country" = 'Usa'
  AND "Attack Severity Scale" >= 8 
  AND "Data Compromised (GB)" > 50 
  AND ("Incident Hour" + ("Attack Duration (Min)" / 60.0)) < 24
ORDER BY "Attack Severity Scale" DESC
LIMIT 1;

--SOLUTION 8--
SELECT 
    "Security Tool Used", 
    "Mitigation Method", 
    COUNT(*) AS breach_count,
    SUM("Data Compromised (GB)") AS financial_exposure_proxy
FROM security_incident_logs
WHERE "Outcome" = 'Success' AND "SOC Response Time (Min)" > 60
GROUP BY "Security Tool Used", "Mitigation Method"
ORDER BY financial_exposure_proxy DESC;

--SOLUTION 9--
SELECT 
    "Attack Type", 
    COUNT(*) AS catastrophic_incidents,
    SUM("Data Compromised (GB)") AS total_data_loss
FROM security_incident_logs
WHERE "Attack Duration (Min)" > 120 AND "SOC Response Time (Min)" > 60
GROUP BY "Attack Type"
ORDER BY total_data_loss DESC;

--SOLUTION 10--
SELECT 
    AVG(CASE WHEN "SOC Response Time (Min)" <= 60 THEN "Data Compromised (GB)" END) AS avg_data_loss_sla_met,
    AVG(CASE WHEN "SOC Response Time (Min)" > 60 THEN "Data Compromised (GB)" END) AS avg_data_loss_sla_breached,
    (AVG(CASE WHEN "SOC Response Time (Min)" > 60 THEN "Data Compromised (GB)" END) - 
     AVG(CASE WHEN "SOC Response Time (Min)" <= 60 THEN "Data Compromised (GB)" END)) AS exact_difference
FROM security_incident_logs
WHERE "Outcome" = 'Success';

--SOLUTION 11--
WITH SafestCountry AS (
    SELECT "Country" 
    FROM security_incident_logs 
    WHERE "Incident Year" >= 2020 
    GROUP BY "Country" ORDER BY COUNT(*) ASC LIMIT 1
)
SELECT 
    COUNT(CASE WHEN "SOC Response Time (Min)" <= 60 THEN 1 END) * 100.0 / COUNT(*) AS sla_compliance_rate,
    COUNT(CASE WHEN "SOC Response Time (Min)" > 60 THEN 1 END) * 100.0 / COUNT(*) AS sla_breach_rate
FROM security_incident_logs
WHERE "Country" = (SELECT "Country" FROM SafestCountry);

--SOLUTION 12--
SELECT 
    "Incident Hour",
    AVG("SOC Response Time (Min)") AS avg_soc_response,
    COUNT(CASE WHEN "SOC Response Time (Min)" > 60 THEN 1 END) AS sla_breaches
FROM security_incident_logs
WHERE "User Role" IN ('Admin', 'Executive')
GROUP BY "Incident Hour"
ORDER BY sla_breaches DESC;

--SOLUTION 13--
SELECT 
    "User Role", 
    COUNT(*) AS slow_response_incidents
FROM security_incident_logs
WHERE "Incident Year" = 2023
  AND "Attack Duration (Min)" >= 250 
GROUP BY "User Role"
ORDER BY slow_response_incidents DESC;

--SOLUTION 14--
SELECT 
    CASE 
        WHEN "Attack Duration (Min)" < 50 THEN 'Quick'
        WHEN "Attack Duration (Min)" >= 50 AND "Attack Duration (Min)" < 150 THEN 'Normal'
        WHEN "Attack Duration (Min)" >= 150 AND "Attack Duration (Min)" < 250 THEN 'Slow'
        ELSE 'Need Action'
    END AS operational_speed_zone,
    COUNT(*) AS attack_count
FROM security_incident_logs
WHERE "Incident Year" = 2023
GROUP BY operational_speed_zone;

--SOLUTION 15--
SELECT "Industry", "Incident Month"
FROM security_incident_logs
WHERE "Attack Severity Scale" = 10 AND "Data Compromised (GB)" > 50 AND "Attack Duration (Min)" < 50
ORDER BY "Data Compromised (GB)" DESC
LIMIT 1;

--SOLUTION 16--
SELECT "Attack Type", COUNT(*) AS false_alarm_volume
FROM security_incident_logs
WHERE "Attack Severity Scale" <= 3 AND "Data Compromised (GB)" = 0 AND "SOC Response Time (Min)" > 60
GROUP BY "Attack Type"
ORDER BY false_alarm_volume DESC
LIMIT 1;

--SOLUTION 17--
WITH FailedTools AS (
    SELECT "Security Tool Used", COUNT(*) AS failure_count
    FROM security_incident_logs
    WHERE "Country" = 'Usa' AND "Incident Year" = 2023 AND "Outcome" = 'Success'
    GROUP BY "Security Tool Used"
    ORDER BY failure_count DESC LIMIT 1
)
SELECT "Target System", COUNT(*) AS damage_count
FROM security_incident_logs
WHERE "Security Tool Used" = (SELECT "Security Tool Used" FROM FailedTools)
GROUP BY "Target System"
ORDER BY damage_count DESC;

--SOLUTION 18--
SELECT 
    "Mitigation Method", 
    COUNT(*) AS frequency,
    AVG("SOC Response Time (Min)") AS avg_response_time
FROM security_incident_logs
WHERE "Country" = 'Usa' AND "Attack Severity Scale" >= 8
GROUP BY "Mitigation Method";

--SOLUTION 19--
SELECT "Target System", "Attack Type", COUNT(*) AS breach_frequency
FROM security_incident_logs
WHERE "Country" = 'Usa' AND "Outcome" = 'Success' AND "SOC Response Time (Min)" > 60
GROUP BY "Target System", "Attack Type"
ORDER BY breach_frequency DESC
LIMIT 1;

--SOLUTION 20--
SELECT 
    "Country", 
    COUNT(*) AS total_incidents
FROM security_incident_logs
GROUP BY "Country"
HAVING MAX("Attack Duration (Min)") < 20
ORDER BY total_incidents ASC
LIMIT 1;

--SOLUTION 21--
SELECT 
    "Target System", 
    "Security Tool Used", 
    "Mitigation Method", 
    COUNT(*) AS tactic_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS usage_percentage
FROM security_incident_logs
WHERE "Country" = (
    -- Dynamically grabs the elite country from Problem 20
    SELECT "Country" 
    FROM security_incident_logs 
    GROUP BY "Country" 
    HAVING MAX("Attack Duration (Min)") < 50 
    ORDER BY COUNT(*) ASC 
    LIMIT 1
)
GROUP BY "Target System", "Security Tool Used", "Mitigation Method"
ORDER BY tactic_count DESC;

--SOLUTION 22--
SELECT *
FROM security_incident_logs
WHERE "Outcome" = 'Failure' AND ("Data Compromised (GB)" > 0 OR "Attack Duration (Min)" > 0);

--SOLUTION 23--
SELECT "Attacker IP", "Target System", 
       MIN("Incident Date"::DATE) AS first_attack, 
       MAX("Incident Date"::DATE) AS last_attack
FROM security_incident_logs
WHERE "Attack Severity Scale" <= 3 AND "Attack Duration (Min)" < 30
GROUP BY "Attacker IP", "Target System"
HAVING MAX("Incident Date"::DATE) - MIN("Incident Date"::DATE) > 14;

--SOLUTION 24--
WITH SuccessfulAttacks AS (
    -- Step 1: Synthesize a proper timestamp and filter only successful breaches
    SELECT 
        "Country", 
        "Target System", 
        "Attack Severity Scale", 
        ("Incident Date"::TIMESTAMP + ("Incident Hour"::text)::INTERVAL) AS exact_timestamp
    FROM security_incident_logs
    WHERE "Outcome" = 'Success'
)
-- Step 2: Join the table to itself to look for attacks that follow an initial breach
SELECT 
    initial."Country",
    initial.exact_timestamp AS chain_reaction_start_time,
    initial."Target System" AS initial_critical_system,
    COUNT(subsequent."Target System") AS total_subsequent_attacks,
    COUNT(DISTINCT subsequent."Target System") AS unique_systems_compromised
FROM SuccessfulAttacks initial
JOIN SuccessfulAttacks subsequent
    ON initial."Country" = subsequent."Country"
    
    -- Look strictly forward in time for the chain reaction (subsequent attacks)
    AND subsequent.exact_timestamp > initial.exact_timestamp
    
    -- Lock it inside the tight 6-hour burst window
    AND subsequent.exact_timestamp <= initial.exact_timestamp + INTERVAL '6 hours'
    
    -- Ensure the subsequent attacks hit DIFFERENT systems than the initial one
    AND subsequent."Target System" != initial."Target System"

-- Step 3: Set the conditions for the "Catastrophic" trigger
WHERE initial."Attack Severity Scale" = 10
GROUP BY 
    initial."Country",
    initial.exact_timestamp,
    initial."Target System"

-- Step 4: Ensure at least 3 distinct systems were hit in that window
HAVING COUNT(DISTINCT subsequent."Target System") >= 3
ORDER BY chain_reaction_start_time DESC;
--SOLUTION 25--
WITH SyntheticLogs AS (
    SELECT 
        "SOC Response Time (Min)",
        CASE 
            WHEN "Incident Hour" < 8 THEN 'Night Shift'
            WHEN "Incident Hour" < 16 THEN 'Day Shift'
            ELSE 'Evening Shift' 
        END AS derived_engineer_shift,
        ("Incident Date"::TIMESTAMP + ("Incident Hour"::text)::INTERVAL) AS exact_timestamp
    FROM security_incident_logs
)
SELECT 
    exact_timestamp, 
    derived_engineer_shift, 
    COUNT(*) OVER (ORDER BY exact_timestamp RANGE BETWEEN '48 hours' PRECEDING AND CURRENT ROW) AS volume_48h,
    AVG("SOC Response Time (Min)") OVER (
        PARTITION BY derived_engineer_shift 
        ORDER BY exact_timestamp 
        RANGE BETWEEN '7 days' PRECEDING AND CURRENT ROW
    ) AS rolling_7day_avg_response
FROM SyntheticLogs;