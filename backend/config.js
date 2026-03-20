// 1. Створюємо об'єкти окремо
const templates = {
  'classic': { 
    file: 'mem_template.png', 
    topY: 80, 
    bottomY: 450 
  },
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