CREATE TABLE applications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Foreign Keys
    contributor_wallet TEXT NOT NULL REFERENCES profiles(wallet_address) ON DELETE CASCADE,
    issue_id UUID NOT NULL REFERENCES issues(id) ON DELETE CASCADE,
    
    -- Application Data
    status TEXT CHECK (status IN ('pending', 'approved', 'rejected', 'withdrawn')) DEFAULT 'pending',
    cover_letter TEXT,
    estimated_hours INTEGER,
    
    -- Timestamps
    applied_at TIMESTAMP DEFAULT NOW(),
    reviewed_at TIMESTAMP,
    
    -- Prevent duplicate applications
    UNIQUE(contributor_wallet, issue_id)
);

CREATE INDEX idx_applications_contributor ON applications(contributor_wallet);
CREATE INDEX idx_applications_issue ON applications(issue_id);
CREATE INDEX idx_applications_status ON applications(status);
