CREATE TABLE repositories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Foreign Key
    project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    
    -- Repository Identity
    github_owner TEXT NOT NULL,  -- 'coinbase'
    github_repo TEXT NOT NULL,   -- 'agentkit'
    github_id TEXT UNIQUE,       -- GitHub's internal ID
    full_name TEXT UNIQUE NOT NULL,  -- 'coinbase/agentkit'
    
    -- Repository Details
    description TEXT,
    stars INTEGER DEFAULT 0,
    forks INTEGER DEFAULT 0,
    open_issues_count INTEGER DEFAULT 0,
    
    -- Maintainer
    maintainer_wallet TEXT NOT NULL REFERENCES profiles(wallet_address),
    
    -- Status
    is_active BOOLEAN DEFAULT true,
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    last_synced_at TIMESTAMP,  -- Last GitHub sync
    
    -- Constraints
    UNIQUE(github_owner, github_repo)
);

CREATE INDEX idx_repos_project ON repositories(project_id);
CREATE INDEX idx_repos_maintainer ON repositories(maintainer_wallet);
CREATE INDEX idx_repos_full_name ON repositories(full_name);