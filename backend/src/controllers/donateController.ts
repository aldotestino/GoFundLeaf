import express, { Request, Response } from 'express';
import { db } from '../lib/db';

const donateController = express.Router();

donateController.get('/', async (req: Request, res: Response) => {
  const { googleId } = req.query;

  if(!googleId) {
    res.send('Utente inesistente');
  }

  const user = await db.user.findUnique({
    where: {
      googleId: googleId?.toString()
    },
    select: {
      name: true
    }
  });

  if(!user) {
    res.send('Utente inesistente');
  }

  res.render('donate', {
    name: user?.name,
    googleId
  });
});

interface DonationBodyRequest {
  googleId?: string,
  amt?: string
}

donateController.post('/', async (req: Request) => {
  const { googleId, amt }: DonationBodyRequest = req.body;
  
  if(googleId && amt) {
    await db.donation.create({
      data: {
        amt,
        googleId
      }
    });
  }
});

export default donateController;
