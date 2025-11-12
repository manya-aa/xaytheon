-- ===================================================
--  SCHEMA: Saatvik-GT Project Database
--  TABLE: contributions
--  AUTHOR: Saatvik Sawarn
--  DESCRIPTION: Stores user project contributions,
--               including metadata like tech stack,
--               program type, screenshots, etc.
-- ===================================================

-- 1️⃣ CREATE TABLE
CREATE TABLE IF NOT EXISTS contributions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    project TEXT NOT NULL,
    link TEXT,
    program TEXT,
    date DATE,
    type TEXT,
    description TEXT,
    tech TEXT,
    screenshot_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2️⃣ (OPTIONAL) FOREIGN KEY CONSTRAINT (if you have a users table)
-- Uncomment the below block if 'users' table exists
-- ALTER TABLE contributions
-- ADD CONSTRAINT fk_user
-- FOREIGN KEY (user_id)
-- REFERENCES users(id)
-- ON DELETE CASCADE;

-- 3️⃣ INSERT SAMPLE DATA
INSERT INTO contributions (
    user_id, project, link, program, date, type, description, tech, screenshot_url
) VALUES 
(
    '3b8c2f74-4d02-4e1b-bc02-ff123abc4567',
    'AI Portfolio Analyzer',
    'https://github.com/saatvik-ai/portfolio-analyzer',
    'OpenAI Hackathon',
    '2025-11-10',
    'Hackathon Project',
    'An AI-based project analysis dashboard that tracks open-source activity.',
    'Next.js, Supabase, OpenAI API',
    'https://example.com/screenshot1.png'
),
(
    '3b8c2f74-4d02-4e1b-bc02-ff123abc4567',
    'Gesture-Based Communication Tool (AirGlyph)',
    'https://github.com/saatvik-s/airglyph',
    'Personal Research',
    '2025-06-15',
    'Hardware + AI',
    'An accessibility device translating gestures into text for silent communication.',
    'Arduino, MPU6050, Python, LCD I2C',
    'https://example.com/screenshot2.png'
);

-- 4️⃣ FETCH / SELECT QUERIES

-- Get all contributions
SELECT * FROM contributions;

-- Get all contributions by a specific user
SELECT * FROM contributions
WHERE user_id = '3b8c2f74-4d02-4e1b-bc02-ff123abc4567';

-- Get recent contributions (last 30 days)
SELECT * FROM contributions
WHERE created_at >= NOW() - INTERVAL '30 days'
ORDER BY created_at DESC;

-- Get all projects that use a specific tech
SELECT project, tech
FROM contributions
WHERE tech ILIKE '%Next.js%';

-- 5️⃣ UPDATE EXISTING ENTRY

UPDATE contributions
SET description = 'Updated project description for clarity.'
WHERE id = 'a9b3c8f5-8a12-4a2d-9d25-ecfa22e87102';

-- 6️⃣ DELETE A SPECIFIC ENTRY

DELETE FROM contributions
WHERE id = 'a9b3c8f5-8a12-4a2d-9d25-ecfa22e87102';

-- 7️⃣ ANALYTICS / DASHBOARD QUERIES (Optional but Useful)

-- Total number of projects
SELECT COUNT(*) AS total_projects FROM contributions;

-- Number of projects per user
SELECT user_id, COUNT(*) AS total_contributions
FROM contributions
GROUP BY user_id
ORDER BY total_contributions DESC;

-- Most common technologies used
SELECT tech, COUNT(*) AS frequency
FROM contributions
GROUP BY tech
ORDER BY frequency DESC;

-- Contributions per month
SELECT TO_CHAR(created_at, 'YYYY-MM') AS month, COUNT(*) AS total
FROM contributions
GROUP BY month
ORDER BY month DESC;

-- Latest 5 contributions
SELECT project, type, tech, created_at
FROM contributions
ORDER BY created_at DESC
LIMIT 5;

-- ===================================================
-- END OF FILE
-- ===================================================
