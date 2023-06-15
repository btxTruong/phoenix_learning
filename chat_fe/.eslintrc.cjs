module.exports = {
  parser: '@typescript-eslint/parser',
  plugins: ['react-refresh', 'prettier'],
  extends: ['eslint:recommended', 'plugin:@typescript-eslint/recommended', 'plugin:react/recommended', 'plugin:react-hooks/recommended', 'prettier'],
  env: {browser: true, es2020: true},
  parserOptions: {ecmaVersion: 'latest', sourceType: 'module'},
  settings: {
    react: {
      version: "detect"
    }
  }
};
