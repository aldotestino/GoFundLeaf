import express, { Request, Response } from 'express';
import { db } from '../lib/db';
import { formatDate } from '../utils/date';

const donateController = express.Router();

donateController.get('/', async (req: Request, res: Response) => {
  const { googleId } = req.query;

  if(!googleId) {
    res.send('Utente inesistente');
    return;
  }

  const user = await db.user.findUnique({
    where: {
      googleId: googleId.toString()
    },
    select: {
      name: true
    }
  });

  if(!user) {
    res.send('Utente inesistente');
    return;
  }

  res.render('donate', {
    name: user.name,
    googleId
  });
});

interface DonationBodyRequest {
  googleId: string,
  amt: number
}

donateController.post('/', async (req: Request) => {
  const { googleId, amt }: Partial<DonationBodyRequest> = req.body;

  if(googleId && amt) {
    await db.donation.create({
      data: {
        amt,
        googleId
      }
    });
  }
});

donateController.get('/all', async (req: Request, res: Response) => {
  const { googleId } = req.query;

  if(!googleId) {
    res.send('Utente inesistente');
    return;
  }

  const donations = await db.donation.findMany({
    where: {
      googleId: googleId.toString(),
    },
    select: {
      amt: true,
      dateTime: true
    }
  });


  res.json(
    donations.map(d => ({
      amt: d.amt,
      date: formatDate(d.dateTime)
    })).reverse()
  );
});

export default donateController;
