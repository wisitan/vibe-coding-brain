---
name: remotion-creator
description: >-
  Create, edit, and automate short-form programmatic videos (TikTok, YouTube Shorts, Reels) using Remotion.
  Handles footage transcription (word-level captions), kinetic typography, TikTok-style animated subtitles,
  motion graphics, preview server, and high-quality MP4 rendering.
  Trigger with "/remotion", "remotion", "create video", "edit video", or when working with programmatic video editing.
---

# Remotion Video Creator Skill

This skill guides the AI assistant ("Sunday") in programmatically editing and producing high-converting short-form videos (TikTok, YouTube Shorts, Instagram Reels) using **Remotion** (React-based programmatic video framework).

---

## 🎯 Core Capabilities & Use Cases
1. **Talking Head Footage Enhancement**: Add dynamic captions, sound effects, B-roll, and zoom cuts to raw footage.
2. **TikTok / Hormozi-Style Captions**: Word-by-word active highlighting with pop/bounce spring animations.
3. **Motion Graphic Overlays**: Progress bars, callouts, emojis, badges, and lower thirds.
4. **Safe-Zone Compliance**: Keep critical visual elements within TikTok/Reels UI safe zones.
5. **Fast Local Preview & Rendering**: Instant web browser preview via Remotion Studio and optimized MP4 export.

---

## 📐 Project Structure & Standards

A standard Remotion video project created by this skill follows this architecture:

```
my-video-project/
├── public/                     # Static media assets
│   ├── footage.mp4             # Raw source footage
│   ├── audio.wav               # Extracted high-quality audio
│   ├── captions.json           # Word-level timestamps from Whisper/Transcriber
│   └── sfx/                    # Sound effects (whoosh, pop, ding)
├── src/
│   ├── index.ts                # Remotion entry point
│   ├── Root.tsx                # Composition declarations (dimensions, fps, duration)
│   ├── VideoComposition.tsx    # Master video timeline (Sequences, Audio, Overlays)
│   ├── components/
│   │   ├── HormoziCaptions.tsx  # Dynamic word-by-word highlighted captions
│   │   ├── ProgressBar.tsx     # Animated top/bottom video completion bar
│   │   ├── CalloutBadge.tsx    # Spring bounce emoji / text callouts
│   │   └── KineticWord.tsx     # Single word spring scale animator
│   ├── types.ts                # Caption and schema types
│   └── styles/
│       └── global.css          # Tailwind or custom CSS
├── package.json
└── remotion.config.ts          # Remotion bundle and render settings
```

### Video Standard Settings (9:16 Vertical Video)
* **Width**: 1080 px
* **Height**: 1920 px
* **Frame Rate (FPS)**: 30 fps (or 60 fps for ultra-smooth motion graphics)
* **Duration in Frames**: `Math.round(durationInSeconds * fps)`

---

## 🛡️ TikTok / Reels / Shorts Safe Zones
Always position text and important graphics inside the **Safe Zone**:
* **Top Margin**: >= 200px (avoid header / search bar / notch)
* **Bottom Margin**: >= 450px (avoid TikTok caption, username, sound title, navigation bar)
* **Right Margin**: >= 160px (avoid Like, Comment, Bookmark, Share icons)
* **Left Margin**: >= 60px

**Recommended Subtitle Position**: Centered horizontally (`width: 100%`, `text-align: center`), placed between `top: 55%` and `top: 70%` of the screen height.

---

## 🚀 Step-by-Step Production Workflow

### Step 1: Initialize Project (If not already present)
If starting from scratch:
```bash
npx create-video@latest --blank
# or install into an existing React project:
npm install remotion @remotion/cli @remotion/player @remotion/media-utils
```

### Step 2: Ingest Footage & Extract Audio
When the user provides a raw footage file (`footage.mp4`), move/copy it to `public/footage.mp4`, then extract the audio for transcription:
```bash
ffmpeg -i public/footage.mp4 -vn -acodec pcm_s16le -ar 16000 -ac 1 public/audio.wav -y
```

### Step 3: Transcription with Word-Level Timestamps
Generate `public/captions.json` with word-by-word start and end times in milliseconds or seconds:
```json
[
  { "text": "สวัสดีครับ", "start": 0.25, "end": 0.85 },
  { "text": "ทุกคน", "start": 0.90, "end": 1.20 },
  { "text": "วันนี้", "start": 1.30, "end": 1.65 },
  { "text": "เราจะมาดู", "start": 1.70, "end": 2.10 }
]
```
*(Can be generated via OpenAI Whisper, whisper.cpp, Google Gemini audio prompt, or Python faster-whisper).*

### Step 4: Write Remotion Compositions & Components

