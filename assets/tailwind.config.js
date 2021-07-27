const theme = require("tailwindcss/defaultTheme");

module.exports = {
  purge: [
    "../**/*.html.eex",
    "../**/*.html.leex",
    "../**/views/**/*.ex",
    "../**/live/**/*.ex",
    "./js/**/*.js",
  ],
  // mode: 'jit',
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      fontFamily: {
        'sans': ['poppins', ...theme.fontFamily.sans]
      }
    },
  },
  variants: {
    extend: {
     scale: ['hover'],
     animation: ['hover'],
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('./shadowpaletteplugin'),
  ],
}