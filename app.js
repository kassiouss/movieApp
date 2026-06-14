require('dotenv').config();
const express = require('express');
const methodOverride = require('method-override');
const path = require('path');

const indexRouter = require('./routes/index');
const moviesRouter = require('./routes/movies');
const categoriesRouter = require('./routes/categories');
const favoritesRouter = require('./routes/favorites');

const app = express();

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
// HTML forms only support GET/POST; _method lets forms send PUT/DELETE via a hidden field
app.use(methodOverride('_method'));
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/movies', moviesRouter);
app.use('/categories', categoriesRouter);
app.use('/favorites', favoritesRouter);

// Catch-all 404 — must be registered after all other routes
app.use((req, res) => {
  res.status(404).render('404');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});