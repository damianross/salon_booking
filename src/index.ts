import express from 'express'
import path from 'path';

const app = express()

app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.set('view engine', 'ejs');

import bookings from './routes/bookings';
app.use('/bookings/', bookings);
app.use(express.static(path.join(__dirname, 'public')))


app.use(function(req, res, next) {
  res.status(404);

  // respond with html page
  if (req.accepts('html')) {
    res.sendFile('404.html', {root: __dirname + '/public'});
    return;
  }

  // respond with json
  if (req.accepts('json')) {
    res.json({ error: 'Not found' });
    return;
  }

  // default to plain-text. send()
  res.type('txt').send('Not found');
});

const server = app.listen(3000, () =>
  console.log(`🚀 Server ready at: http://localhost:3000`),
)