// components/Leaderboard.tsx
'use client';

import { useState, useEffect } from 'react';
import { usePublicClient } from 'wagmi';
import { Avatar } from '@/components/ui/avatar';

type TimeRange = 'allTime' | 'monthly' | 'weekly';

export function Leaderboard() {
  const [timeRange, setTimeRange] = useState<TimeRange>('allTime');
  const [contributors, setContributors] = useState([]);
  const publicClient = usePublicClient();
  
  useEffect(() => {
    async function fetchLeaderboard() {
      // Fetch from Supabase (faster) or directly from contract
      const data = await fetch(`/api/leaderboard?range=${timeRange}`).then(r => r.json());
      setContributors(data);
    }
    fetchLeaderboard();
  }, [timeRange]);
  
  return (
    <div className="max-w-4xl mx-auto p-6">
      <h1 className="text-3xl font-bold mb-6">Overall Leaderboard</h1>
      
      <div className="flex gap-4 mb-6">
        <button
          onClick={() => setTimeRange('allTime')}
          className={timeRange === 'allTime' ? 'active' : ''}
        >
          All Time
        </button>
        <button
          onClick={() => setTimeRange('monthly')}
          className={timeRange === 'monthly' ? 'active' : ''}
        >
          Monthly
        </button>
        <button
          onClick={() => setTimeRange('weekly')}
          className={timeRange === 'weekly' ? 'active' : ''}
        >
          Weekly
        </button>
      </div>
      
      <div className="space-y-4">
        {contributors.map((contributor, index) => (
          <div
            key={contributor.address}
            className="flex items-center gap-4 p-4 bg-gray-900 rounded-lg"
          >
            <span className="text-2xl font-bold text-gray-400">#{index + 1}</span>
            <Avatar src={contributor.avatar} />
            <div className="flex-1">
              <div className="font-semibold">{contributor.username}</div>
              <div className="flex gap-3 text-sm">
                <span className="text-orange-500">
                  {contributor.xp.toLocaleString()} XP
                </span>
                <span className="text-purple-500">LVL {contributor.level}</span>
                <span className="text-yellow-500">⭐ {contributor.stars}</span>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}