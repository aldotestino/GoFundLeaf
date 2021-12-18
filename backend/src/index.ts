import express from 'express';
import { join } from 'path';
import donateController from './controllers/donateController';
import authController from './controllers/authController';

const app = express();
app.set('view engine', 'ejs');
app.set('views', join(__dirname, 'views'));
app.use(express.static(join(__dirname, 'public')));
app.use(express.json());

app.use('/auth', authController);
app.use('/donate', donateController);

const PORT = process.env.PORT || 8080;

app.listen(PORT, () => {
  console.log(`Server listening at http://localhost:${PORT}`);
});
