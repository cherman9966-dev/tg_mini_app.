// 1. Створюємо об'єкти окремо
const templates = {
  'classic': { file: 'mem_template.png', topY: 80, bottomY: 450 },
  'leo': { file: 'leo.png', topY: 80, bottomY: 450 },
  'bob': { file: 'bob.png', topY: 80, bottomY: 450 },
  'mens': { file: 'mens.png', topY: 80, bottomY: 450 },
  'what': { file: 'what.png', topY: 80, bottomY: 450 },
  'bob2': { file: 'bob2.png', topY: 80, bottomY: 450 }
};

const defaults = {
  fontSize: 40,
  fontFamily: 'bold 40px Sans-serif',
  strokeWidth: 4
};

// 2. Експортуємо ОБИДВА об'єкти разом
module.exports = { 
  templates: templates, 
  defaults: defaults 
};