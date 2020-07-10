module.exports = {
  theme: {
    extend: {
      screens: {
        'screen': {'raw': 'only screen'},
        'sm-screen': {'raw': 'only screen and (min-width: 640px)'},
        'md-screen': {'raw': 'only screen and (min-width: 768px)'},
        'lg-screen': {'raw': 'only screen and (min-width: 1024px)'},
        'xl-screen': {'raw': 'only screen and (min-width: 1280px)'},
        'print': {'raw': 'only print'},
      },
      fontSize: {
        '2rem': '2rem',
        '2hrem': '2.5rem',
        '3rem': '3rem',
        '3hrem': '3.5rem',
        '4rem': '4rem',
        '5rem': '5rem',
        '6rem': '6rem',
        '8rem': '8rem',
      },
      spacing: {
        '28': '7rem',
        '36': '9rem',
      },
      borderWidth: {
        '3': '3px',
      },
      fontFamily: {
        'sans': ['Merriweather', 'Arial', 'sans-serif'],
        'heading': ['Merriweather Sans', 'Arial', 'sans-serif'],
      },
      colors: {
        'orange': {
          '100': '#FEF4E6',
          '200': '#FDE4BF',
          '300': '#FCD399',
          '400': '#F9B34D',
          '500': '#F79200',
          '600': '#DE8300',
          '700': '#945800',
          '800': '#6F4200',
          '900': '#4A2C00',
        }
      }
    }
  },
  variants: {},
  plugins: []
}
