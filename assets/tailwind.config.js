const tailwindcss = require("tailwindcss");

module.exports = {
  purge: [
    "../**/*.html.eex",
    "../**/*.html.leex",
    "../**/views/**/*.ex",
    "../**/live/**/*.ex",
    "./js/**/*.js",
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
    },
  },
  variants: {
    extend: {
     scale: ['hover'] 
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('./shadowpaletteplugin'),
  ],
}