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
      boxShadow: {
        red: '0 4px 1.25rem #da393f',
      },
    },
  },
  variants: {
    extend: {
     scale: ['hover'] 
    },
  },
  plugins: [],
}

// TODO: Add in the configured box shadows using a plugin