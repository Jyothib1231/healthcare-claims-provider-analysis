-- Total claims and approval rate
SELECT 
    COUNT(*) AS total_claims,
    SUM(CASE WHEN claim_status = 'Approved' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) 
        AS approval_rate
FROM claims_data;

-- Monthly claim trends
SELECT 
    strftime('%Y-%m', service_date) AS month,
    COUNT(*) AS total_claims,
    AVG(claim_amount) AS avg_claim_amount
FROM claims_data
GROUP BY month
ORDER BY month;

-- Provider performance metrics
SELECT
    provider_id,
    COUNT(*) AS total_claims,
    AVG(claim_amount) AS avg_claim_amount,
    SUM(CASE WHEN claim_status = 'Approved' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) 
        AS approval_rate,
    AVG(processing_days) AS avg_processing_days
FROM claims_data
GROUP BY provider_id
HAVING COUNT(*) > 30
ORDER BY approval_rate DESC;

