/* ──────────────────────────────────────────
   Example Configuration (Extracted from content-planner-app)
   Use this to understand how defaults are structured in the Store.
   ────────────────────────────────────────── */

export const DEFAULT_SETTINGS = {
  googleClientId: 'YOUR_GOOGLE_CLIENT_ID_HERE',
  theme: 'light',
  language: 'en',
  
  // Customizable dropdown lists
  channels: [
    'TikTok', 'Shopee Video', 'YouTube Shorts', 'YouTube Long', 
    'Instagram Reels', 'Facebook Reels', 'LINE VOOM', 'X (Twitter)'
  ],
  contentPillars: [
    'Desk Productivity', 'Everyday Electronics', 'Creator Gear', 
    'EV/Solar Lifestyle', 'Windows-to-Mac'
  ],
  productCategories: [
    'Desk Productivity', 'Everyday Electronics', 'Creator Gear', 
    'EV Solar', 'Mac Accessories', 'Smartphone Accessories', 'Home Smart'
  ],
  contentTypes: [
    '🛒 Affiliate', '🎯 Personal Brand', '📚 Knowledge', '🤝 Sponsor'
  ],
  contentAngles: [
    'Selling Point', 'Pain Point', 'Comparison', 'Tutorial', 
    'Storytelling', 'Trend', 'Review', 'Unboxing', 'Setup Tour'
  ],
  contentStatuses: [
    '💡 Idea', '✍️ Scripting', '🎬 Filming', '✂️ Editing', 
    '✅ Ready', '📤 Published', '❌ Cancelled'
  ],
  productStatuses: [
    'To Review', 'Approved', 'Active', 'Paused', 'Done'
  ],
  productTypes: [
    'A สินค้าขายดี', 'B สินค้ามาใหม่', 'C สินค้าราคาประหยัด', 'D สินค้าค่าคอมสูง'
  ],
  priceRanges: [
    '< ฿500', '฿500-1,000', '฿1,000-2,000', '฿2,000-5,000', '฿5,000+'
  ],
  ctaTypes: [
    'ปักตะกร้า', 'Link in Bio', 'Follow', 'Comment', 'Save', 'DM', 'Share'
  ],
  dealTypes: [
    'Paid Review', 'Barter', 'Affiliate Boost', 'Long-term', 'Ambassador'
  ],
  paymentStatuses: [
    'Pending', 'Invoiced', 'Paid', 'Cancelled'
  ],
};

// Brand Identity specific structure
export const DEFAULT_BRAND = {
  creatorName: '',
  handles: '',
  tagline: '',
  profilePhotoUrl: '',
  pillars: [
    { name: 'Desk Productivity', desc: 'อุปกรณ์จัดโต๊ะ, USB-C hub, monitor arm' },
    { name: 'Everyday Electronics', desc: 'power bank, GaN charger, smart plug' },
  ],
  colors: [
    { name: 'Primary', hex: '#6366F1' },
    { name: 'Secondary', hex: '#1E293B' },
    { name: 'Accent', hex: '#F97316' },
  ],
  tone: '',
  style: '',
  dos: '',
  donts: '',
  audiences: [],
  channelLinks: [],
  stats: { totalFollowers: '', avgViews: '', avgEngagement: '', totalVideos: '', topCategory: '' },
  rateCard: [],
  portfolio: [],
};

// Default images for sample data fallback
export const DEFAULT_PRODUCT_IMAGES = {
  P001: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3',
  P002: 'https://images.unsplash.com/photo-1589923188900-85dae523342b',
};

// Initial store state template
export const INITIAL_DATA = {
  settings: { ...DEFAULT_SETTINGS },
  products: [],
  content: [],
  channelTracker: [],
  sponsors: [],
  deletedItems: [],
  brand: { ...DEFAULT_BRAND },
};
