import express, { Request, Response } from 'express';
import { join } from 'path';

const app = express();
app.set('view engine', 'ejs');
app.set('views', join(__dirname, 'views'));
app.use(express.static(join(__dirname, 'public')));
app.use(express.json());

app.get('/donate', (req: Request, res: Response) => {
  const { googleId } = req.query;
  res.render('donate', {
    name: 'Tizio',
    googleId
  });
});

app.post('/donate', (req: Request, _res: Response) => {
  console.log(req.body);
});

const PORT = process.env.PORT || 8080;

app.listen(PORT, () => {
  console.log(`Server listening at http://localhost:${PORT}`);
});
