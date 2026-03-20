const express = require('express');
const cors = require('cors');
const path = require('path');
const { createCanvas, loadImage } = require('canvas');
const { templates, defaults } = require('./config'); 
const app = express();
app.use(cors());
app.use('/assets', express.static('assets'));

console.log('--- DEBUG INFO ---');
console.log('Templates:', templates);
console.log('Defaults:', defaults);
if (!defaults) {
    console.log('ПОМИЛКА: Об\'єкт defaults не знайдено в config.js!');
}
console.log('------------------');

app.get('/generate', async (req, res) => {
  try {
    // Отримуємо параметри з запиту
    const { textTop, textBottom, template = 'classic', color = 'white' } = req.query;

    // 1. Вибираємо конфігурацію шаблону
    const config = templates[template] || templates['classic'];
    const imagePath = path.join(__dirname, 'assets', config.file);

    // 2. Малюємо
    const image = await loadImage(imagePath);
    const canvas = createCanvas(image.width, image.height);
    const ctx = canvas.getContext('2d');

    ctx.drawImage(image, 0, 0);

    // Налаштування стилю з конфігу
    ctx.fillStyle = color;
    ctx.strokeStyle = 'black';
    ctx.lineWidth = defaults.strokeWidth;
    ctx.font = defaults.fontFamily;
    ctx.textAlign = 'center';

    // Малюємо текст, якщо він переданий
    if (textTop) {
      ctx.strokeText(textTop, canvas.width / 2, config.topY);
      ctx.fillText(textTop, canvas.width / 2, config.topY);
    }

    if (textBottom) {
      ctx.strokeText(textBottom, canvas.width / 2, config.bottomY);
      ctx.fillText(textBottom, canvas.width / 2, config.bottomY);
    }

    res.set('Content-Type', 'image/png');
    res.send(canvas.toBuffer());
  } catch (err) {
    console.error(err);
    res.status(500).send('Помилка сервера');
  }
});

app.listen(3000, () => console.log('Backend ready on port 3000'));