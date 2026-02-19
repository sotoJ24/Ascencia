'use client'

import { useEffect } from 'react'
import { useMiniKit } from '@coinbase/onchainkit/minikit'
import { supabase } from '@/lib/supabase'

// Ascencia Logo Component
function AscenciaLogo({ size = 32 }: { size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 100 100" fill="none">
      <circle cx="50" cy="50" r="42" stroke="#22D3EE" strokeWidth="1.5"
        strokeDasharray="4 2" opacity="0.6" />
      <polygon points="50,18 82,72 18,72" stroke="#22D3EE" strokeWidth="1.5" fill="none" />
      <circle cx="50" cy="18" r="3.5" fill="#22D3EE" />
      <circle cx="82" cy="72" r="3.5" fill="#22D3EE" />
      <circle cx="18" cy="72" r="3.5" fill="#22D3EE" />
      <circle cx="50" cy="54" r="5" fill="#22D3EE" opacity="0.9" />
      <circle cx="50" cy="54" r="9" fill="#22D3EE" opacity="0.2" />
      <circle cx="10" cy="44" r="3" fill="#22D3EE" opacity="0.7" />
    </svg>
  )
}

export default function HomePage() {
  const { setFrameReady, isFrameReady, context } = useMiniKit()

  // Signal frame is ready
  useEffect(() => {
    if (!isFrameReady) {
      setFrameReady()
    }
  }, [setFrameReady, isFrameReady])

  // Example: Load issues from Supabase
  useEffect(() => {
    async function loadIssues() {
      const { data } = await supabase
        .from('issues')
        .select('*')
        .limit(3)
      
      console.log('Issues:', data)
    }
    loadIssues()
  }, [])

  return (
    <div className="frame-container min-h-screen bg-black text-white p-4">
      {/* Header */}
      <div className="flex items-center gap-3 mb-6">
        <AscenciaLogo size={32} />
        <h1 className="text-xl font-bold text-ascencia tracking-widest uppercase">
          Ascencia
        </h1>
      </div>

      {/* User Info */}
      {context?.user?.fid && (
        <p className="text-sm text-white/60 mb-6">
          FID: {context.user.fid}
        </p>
      )}

      {/* Content */}
      <div className="space-y-4">
        <div className="p-4 border border-ascencia bg-ascencia">
          <h2 className="text-lg font-bold text-ascencia mb-2">
            Browse Issues
          </h2>
          <p className="text-white/70 text-sm">
            Find issues that match your skills and contribute to Base ecosystem projects.
          </p>
        </div>

        <div className="p-4 border border-ascencia bg-ascencia">
          <h2 className="text-lg font-bold text-ascencia mb-2">
            Earn Rewards
          </h2>
          <p className="text-white/70 text-sm">
            Complete issues and earn USDC tips via Proof of Cycle.
          </p>
        </div>
      </div>

      {/* Footer */}
      <div className="mt-8 pt-4 border-t border-ascencia text-center">
        <p className="text-xs text-white/30 tracking-widest uppercase">
          Powered by Base · MiniKit
        </p>
      </div>
    </div>
  )
}