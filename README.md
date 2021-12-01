# GoFundLeaf

La Progressive Web App dovrà permettere agli utenti di effettuare il login tramite il proprio account Google ed effettuare una donazione volontaria tramite PayPal.

Quest’app è quindi rivolta a tutti coloro che vogliano supportare economicamente il progetto LEAF.

## Requisiti funzionali

- Login: L’app deve permettere agli utenti di effettuare il login tramite il proprio account Google
- Donate: In seguito al login, l’utente avrà la possibilità di fare una donazione libera per…

## Requsiti di implementazione

- Flutter per lo sviluppo crossplatform dell’app
- Node.js server
- Utilizzo di database Postgres per memorizzazione degli utenti
- Uso di Docker per lo sviluppo e per il deploy finale
- Hosting del server su AWS

## Requisiti di affidabilità e sicurezza

La sicurezza dei dati degli utenti è garantita dall’uso di API esterne:

- L’utilizzo delle API di Google per gestire gli utenti ci permettono di non memorizzare i loro dati sensibili ma solo email, nome e cognome;
- Lo stesso vantaggio è offerto dall’uso delle API di PayPal, per cui non ci sarà passaggio di informazioni sul metodo di pagamento tra client e server, ma solo informazioni come l’identificativo dell’utente e la somma donata.

## Diagramma di Gantt

![https://i.imgur.com/R6qipdc.png](https://i.imgur.com/R6qipdc.png)

## Mockup

![https://i.imgur.com/O6hc09b.png](https://i.imgur.com/O6hc09b.png)

## Architettura

![https://i.imgur.com/GZZt4SC.png](https://i.imgur.com/GZZt4SC.png)
