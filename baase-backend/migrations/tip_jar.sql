CREATE TABLE tips (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Foreign Keys (the many-to-many relationship)
    from_wallet TEXT NOT NULL REFERENCES profiles(wallet_address),  -- Maintainer
    to_wallet TEXT NOT NULL REFERENCES profiles(wallet_address),    -- Contributor
    issue_id UUID NOT NULL REFERENCES issues(id),
    
    -- Payment Details
    amount_usdc DECIMAL(18, 6) NOT NULL,  -- USDC amount (6 decimals)
    xp_earned INTEGER NOT NULL,            -- XP awarded
    
    -- Blockchain Data
    tx_hash TEXT UNIQUE NOT NULL,          -- Base transaction hash
    block_number BIGINT,
    network TEXT DEFAULT 'base-sepolia',
    
    -- x402 Payment Data
    x402_payment_id TEXT,
    x402_settlement_status TEXT,
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT NOW(),
    settled_at TIMESTAMP,
    
    -- Constraints
    CHECK (amount_usdc > 0),
    CHECK (xp_earned > 0),
    CHECK (from_wallet != to_wallet)  -- Can't tip yourself
);

CREATE INDEX idx_tips_to_wallet ON tips(to_wallet);
CREATE INDEX idx_tips_from_wallet ON tips(from_wallet);
CREATE INDEX idx_tips_issue ON tips(issue_id);
CREATE INDEX idx_tips_tx_hash ON tips(tx_hash);
CREATE INDEX idx_tips_created_at ON tips(created_at DESC);
