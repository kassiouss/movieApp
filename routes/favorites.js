const express = require('express');
const router = express.Router();
const db = require('../db/connection');

/**
 * GET /favorites
 * Lists all favorited movies paginated (9 per page), newest first.
 * @query {number} page - Page number (default: 1)
 */
router.get('/', async (req, res) => {
  try {
    const PAGE_SIZE = 9;
    const page = Math.max(1, parseInt(req.query.page) || 1);
    const offset = (page - 1) * PAGE_SIZE;

    const [[{ total }]] = await db.query('SELECT COUNT(*) AS total FROM favorites');
    const totalPages = Math.ceil(total / PAGE_SIZE);

    const [movies] = await db.query(
      `SELECT m.*, c.name AS category_name
       FROM favorites f
       JOIN movie m ON f.movie_id = m.id
       LEFT JOIN category c ON m.category_id = c.id
       ORDER BY m.release_year DESC, m.release_month DESC
       LIMIT ? OFFSET ?`,
      [PAGE_SIZE, offset]
    );
    res.render('favorites/index', { movies, page, totalPages });
  } catch (err) {
    console.error(err);
    res.render('favorites/index', { movies: [], page: 1, totalPages: 1 });
  }
});

module.exports = router;