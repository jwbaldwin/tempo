const theme = require("tailwindcss/defaultTheme");
const colors = require("tailwindcss/colors");

module.exports = {
  purge: [
    "../**/*.html.eex",
    "../**/*.html.leex",
    "../**/views/**/*.ex",
    "../**/live/**/*.ex",
    "./js/**/*.js",
  ],
  darkMode: 'class', // or 'media' or 'class'
  theme: {
    extend: {
      fontFamily: {
        'sans': ['poppins', ...theme.fontFamily.sans]
      },
      colors: {
        slate: colors.trueGray,
      },
      typography: (theme) => ({
        light: {
          css: [
            {
              color: theme('colors.slate.400'),
              '[class~="lead"]': {
                color: theme('colors.slate.300'),
              },
              a: {
                color: theme('colors.white'),
              },
              strong: {
                color: theme('colors.white'),
              },
              'ol > li::before': {
                color: theme('colors.slate.400'),
              },
              'ul > li::before': {
                backgroundColor: theme('colors.slate.600'),
              },
              hr: {
                borderColor: theme('colors.slate.200'),
              },
              blockquote: {
                color: theme('colors.slate.200'),
                borderLftColor: theme('colors.slate.600'),
              },
              h1: {
                color: theme('colors.white'),
              },
              h2: {
                color: theme('colors.white'),
              },
              h3: {
                color: theme('colors.white'),
              },
              h4: {
                color: theme('colors.white'),
              },
              'figure figcaption': {
                color: theme('colors.slate.400'),
              },
              code: {
                color: theme('colors.white'),
              },
              'a code': {
                color: theme('colors.white'),
              },
              pre: {
                color: theme('colors.slate.200'),
                backgroundColor: theme('colors.slate.800'),
              },
              thead: {
                color: theme('colors.white'),
                borderBottomColor: theme('colors.slate.400'),
              },
              'tbody tr': {
                borderBottomColor: theme('colors.slate.600'),
              },
            },
          ],
        },
      })
    },
  },
  variants: {
    extend: {
      scale: ['hover'],
      animation: ['hover'],
      typography: ['dark'],
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    // require('./shadowpaletteplugin'),
  ],
}
