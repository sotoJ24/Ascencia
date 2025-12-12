CREATE TABLE profiles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    wallet_address TEXT UNIQUE NOT NULL,  -- Ethereum address
    github_username TEXT UNIQUE,
    bio TEXT,
    avatar_url TEXT,
    
    -- Role
    role TEXT CHECK (role IN ('contributor', 'maintainer', 'both')) DEFAULT 'contributor',
    
    -- Skills & Interests
    tech_stack TEXT[],  -- ['Solidity', 'React', 'TypeScript']
    topics TEXT[],      -- ['DeFi', 'NFTs', 'AI']
    experience_level TEXT CHECK (experience_level IN ('beginner', 'intermediate', 'advanced')),
    
    -- Stats (cached from on-chain data)
    total_xp BIGINT DEFAULT 0,
    level INTEGER DEFAULT 1,
    contributions_count INTEGER DEFAULT 0,
    total_earned_usdc DECIMAL(18, 6) DEFAULT 0,
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    
    -- Constraints
    CONSTRAINT valid_wallet CHECK (wallet_address ~* '^0x[a-fA-F0-9]{40}$')
);

-- Indexes for performance
CREATE INDEX idx_profiles_wallet ON profiles(wallet_address);
CREATE INDEX idx_profiles_role ON profiles(role);
CREATE INDEX idx_profiles_tech_stack ON profiles USING GIN(tech_stack);
CREATE INDEX idx_profiles_xp ON profiles(total_xp DESC);