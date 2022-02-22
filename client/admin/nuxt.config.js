export default {
  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    title: 'rental-spacing-admin',
    htmlAttrs: {
      lang: 'ja',
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' },
      { name: 'format-detection', content: 'telephone=no' },
    ],
    link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }],
  },

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,
  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
    '@/plugins/api',
    '@/plugins/axios',
    '@/plugins/loading',
    '@/plugins/cache',
    { src: '~/plugins/infiniteloading', ssr: false },
    { src: '~plugins/vue-quill-editor.js', ssr: false },
    { src: '@/plugins/vee-validate', ssr: true },
  ],
  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [
    '@/assets/css/main.css',
    'quill/dist/quill.snow.css',
    'quill/dist/quill.bubble.css',
    'quill/dist/quill.core.css',
  ],
  auth: {
    strategies: {
      local: {
        endpoints: {
          login: {
            url: 'auth/login',
            method: 'post',
            propertyName: 'jwt',
          },
          user: {
            url: 'auth/me',
            method: 'get',
            propertyName: false,
          },
          logout: {
            url: 'auth/logout',
            method: 'post',
          },
        },
      },
    },
    redirect: {
      login: '/login',
      logout: '/login',
      callback: '/dashboard',
      home: '/',
    },
    watchLoggedIn: true,
  },
  watchers: {
    webpack: {
      poll: true,
    },
  },

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {
    transpile: ['vee-validate/dist/rules'],
  },
  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    // https://go.nuxtjs.dev/tailwindcss
    '@nuxtjs/tailwindcss',
    // Doc: https://github.com/nuxt-community/eslint-module
    '@nuxtjs/eslint-module',
    // Doc: https://github.com/nuxt-community/stylelint-module
    '@nuxtjs/stylelint-module',
    // Doc: https://github.com/whardier/nuxt-hero-icons
    '@nuxt-hero-icons/solid/nuxt',
    '@nuxt-hero-icons/outline/nuxt',
  ],
  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    '@nuxtjs/axios',
    '@nuxtjs/proxy',
    '@nuxtjs/auth',
    '@nuxt/http',
    '@nuxtjs/dayjs',
  ],
  /**
   * Add auth globally
   * https://auth.nuxtjs.org/guide/middleware
   */
  router: {
    middleware: ['auth'],
  },

  axios: {
    baseURL: 'http://localhost:3000/api/v1/admin',
  },

  tailwindcss: {
    cssPath: '~/assets/css/tailwind.css',
    configPath: 'tailwind.config.js',
    exposeConfig: false,
    viewer: false,
    config: {},
  },

  dayjs: {
    locales: ['ja'],
    defaultLocale: 'ja',
    defaultTimeZone: 'Asia/Tokyo',
    plugins: [
      'utc', // import 'dayjs/plugin/utc'
      'timezone', // import 'dayjs/plugin/timezone'
    ], // Your Day.js plugin
  },

  env: {
    baseUrl: process.env.BASE_URL,
    frontUrl: process.env.FRONT_URL,
    apiUrl: process.env.API_URL,
    apiUrlBrowser: process.env.API_URL_BROWSER,
  },
  extractCSS: true,
  server: {
    port: process.env.PORT, // デフォルト: 3000
    host: '0.0.0.0', // デフォルト: localhost
  },
}
