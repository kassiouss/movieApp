const express = require('express');
const router = express.Router();
const db = require('../db/connection');

/**
 * GET /movies
 * Lists movies with optional search and category filter, paginated (9 per page).
 * @query {string} search     - Title substring to filter by
 * @query {number} category   - Category ID to filter by
 * @query {number} page       - Page number (default: 1)
 */
router.get('/', async (req, res) => {
  const PAGE_SIZE = 9;
  const search = req.query.search || '';
  const categoryId = req.query.category || '';
  // Math.max guards against ?page=0 or negative values from URL manipulation
  const page = Math.max(1, parseInt(req.query.page) || 1);
  const offset = (page - 1) * PAGE_SIZE;

  // WHERE 1=1 lets us append AND clauses unconditionally without tracking whether it's the first filter
  let where = 'WHERE 1=1';
  const params = [];
  let paramIndex = 1;

  if (search) {
    where += ` AND m.title ILIKE $${paramIndex++}`;
    params.push(`%${search}%`);
  }
  if (categoryId) {
    where += ` AND m.category_id = $${paramIndex++}`;
    params.push(categoryId);
  }

  try {
    const { rows: [{ total }] } = await db.query(
      `SELECT COUNT(*) AS total FROM movie m ${where}`, params
    );
    const totalPages = Math.ceil(total / PAGE_SIZE);

    const { rows: movies } = await db.query(
      `SELECT m.*, c.name AS category_name FROM movie m LEFT JOIN category c ON m.category_id = c.id ${where} ORDER BY m.release_year DESC, m.release_month DESC LIMIT $${paramIndex} OFFSET $${paramIndex + 1}`,
      [...params, PAGE_SIZE, offset]
    );
    const { rows: categories } = await db.query('SELECT * FROM category ORDER BY name');
    const { rows: favRows } = await db.query('SELECT movie_id FROM favorites');
    // Set gives O(1) has() checks in the template instead of repeated array scans
    const favoriteIds = new Set(favRows.map(r => r.movie_id));
    res.render('movies/index', { movies, categories, search, categoryId, favoriteIds, page, totalPages });
  } catch (err) {
    console.error(err);
    res.render('movies/index', { movies: [], categories: [], search, categoryId, favoriteIds: new Set(), page: 1, totalPages: 1 });
  }
});

/**
 * GET /movies/:id
 * Shows detail page for a single movie.
 * @param {number} id - Movie ID
 */
router.get('/:id', async (req, res) => {
  try {
    const { rows } = await db.query(
      'SELECT m.*, c.name AS category_name FROM movie m LEFT JOIN category c ON m.category_id = c.id WHERE m.id = $1',
      [req.params.id]
    );
    if (!rows.length) return res.status(404).render('404');
    const { rows: fav } = await db.query('SELECT id FROM favorites WHERE movie_id = $1', [req.params.id]);
    res.render('movies/show', { movie: rows[0], isFavorite: fav.length > 0 });
  } catch (err) {
    console.error(err);
    res.status(500).send('Server error');
  }
});

/**
 * POST /movies/:id/favorite
 * Toggles the favorite status of a movie, then redirects back to the referring page.
 * @param {number} id - Movie ID
 */
router.post('/:id/favorite', async (req, res) => {
  const movieId = req.params.id;
  // Toggle: remove if already favorited, add if not
  const { rows: fav } = await db.query('SELECT id FROM favorites WHERE movie_id = $1', [movieId]);
  if (fav.length > 0) {
    await db.query('DELETE FROM favorites WHERE movie_id = $1', [movieId]);
  } else {
    await db.query('INSERT INTO favorites (movie_id) VALUES ($1)', [movieId]);
  }
  // Redirect back to the page the user came from (works on both list and detail views)
  res.redirect(req.get('Referer') || `/movies/${movieId}`);
});

module.exports = router;