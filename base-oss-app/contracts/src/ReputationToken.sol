// XP-Points as on-chain proof

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ReputationToken {
    struct Contributor {
        uint256 totalXP;
        uint256 level;
        uint256 contributionsCount;
        uint256 totalEarned; // Track total USDC earned
        uint256 lastContributionTime;
    }
    
    mapping(address => Contributor) public contributors;
    mapping(address => mapping(uint256 => uint256)) public monthlyXP; // address => month => xp
    mapping(address => mapping(uint256 => uint256)) public weeklyXP;  // address => week => xp
    
    address public admin;
    
    event ContributionRecorded(
        address indexed contributor,
        uint256 xpEarned,
        uint256 tipAmount,
        uint256 newLevel,
        uint256 timestamp
    );
    
    event LevelUp(address indexed contributor, uint256 newLevel);
    
    constructor() {
        admin = msg.sender;
    }
    
    // Called by your backend after x402 payment confirmed
    function recordContribution(
        address contributor,
        uint256 xpAmount,
        uint256 tipAmount
    ) external {
        require(msg.sender == admin, "Only admin");
        
        Contributor storage c = contributors[contributor];
        c.totalXP += xpAmount;
        c.contributionsCount++;
        c.totalEarned += tipAmount;
        c.lastContributionTime = block.timestamp;
        
        // Update time-based stats
        uint256 currentMonth = block.timestamp / 30 days;
        uint256 currentWeek = block.timestamp / 7 days;
        monthlyXP[contributor][currentMonth] += xpAmount;
        weeklyXP[contributor][currentWeek] += xpAmount;
        
        // Calculate level (example: level = sqrt(totalXP / 100))
        uint256 newLevel = calculateLevel(c.totalXP);
        if (newLevel > c.level) {
            c.level = newLevel;
            emit LevelUp(contributor, newLevel);
        }
        
        emit ContributionRecorded(
            contributor,
            xpAmount,
            tipAmount,
            c.level,
            block.timestamp
        );
    }
    
    function calculateLevel(uint256 xp) public pure returns (uint256) {
        // Simple formula: level = XP / 100 (adjust as needed)
        return xp / 100;
    }
    
    // View functions for leaderboard
    function getContributor(address addr) external view returns (Contributor memory) {
        return contributors[addr];
    }
    
    function getMonthlyXP(address addr) external view returns (uint256) {
        uint256 currentMonth = block.timestamp / 30 days;
        return monthlyXP[addr][currentMonth];
    }
    
    function getWeeklyXP(address addr) external view returns (uint256) {
        uint256 currentWeek = block.timestamp / 7 days;
        return weeklyXP[addr][currentWeek];
    }
}