/// <reference types="next" />
/// <reference types="next/image-types/global" />

// Allow CSS imports
declare module '*.css' {
  const content: Record<string, string>
  export default content
}

// Allow CSS module imports
declare module '*.module.css' {
  const classes: { readonly [key: string]: string }
  export default classes
}