# Config nvim de R3B3

Fork personnel de [kickstart.nvim][kickstart], adapté pour :

- **Python** (basedpyright + ruff)
- **TypeScript / React** (.ts, .tsx) avec Bun
- **JavaScript / React** (.js, .jsx) avec npm
- **Fichiers de config** (JSON, JSONC, YAML, TOML)
- **Tailwind CSS** avec autocomplétion
- Intégration [Claude Code][claude-code-nvim] directement dans nvim

[kickstart]: https://github.com/nvim-lua/kickstart.nvim
[claude-code-nvim]: https://github.com/greggh/claude-code.nvim

## Stack complète

| Couche              | Outils                                         |
| ------------------- | ---------------------------------------------- |
| Plugins             | `lazy.nvim`                                    |
| Installateur        | `mason.nvim` + `mason-tool-installer.nvim`     |
| LSPs Python         | `basedpyright`, `ruff`                         |
| LSPs JS/TS          | `ts_ls`, `eslint`, `tailwindcss`               |
| LSPs config         | `jsonls`, `yamlls`, `taplo`                    |
| LSP Lua             | `lua_ls`                                       |
| Formatage           | `conform.nvim` (prettierd, stylua, ruff, taplo)|
| Linting             | `nvim-lint` (markdownlint)                     |
| Autocomplétion      | `blink.cmp` (fuzzy matcher Rust)               |
| Treesitter          | Parsers JS/TS/TSX/JSX/Python/JSON/YAML/TOML... |
| File explorer       | `neo-tree.nvim` (`\` pour toggle)              |
| Fuzzy finder        | `telescope.nvim`                               |
| Git                 | `gitsigns.nvim`                                |
| Terminal Claude     | `claude-code.nvim`                             |

## Raccourcis clés ajoutés en plus de kickstart

| Touche                  | Action                                    |
| ----------------------- | ----------------------------------------- |
| `<leader>cc` ou `<C-,>` | Toggle terminal Claude Code               |
| `<leader>st`            | [S]earch [T]odo via Telescope             |
| `<leader>f`             | Formater le buffer courant                |
| `<leader>sf`            | Chercher des fichiers (Telescope)         |
| `<leader>sg`            | [G]rep dans le projet                     |
| `<leader>sd`            | Lister les [D]iagnostics                  |
| `\`                     | Toggle neo-tree                           |
| `<C-h/j/k/l>`           | Navigation entre splits                   |
| `<C-S-h/j/k/l>`         | Déplacer le split lui-même                |

Leader = `Espace`.

## Installation

### 1. Dépendances système

```bash
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl fd-find \
                 nodejs npm lazygit
```

- `nodejs` + `npm` : requis par plusieurs LSPs (`bashls`, `eslint`, `tailwindcss`,
  `ts_ls`) et par `prettier`. Node 18+ recommandé.
- `lazygit` : si le paquet n'est pas dispo dans ton apt, installer le binaire
  depuis [jesseduffield/lazygit][lazygit-gh] (releases GitHub).

[lazygit-gh]: https://github.com/jesseduffield/lazygit#installation

### 2. Neovim (>= 0.10 recommandé)

```bash
NVIM_URL=https://github.com/neovim/neovim/releases/latest/download
curl -LO $NVIM_URL/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
```

### 3. Nerd Font

1. Choisir une font sur [Nerd Fonts](https://www.nerdfonts.com/)
   (ex : Agave, JetBrainsMono).
1. Dézipper et l'installer :

   ```bash
   unzip Agave.zip -d Agave
   sudo mv Agave /usr/local/share/fonts/
   fc-cache -f -v
   ```

1. Configurer la font dans les préférences du terminal.

### 4. Claude Code CLI

Requis pour le plugin `claude-code.nvim`.
Voir [anthropics/claude-code][claude-cli]. Le binaire doit être accessible
via `$PATH` (`which claude` doit retourner un chemin).

[claude-cli]: https://github.com/anthropics/claude-code

### 5. Installer cette config

```bash
# Sauvegarder l'ancienne config si elle existe
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# Cloner
git clone git@github.com:R3B3-888/kickstart.nvim.git ~/.config/nvim

# Lancer nvim — lazy.nvim installe les plugins, Mason installe les LSPs
nvim
```

Au premier lancement, attendre ~1 minute que Mason télécharge tous les LSPs
et formatters (voir la barre de statut en bas).

## Pré-requis externes par plugin

Mason gère automatiquement tous les LSPs, formatters et debug adapters cités
dans `init.lua`. Ce qui suit est ce que **Mason ne peut PAS installer** — à
mettre manuellement sur une nouvelle machine.

### Binaires système (obligatoires)

| Binaire   | Utilisé par              | Install                       |
| --------- | ------------------------ | ----------------------------- |
| `lazygit` | `lazygit.nvim`           | voir [lazygit-gh] si pas apt  |
| `nodejs`  | `bashls`, `eslint`, `ts` | `apt install nodejs npm`      |
| `rg`      | Telescope live_grep      | `apt install ripgrep`         |
| `fd`      | Telescope find_files     | `apt install fd-find`         |
| `claude`  | `claude-code.nvim`       | voir [claude-cli]             |

### Binaires optionnels (par fonctionnalité)

| Binaire   | Activé quand...            | Install                            |
| --------- | -------------------------- | ---------------------------------- |
| `psql`    | `<leader>du` + Postgres    | `apt install postgresql-client`    |
| `mysql`   | `<leader>du` + MySQL       | `apt install default-mysql-client` |
| `sqlite3` | `<leader>du` + SQLite      | `apt install sqlite3`              |
| `mongosh` | `<leader>du` + MongoDB     | voir [mongosh-install]             |

### Dépendances **par projet** (pas nvim)

Les tests et le debug ont besoin que le projet lui-même ait installé ses
propres outils. Mason n'y touche pas.

| Contexte                | À installer dans le projet            |
| ----------------------- | ------------------------------------- |
| `<leader>tt` Python     | `pip install pytest` dans le venv     |
| `<leader>tt` TS/React   | `bun add -d vitest` (ou npm)          |
| ESLint LSP attaché      | `eslint.config.js` dans le projet     |
| Tailwind autocomplétion | `tailwind.config.{js,ts}` dans projet |

### Mémo : installer Mason manuellement

Si jamais Mason foire l'auto-install, lancer dans nvim :

```vim
:MasonToolsInstall
```

Puis vérifier avec `:Mason` (tout doit être en vert ✓).

## Vérification

Dans Neovim :

- `:checkhealth` — diagnostic global
- `:Mason` — état des LSPs et outils installés
- `:Lazy` — état des plugins
- `:LspInfo` (sur un fichier Python/TS/etc.) — confirmer les serveurs attachés

## Structure du dépôt

```text
init.lua                 # Config principale (options, keymaps, lazy.setup)
lua/custom/plugins/      # Plugins perso (auto-importés par lazy.nvim)
  ├── init.lua           # Placeholder
  └── claude-code.lua    # Plugin Claude Code
lua/kickstart/           # Extras optionnels fournis par kickstart
  ├── health.lua         # :checkhealth kickstart
  └── plugins/debug.lua  # DAP (debugger)
doc/kickstart.txt        # :help kickstart
.stylua.toml             # Config formatter Lua
lazy-lock.json           # Lock des versions de plugins (versionné)
CLAUDE.md                # Guide pour Claude Code (IA)
```

Pour ajouter un plugin : créer un fichier `lua/custom/plugins/mon-plugin.lua`
qui retourne une spec `lazy.nvim`. Pas besoin de toucher à `init.lua`.

## Docs pour apprendre vim

- [The Only Video You Need to Get Started with Neovim][neovim-video]
- Chaînes YT : ThePrimeagen, Luke Smith
- `:Tutor` directement dans nvim

[neovim-video]: https://youtu.be/m8C0Cq9Uv9o
[mongosh-install]: https://www.mongodb.com/docs/mongodb-shell/install/
