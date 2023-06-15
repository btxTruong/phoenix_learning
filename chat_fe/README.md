# Phoenix Chat

## Stack

- React
- TailwindCSS
- React Router
- Vite

## Initial Setup

- Initial project: `npm create vite@latest`
  - Using `npm i vite-tsconfig-paths` to support `tsconfig.json` path alias. Add `tsconfigPaths()` in `plugins` in `vite.config.ts`
- Setup TailwindCSS: follow [this guide](https://tailwindcss.com/docs/guides/vite)
  and [this guide](https://tailwindcss.com/docs/using-with-preprocessors)
    - `npm install -D tailwindcss postcss autoprefixer postcss-import`
    - `npx tailwindcss init -p`
    - Update `tailwind.config.js`
    - Update `postcss.config.js`
    - Update `src/index.css`
```js
// tailwind.config.js
export default {
  important: true, // add !important to all tailwind classes
  prefix: 'tw-', // add tw- prefix to all tailwind classes, avoid conflict with other css frameworks
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

```js
// postcss.config.js
export default {
  plugins: {
    'postcss-import': {},
    'tailwindcss/nesting': {},
    tailwindcss: {},
    autoprefixer: {},
  }
};
```

```css
/* src/index.css */
@tailwind base;
@tailwind components;
@tailwind utilities;
```

- Setup eslint + prettier: follow [this guide](https://medium.com/tinyso/react-hero-setup-eslint-for-typescript-react-application-d171df2bb408) and [this guide](https://typescript-eslint.io/getting-started)
  - `npm install -D eslint prettier eslint-plugin-prettier eslint-config-prettier eslint-plugin-react eslint-plugin-react-hooks @typescript-eslint/eslint-plugin @typescript-eslint/parser`
  - Create `.eslintrc.cjs` file
  - Create `.prettierrc` file

```js
//.eslintrc.cjs
module.exports = {
  parser: '@typescript-eslint/parser',
  plugins: ['react-refresh', 'prettier'],
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:react/recommended',
    'plugin:react-hooks/recommended',
    'prettier'
  ],
  env: { browser: true, es2020: true },
  parserOptions: { ecmaVersion: 'latest', sourceType: 'module' },
  "settings": {
    "react": {
      "version": "detect"
    }
  }
};

```

```json5
//.prettierrc
{
  "semi": true,
  "trailingComma": "none",
  "singleQuote": true,
  "printWidth": 120
}
```
- Create `.editorconfig` file
```
# http://editorconfig.org
root = true

[*]
charset = utf-8
indent_style = space
indent_size = 2
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
max_line_length = 120
```
