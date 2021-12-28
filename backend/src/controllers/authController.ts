import express, { Request, Response } from 'express';
import { OAuth2Client } from 'google-auth-library';
import { db } from '../lib/db';
import { formatDate } from '../utils/date';

const googleAuthClient = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);

const authController = express.Router();

authController.post('/login', async (req: Request, res: Response) => {
  const { token } = req.body;

  try {
    const ticket = await googleAuthClient.verifyIdToken({
      idToken: token
    });
  
    const payload = ticket.getPayload();
  
    let user;
  
    user = await db.user.findUnique({
      where: {
        googleId: payload?.sub
      },
      include: {
        donations: true
      }
    });
  
    if(!user) {
      user = await db.user.create({
        data: {
          googleId: payload?.sub || '',
          name: payload?.given_name || '',
          surname: payload?.family_name || '',
          email: payload?.email || '',
          photoUrl: payload?.picture || ''
        },
        include: {
          donations: true
        }
      });
    }
  
    const formattedUser = {
      ...user,
      donations: user.donations.map(d => ({
        amt: d.amt,
        date: formatDate(d.dateTime)
      })).reverse()
    };
  
    res.json(formattedUser);
  }catch(e: any) {
    res.json({
      status: 'error',
      info: e.message
    })
  }
  
});

export default authController;

