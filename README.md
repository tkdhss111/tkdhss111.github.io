# tkdhss111.github.io

竹田 恒 の個人サイト。<https://tkdhss111.github.io/>

[Quarto](https://quarto.org) で作成し、`main` への push を契機に GitHub Actions が
ビルドして `gh-pages` ブランチへ公開する。

## 構成

```
.
├── _quarto.yml          プロジェクト設定（サイドバー・テーマ・出力先）
├── index.qmd            トップページ
├── about.qmd  work.qmd  engineering.qmd  writing.qmd  contact.qmd
├── _includes/           <head> に差し込む断片
├── fig/                 サイトで使う画像
├── styles.css           共通スタイル
├── theme-dark.scss      ダークモードのテーマ上書き
├── renv.lock            R パッケージのバージョン固定
└── _sources/            非公開の元資料（.gitignore 済み・コミット禁止）
```

## ビルド

```sh
quarto preview     # ブラウザで確認しながら編集
quarto render      # docs/ に出力
```

R チャンクを含むページを扱う場合は、最初に一度だけ:

```r
renv::restore()
```

## 教材としての利用

このリポジトリの `.qmd` は R プログラミング授業の教材を兼ねる。
そのため、YAML の各設定には意図を説明するコメントを付け、
1ファイルにつき新しい記法をひとつだけ導入する構成にしている。

読む順序:

1. `index.qmd` —— フロントマターと画像だけの最小構成
2. `about.qmd` —— div（`:::`）と定義リスト
3. `work.qmd` —— 図のラベルと相互参照、コールアウト
4. `engineering.qmd` —— Mermaid 図、タブセット
5. `writing.qmd` —— 表
6. `_quarto.yml` —— サイト全体の組み立て

## 注意

`_sources/` には非公開の元資料が入っている。
`.gitignore` で除外済みだが、**この除外を外さないこと**。
`_` で始まるディレクトリは Quarto のレンダリング対象外でもあるため、
出力（`docs/`）にも混入しない。

**`.qmd` に書いた内容はコメントも含めてすべて公開される。**
理由は2つ:

- Markdown 中の HTML コメント（`<!-- -->`）は、出力 HTML にそのまま残る
- `code-tools: true` により、各ページに `.qmd` のソース全体が埋め込まれる

後者は教材として意図的に有効化している設定である。
したがって、下書きメモや非公開にしたい判断の経緯を `.qmd` に書いてはいけない。
そうした記述はこの README か、`_sources/` に置くこと。
