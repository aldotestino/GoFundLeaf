const mesi = ['Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno', 'Luglio', 'Agosto', 'Settembre', 'Ottobre', 'Novembre', 'Dicembre'];

function formatDate(dateTime: Date) {
  return `${dateTime.getDate()} ${mesi[dateTime.getMonth()]} ${dateTime.getFullYear()}`;
}

export {
  formatDate
};