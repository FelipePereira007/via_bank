# Via Bank

Front-end de banco digital integrado a uma API local.

## Arquivos

- `login.html` — login e cadastro.
- `index.html` — dashboard protegido.
- `styles.css` — estilos do dashboard.
- `app.js` — comportamento do dashboard e consumo da API.
- `backend.js` — camada central de `fetch()` para o backend.

## Rodar o front

Use Live Server no VS Code ou:

```bash
python -m http.server 5500
```

Depois abra:

```text
http://localhost:5500/login.html
```

## Backend esperado

O arquivo `backend.js` aponta para:

```text
http://localhost:3000/api
```

O login usa:

- `POST /auth/login`
- body: `{ "email": "...", "password": "..." }`
- resposta esperada: `{ "accessToken": "...", "user": {...} }`

O cadastro usa:

- `POST /auth/register`
- body: `name`, `cpf`, `email`, `phone`, `birthDate`, `password`
- pode responder com `accessToken` para login automático ou sem token para o usuário fazer login.

O dashboard só abre quando existir `via_access_token` no navegador. Uma resposta 401/403 da API limpa a sessão e volta ao login.

## Sem backend

Sem servidor em `localhost:3000`, login e cadastro exibem uma mensagem de backend indisponível e o dashboard não é liberado.
