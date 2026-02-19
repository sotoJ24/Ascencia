'use client'

import { OnchainKitProvider } from '@coinbase/onchainkit'
import '@coinbase/onchainkit/styles.css'
import { baseSepolia } from 'viem/chains'
import { ReactNode } from 'react'

export function Providers({ children }: { children: ReactNode }) {
  return (
    <OnchainKitProvider
      apiKey={process.env.NEXT_PUBLIC_ONCHAINKIT_API_KEY!}
      chain={baseSepolia}
      config={{
        appearance: {
          mode: 'dark',
        },
      }}
      miniKit={{
        enabled: true,
        autoConnect: true,
      }}
    >
      {children}
    </OnchainKitProvider>
  )
}