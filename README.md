# tkdhss111.github.io

竹田 恒 の個人ページ。<https://tkdhss111.github.io/>

[Quarto](https://quarto.org) で作成し、`main` への push を契機に
GitHub Actions がビルドして `gh-pages` ブランチへ公開する。

---

# 学生向け：このリポジトリを雛形にして自分のページを作る

以下は、このリポジトリを**手本**として自分の自己紹介ページを作るための手順です。
中身は竹田の内容が入っているので、自分のものに書き換えて使ってください。

## 1. 自分のリポジトリを作る

このリポジトリのページ上部にある緑色の
**Use this template → Create a new repository** を押します。

作成画面では次の2点に注意してください。

- **Repository name** は必ず `<自分の GitHub ユーザー名>.github.io` にする。
  この名前でないと `https://<ユーザー名>.github.io/` では公開されません。
- 公開範囲は **Public** にする。
  無料アカウントでは、Private だと GitHub Pages で公開できません。

できたら、手元に取ってきます。

```sh
git clone https://github.com/<ユーザー名>/<ユーザー名>.github.io.git
cd <ユーザー名>.github.io
```

> テンプレートから作ったリポジトリは、元のリポジトリとは切り離された
> 独立したものになります（fork とは違い、履歴も引き継ぎません）。

## 2. 必要なソフト

[Quarto](https://quarto.org/docs/get-started/) だけです。

```sh
quarto --version
```

## 3. 中身を自分のものに書き換える

書き換える場所は次の3つだけです。

| ファイル | 書き換える箇所 |
|:--|:--|
| `index.qmd` | 氏名、所属、研究分野、学歴、職歴、業績、連絡先 |
| `_quarto.yml` | `title`、`site-url`、`repo-url` を自分のものにする |
| `fig/` | 顔写真とファビコン画像を差し替える |

画像を差し替えるとき、**ファイル名を変えたら参照側も直すこと**です。
顔写真は `index.qmd` の `<img src="...">`、
ファビコンは `_quarto.yml` の `favicon:` が参照しています。
同じファイル名で上書きすれば、直す必要はありません。

`index.qmd` と `_quarto.yml` には、設定の意味を説明するコメントが
書いてあります。まずそれを読んでから書き換えてください。

### 書きながら確認する

```sh
quarto preview
```

ブラウザが開き、ファイルを保存するたびに表示が更新されます。
確認が済んだら `Ctrl-C` で止めます。

書き出すだけなら次のとおりです（`docs/` に出力されます）。

```sh
quarto render
```

## 4. 公開する

### 4-1. 最初に一度だけ：`gh-pages` ブランチを作る

公開用のワークフローは、既にある `gh-pages` ブランチを**更新**することはできますが、
**新しく作ることはできません**。最初に一度だけ、空のブランチを用意します。

```sh
git switch --orphan gh-pages
git commit --allow-empty -m "Initialise gh-pages branch"
git push origin gh-pages
git switch main
```

> `git switch --orphan` は、作業ディレクトリを空にして新しいブランチを作ります。
> ファイルが消えたように見えますが、最後の `git switch main` で元に戻ります。
> 念のため、`main` を push し終えてから実行してください。

### 4-2. GitHub の設定

リポジトリの **Settings → Pages** を開き、次のとおり設定します。

- Source: **Deploy from a branch**
- Branch: **`gh-pages`** ／ フォルダ: **`/ (root)`**

「GitHub Actions」は選ばないでください。この公開方式と衝突します。

### 4-3. あとは push するだけ

```sh
git add .
git commit -m "自己紹介ページを書いた"
git push
```

数分待つと `https://<ユーザー名>.github.io/` に反映されます。
進行状況はリポジトリの **Actions** タブで確認できます。

---

## ファイル構成

```
.
├── index.qmd            本体。1ページ構成なので、これがサイトの中身そのもの
├── _quarto.yml          プロジェクト設定（テーマ・出力先・ファビコン）
├── styles.css           見た目の調整（顔写真の丸トリミング、年表の2列レイアウト）
├── theme-dark.scss      ダークモード用の色設定
├── _includes/           <head> に差し込む断片（フォント読み込みなど）
├── fig/                 画像置き場
└── .github/workflows/   GitHub Actions の設定
```

`_` で始まるディレクトリ（`_includes/` など）は Quarto がページとして
書き出しません。部品置き場として使えます。

## 書き方のポイント

`index.qmd` で使っている記法は次のとおりです。

- **YAML フロントマター** — ファイル冒頭の `---` で囲まれた設定
- **div** — `::: {.timeline}` … `:::` で囲むと、その範囲に CSS クラスが付く
- **定義リスト** — 「用語 → 改行 → `:` 説明」で年表を作る
- **改行** — Markdown では単なる改行は空白になる。
  行を変えたいときは `<br>` を書く

学歴・職歴は、日本の履歴書にならって**古い順**に並べています。

## 注意

**公開されるページに、住所・電話番号・生年月日を書かないこと。**
リポジトリは誰でも読めます。いちど push したものは、あとから消しても
Git の履歴に残ります。

Markdown 中の HTML コメント（`<!-- -->`）も、そのまま出力に残り公開されます。
人に見せたくないメモを `.qmd` に書かないでください。

履歴書などの非公開資料は、そもそもこのリポジトリに置かないこと。
どうしても手元に置く必要がある場合は `_sources/` に入れます
（`.gitignore` で除外済みで、`_` 始まりのため Quarto の出力にも含まれません）。

## うまくいかないとき

| 症状 | 原因と対処 |
|:--|:--|
| Actions が失敗する | `gh-pages` ブランチを作り忘れている（4-1 を実行する） |
| ページが 404 になる | Settings → Pages が `gh-pages` `/ (root)` になっているか確認 |
| README がそのまま表示される | Pages の Source が `main` のままになっている |
| 画像が出ない | `fig/` のファイル名と `index.qmd` の `src=` が一致しているか確認 |
| タブに名前が二重に出る | `_quarto.yml` の `title` と `index.qmd` の `pagetitle` を同じ文字列にする |
