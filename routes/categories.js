const express = require('express');
const router = express.Router();
const db = require('../db/connection');

/**
 * GET /categories
 * Lists all categories with their movie count, sorted alphabetically.
 */
router.get('/', async (req, res) => {
  try {
    // LEFT JOIN keeps categories with zero movies; COUNT(m.id) returns 0 for them
    const [categories] = await db.query(
      'SELECT c.*, COUNT(m.id) AS movie_count FROM category c LEFT JOIN movie m ON m.category_id = c.id GROUP BY c.id ORDER BY c.name'
    );
    res.render('categories/index', { categories });
  } catch (err) {
    console.error(err);
    res.render('categories/index', { categories: [] });
  }
});

module.exports = router;
