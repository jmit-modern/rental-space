module.exports = {
  root: true,
  env: {
    browser: true,
    node: true,
    es2021: true,
  },
  parserOptions: {
    parser: 'babel-eslint',
    ecmaVersion: 12,
    sourceType: 'module',
  },
  extends: [
    '@nuxtjs',
    'eslint:recommended',
    'prettier',
    'plugin:prettier/recommended',
    'plugin:nuxt/recommended',
  ],
  plugins: ['prettier'],
  ignorePatterns: ['node_modules/', 'dist/', 'public/'],
  rules: {
    'no-new': 'off',
    'no-console': 'off',
    'vue/no-v-html': 'off',
    'no-irregular-whitespace': 'off',
    'unicorn/prefer-starts-ends-with': 'off',
    'vue/no-irregular-whitespace': [
      'error',
      {
        skipStrings: true,
        skipComments: true,
        skipRegExps: true,
        skipTemplates: false,
        skipHTMLAttributeValues: true,
        skipHTMLTextContents: true,
      },
    ],
  },
}
