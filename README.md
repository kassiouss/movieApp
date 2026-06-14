# Movie App

A full-stack web application for browsing and favoriting movies. Built with Express.js, EJS templates, Bootstrap 5, and MySQL.

---

## Tech Stack

| Layer      | Technology              |
|------------|-------------------------|
| Runtime    | Node.js                 |
| Framework  | Express 4               |
| Templating | EJS                     |
| Styling    | Bootstrap 5             |
| Database   | MySQL (via `mysql2`)    |
| Dev server | nodemon                 |

---

## Project Structure

```
movieApp/
├── app.js                  # Entry point — Express setup, middleware, route mounting
├── db/
│   ├── connection.js       # MySQL connection pool
│   └── schema.sql          # Database schema + sample data
├── routes/
│   ├── index.js            # GET /  — home page
│   ├── movies.js           # Movie routes + favorite toggle
│   ├── categories.js       # GET /categories
│   └── favorites.js        # GET /favorites
├── views/
│   ├── index.ejs           # Home page
│   ├── 404.ejs             # Not found page
│   ├── partials/
│   │   ├── header.ejs
│   │   └── footer.ejs
│   ├── movies/
│   │   ├── index.ejs       # Movie list with search, filter, pagination
│   │   └── detail.ejs        # Movie detail
│   ├── categories/
│   │   └── index.ejs       # Category list with movie counts
│   └── favorites/
│       └── index.ejs       # Paginated favorites list
└── public/
    └── css/
        └── style.css       # Custom styles
```

---

## Database Schema

Three tables in the `movie_db` database:

```
category
  id          INT PK AUTO_INCREMENT
  name        VARCHAR(100) UNIQUE NOT NULL

movie
  id                INT PK AUTO_INCREMENT
  title             VARCHAR(200) NOT NULL
  description       TEXT
  duration_minutes  INT
  rating            DECIMAL(3,1)   -- 0.0–10.0
  release_year      INT
  release_month     INT            -- 1–12
  image_url         VARCHAR(500)
  category_id       INT FK → category(id) ON DELETE SET NULL
  created_at        TIMESTAMP

favorites
  id          INT PK AUTO_INCREMENT
  movie_id    INT FK → movie(id) ON DELETE CASCADE
  added_at    TIMESTAMP
  UNIQUE(movie_id)               -- one entry per movie
```

---

## Routes

### Home

| Method | Path | Description                              |
|--------|------|------------------------------------------|
| GET    | `/`  | Paginated movie grid (9 per page)        |

### Movies

| Method | Path          | Description                                    |
|--------|---------------|------------------------------------------------|
| GET    | `/movies`     | List with search, category filter, pagination  |
| GET    | `/movies/:id` | Movie detail page                              |

### Categories

| Method | Path          | Description                           |
|--------|---------------|---------------------------------------|
| GET    | `/categories` | List all categories with movie counts |

### Favorites

| Method | Path         | Description                                     |
|--------|--------------|--------------------------------------------------|
| GET    | `/favorites` | Paginated list of favorited movies (9 per page)  |

---

## Getting Started

### Prerequisites

- Node.js 18+
- MySQL 8+

### 1. Clone and install

```bash
git clone <repo-url>
cd movieApp
npm install
```

### 2. Create the database

```bash
mysql -u root -p < db/schema.sql
```

This creates the `movie_db` database, all tables, and loads sample data (50 movies across 8 Greek-language categories).

### 3. Configure environment variables

Create a `.env` file in the project root:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=movie_db
PORT=3000
```

### 4. Run the app

```bash
# Production
npm start

# Development (auto-restart on file changes)
npm run dev
```

The app will be available at `http://localhost:3000`.

---

## Features

- **Search** movies by title (live query parameter)
- **Filter** by category
- **Pagination** — 9 movies per page across all listing views
- **Favorites** — view favorited movies; favorites are stored per-movie (unique constraint prevents duplicates)
- **Category overview** — shows how many movies belong to each category
- **404 page** — custom catch-all for unknown routes