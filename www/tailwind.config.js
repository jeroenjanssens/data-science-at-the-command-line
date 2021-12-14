const colors = require('tailwindcss/colors')

module.exports = {
  corePlugins: {
    container: false,
  },
  mode: "jit",
  purge: {
    mode: 'all',
    preserveHtmlElements: false,
    content: [
      "./src/**/*.html",
      "./src/**/*.md",
      "./src/**/*.njk",
      ".eleventy.js",
    ]
  },
  theme: {
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      black: colors.black,
      white: colors.white,
      gray: colors.warmGray,
      blue: colors.sky,
      orange: colors.orange,
      blueold: {
        "50": "#32caff",
        "100": "#28c0fe",
        "200": "#1eb6f4",
        "300": "#14acea",
        "400": "#0aa2e0",
        "500": "#0098d6",
        "600": "#008ecc",
        "700": "#0084c2",
        "800": "#007ab8",
        "900": "#0070ae",
      },
      orangeold: {
        "50": "#ffa069",
        "100": "#ff965f",
        "200": "#ff8c55",
        "300": "#fe824b",
        "400": "#f47841",
        "500": "#ea6e37",
        "600": "#e0642d",
        "700": "#d65a23",
        "800": "#cc5019",
        "900": "#c2460f",
      },
    },
    fontFamily: {
      sans: ['Source Sans Pro',
             'Times New Roman',
             '-apple-system',
             'BlinkMacSystemFont',
             'Arial',
             'sans-serif',
            ],

      serif: ['Source Sans Pro',
             'Times New Roman',
             '-apple-system',
             'BlinkMacSystemFont',
             'Arial',
             'sans-serif',
            ],
    },
    extend: {
      lineClamp: {
        7: '7',
        8: '8',
        9: '9',
        10: '10',
      },
      maxWidth: {
        '1/4': '25%',
        '1/2': '50%',
        '2/3': '66%',
        '3/4': '75%',
      },
      maxHeight: {
        '1/4': '25%',
        '1/2': '50%',
        '2/3': '66%',
        '3/4': '75%',
      },
      dropShadow: {
        'DEFAULT': '1px 2px 4px rgba(0, 0, 0, 0.25)',
      },
      typography: (theme) => ({
        DEFAULT: {
          css: {
            a: {
              color: theme('colors.blue.700'),
            },
            color: theme('colors.gray.600'),
            fontWeight: '400',
            code: {
              color: theme('colors.gray.800'),
              fontWeight: '400',
            },
            'pre > code': {
              fontSize: '0.7em',
              lineHeight: '0.1',
            },
            h1: {
              color: theme('colors.gray.800'),
            },
            h2: {
              color: theme('colors.gray.800'),
            },
            h3: {
              color: theme('colors.gray.800'),
              fontWeight: '700',
            },
            h4: {
              color: theme('colors.gray.800'),
            },
            'ul > li::before': {
              backgroundColor: theme('colors.gray.600'),
            },
            'code::before': {
              content: '""'
            },
            'code::after': {
              content: '""'
            },
            'blockquote p:first-of-type::before': {
              content: '""'
            },
          },
        },
      }),
    },
  },
  variants: {},
  plugins: [
    require("@tailwindcss/typography"),
    require("@tailwindcss/forms"),
    require("@tailwindcss/line-clamp"),
    require('@tailwindcss/aspect-ratio'),
    require('tailwindcss-debug-screens'),
  ],
};