#### 1. Master Composition (`src/VideoComposition.tsx`)
```tsx
import { AbsoluteFill, Video, Audio, staticFile, useVideoConfig } from 'remotion';
import { HormoziCaptions } from './components/HormoziCaptions';
import { ProgressBar } from './components/ProgressBar';
import captionsData from '../public/captions.json';

export const VideoComposition = () => {
  const { fps } = useVideoConfig();

  return (
    <AbsoluteFill style={{ backgroundColor: '#000000' }}>
      {/* 1. Base Video Footage */}
      <Video
        src={staticFile('footage.mp4')}
        style={{ width: '100%', height: '100%', objectFit: 'cover' }}
      />

      {/* 2. Top Progress Bar */}
      <ProgressBar />

      {/* 3. Kinetic Subtitles / Captions */}
      <HormoziCaptions captions={captionsData} />
    </AbsoluteFill>
  );
};
```

#### 2. Hormozi-Style Kinetic Captions (`src/components/HormoziCaptions.tsx`)
```tsx
import React from 'react';
import { useCurrentFrame, useVideoConfig, spring, interpolate } from 'remotion';

interface CaptionWord {
  text: string;
  start: number; // in seconds
  end: number;   // in seconds
}

interface Props {
  captions: CaptionWord[];
}

export const HormoziCaptions: React.FC<Props> = ({ captions }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const currentTime = frame / fps;

  // Find active group of words (display 3-4 words at once)
  const activeIndex = captions.findIndex(
    (c) => currentTime >= c.start && currentTime <= c.end
  );

  if (activeIndex === -1) return null;

  // Group around active word
  const groupSize = 3;
  const groupStart = Math.max(0, activeIndex - (activeIndex % groupSize));
  const currentGroup = captions.slice(groupStart, groupStart + groupSize);

  return (
    <div
      style={{
        position: 'absolute',
        top: '60%',
        left: 0,
        right: 0,
        display: 'flex',
        justifyContent: 'center',
        flexWrap: 'wrap',
        gap: '12px',
        padding: '0 60px',
        pointerEvents: 'none',
      }}
    >
      {currentGroup.map((word, idx) => {
        const isCurrent = currentTime >= word.start && currentTime <= word.end;
        
        // Spring bounce animation on word trigger
        const wordStartFrame = Math.round(word.start * fps);
        const progress = spring({
          frame: frame - wordStartFrame,
          fps,
          config: { damping: 10, mass: 0.5, stiffness: 200 },
        });
        const scale = isCurrent ? interpolate(progress, [0, 1], [0.8, 1.25]) : 1.0;

        return (
          <span
            key={idx}
            style={{
              fontFamily: "'Prompt', 'Kanit', sans-serif",
              fontSize: '64px',
              fontWeight: 900,
              textTransform: 'uppercase',
              color: isCurrent ? '#FFE600' : '#FFFFFF', // Yellow highlight active word
              WebkitTextStroke: '14px #000000',
              paintOrder: 'stroke fill',
              transform: `scale(${scale})`,
              display: 'inline-block',
              filter: 'drop-shadow(0px 8px 12px rgba(0,0,0,0.8))',
            }}
          >
            {word.text}
          </span>
        );
      })}
    </div>
  );
};
```

#### 3. Animated Progress Bar (`src/components/ProgressBar.tsx`)
```tsx
import { useCurrentFrame, useVideoConfig } from 'remotion';

export const ProgressBar = () => {
  const frame = useCurrentFrame();
  const { durationInFrames } = useVideoConfig();
  const progressPercent = (frame / durationInFrames) * 100;

  return (
    <div
      style={{
        position: 'absolute',
        top: 0,
        left: 0,
        width: `${progressPercent}%`,
        height: '10px',
        backgroundColor: '#FFE600',
        boxShadow: '0 0 10px #FFE600',
        zIndex: 50,
      }}
    />
  );
};
```

---

## 🎬 Preview and Export Commands

### Start Interactive Web Preview (Remotion Studio)
```bash
npx remotion preview
```
This opens `http://localhost:3000` where the user can scrub the timeline, check styling, and inspect individual frames.

### Render High-Quality MP4
```bash
npx remotion render VideoComposition out/final_video.mp4 --codec=h264 --crf=18
```

---

## ⚠️ Remotion Rules & Common Pitfalls

1. **NO standard React State in animations**: Never use `useState` or `useEffect` to animate. Frame rendering must be completely pure and deterministic based on `useCurrentFrame()`.
2. **Always use staticFile()**: Source footage and audio files in `public/` must be wrapped with `staticFile('filename.mp4')`.
3. **Typography Fonts**: For Thai content, prefer clean, modern, bold Google Fonts like **'Prompt'**, **'Kanit'**, or **'Sukhumvit Set'**.
4. **Text Strokes**: Use `WebkitTextStroke: 'Xpx #000'` with `paintOrder: 'stroke fill'` to ensure high contrast over any background footage.
