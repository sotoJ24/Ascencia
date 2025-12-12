CREATE TABLE issues (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Foreign Key
    repo_id UUID NOT NULL REFERENCES repositories(id) ON DELETE CASCADE,
    
    -- GitHub Identity
    github_id TEXT UNIQUE NOT NULL,  -- GitHub's issue ID
    issue_number INTEGER NOT NULL,    -- Issue #123
    
    -- Issue Details
    title TEXT NOT NULL,
    description TEXT,
    url TEXT NOT NULL,
    
    -- Classification
    difficulty TEXT CHECK (difficulty IN ('easy', 'medium', 'hard')),
    tech_stack TEXT[],
    is_good_first_issue BOOLEAN DEFAULT false,
    
    -- Status
    status TEXT CHECK (status IN ('open', 'assigned', 'in_progress', 'completed', 'closed')) DEFAULT 'open',
    
    -- Assignment
    assigned_to_wallet TEXT REFERENCES profiles(wallet_address),
    assigned_at TIMESTAMP,
    
    -- Rewards
    suggested_tip_usdc DECIMAL(10, 2),  -- Maintainer's suggested tip
    actual_tip_usdc DECIMAL(10, 2),     -- Actual tip paid
    xp_reward INTEGER,                   -- XP earned
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    completed_at TIMESTAMP,
    
    -- Constraints
    UNIQUE(repo_id, issue_number)
);

CREATE INDEX idx_issues_repo ON issues(repo_id);
CREATE INDEX idx_issues_status ON issues(status);
CREATE INDEX idx_issues_assigned_to ON issues(assigned_to_wallet);
CREATE INDEX idx_issues_difficulty ON issues(difficulty);
CREATE INDEX idx_issues_good_first ON issues(is_good_first_issue) WHERE is_good_first_issue = true;