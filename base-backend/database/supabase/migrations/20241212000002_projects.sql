CREATE TABLE projects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Project Identity
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,  -- URL-friendly: 'agentkit', 'onchainkit'
    description TEXT,
    website_url TEXT,
    logo_url TEXT,
    
    -- Project Details
    category TEXT,  -- 'Infrastructure', 'DeFi', 'NFT', 'AI'
    tech_stack TEXT[],
    topics TEXT[],
    
    -- Status
    is_active BOOLEAN DEFAULT true,
    is_featured BOOLEAN DEFAULT false,  -- Highlight on homepage
    
    -- Maintainer Info (optional, if not repo-specific)
    primary_maintainer_wallet TEXT REFERENCES profiles(wallet_address),
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_projects_slug ON projects(slug);
CREATE INDEX idx_projects_active ON projects(is_active);
CREATE INDEX idx_projects_featured ON projects(is_featured);