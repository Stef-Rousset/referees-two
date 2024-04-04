const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      height: {
        '10vh': '10vh',
        '40vh' : "40vh",
        '80vh' : "80vh",
      },
      colors: {
        "darkblue": "#192A44",
      },
      backgroundImage:  {
        'banner': "url('banner_draw.png')",
      },
      keyframes: {
        modal: {
          '0%': { transform: 'translateY(0)' },
          '100%': { transform: 'translateY(-100%) scale(0.9)' },
        },
        modallg: {
          '0%': { transform: 'translateY(0)' },
          '100%': { transform: 'translateY(-60%) scale(0.9)' },
        },
      },
      animation: {
        modal: 'modal 250ms ease-in-out forwards',
        modallg: 'modallg 250ms ease-in-out forwards',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
