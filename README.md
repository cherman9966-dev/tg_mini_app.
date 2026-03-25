TG Meme Pro is a fast, high-performance Telegram Mini App for instant meme generation. The frontend is built with Flutter (Web), and the backend is powered by Node.js.

✨ Key Features
Interactive Canvas: Users can easily drag, scale, and rotate text or emojis using multi-touch gestures (implemented via GestureDetector).

Smart Boundaries: Draggable elements never escape the visible screen. This is achieved using mathematical constraints (clamp) combined with a LayoutBuilder to read screen dimensions.

Custom Meme Typography: Authentic meme text styling with an outline effect (created using Stack and Paint). Each text node has an independent state: its own color, rotation, and size.

Dynamic Toolbar: Editing tools (color palette, delete, etc.) smoothly appear only when a specific text element is selected.

Background Manipulation: Instant horizontal image flipping using matrix transformations (Matrix4).

🏗️ Architecture & Clean Code
The project follows Clean Architecture principles to ensure high maintainability and scalability:

Separation of Concerns: The complex UI is broken down into small, independent widgets (e.g., MemeCanvas for gestures and MemeToolbar for inputs).

State Isolation: Local state (like text coordinates) is encapsulated within specific widgets. This prevents unnecessary rebuilds of the entire screen and ensures smooth 60 FPS animations.

Data Models: All data regarding a specific text node is managed using a dedicated data class (MemeTextItem).

Responsive Design: The UI perfectly adapts to any mobile device using AspectRatio (maintaining a 1:1 canvas ratio) and dynamic constraints.

🚀 Upcoming Features (Roadmap)
Client-Side Export: Implementing RepaintBoundary to capture the composed widget tree and save it as a high-quality PNG image.

Telegram Share API: One-tap sharing of the generated meme directly to Telegram chats and stories.

## Screens app on web version

| Home page | Editing_page |
| :---: | :---: |
| <img src="media/meme_page.png" width="300"> | <img src="media/edit_page.png" width="300"> |