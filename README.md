# tkdhss111.github.io

竹田 恒 の個人ページ。<https://tkdhss111.github.io/>

[Quarto](https://quarto.org) で作成し、`quarto publish gh-pages` で
GitHub Pages（`gh-pages` ブランチ）へ公開する。

---

# 学生向け：このリポジトリを雛形にして自分のページを作る

このリポジトリを**手本**にして、自分の自己紹介ページを作り、
`https://<自分のユーザ名>.github.io/` で公開するまでの手順です。
中身は竹田の内容が入っているので、自分のものに書き換えて使ってください。

## 全体の流れ

| | やること | どこで |
|:--|:--|:--|
| 1 | テンプレートから自分のリポジトリを作る | GitHub |
| 2 | RStudio でプロジェクトとして開く | RStudio |
| 3 | Quarto が使えるか確認する | RStudio の Terminal |
| 4 | 内容を自分のものに書き換える | RStudio のエディタ |
| 5 | 手元で表示を確認する | RStudio |
| 6 | 公開する | RStudio の Terminal |
| 7 | 公開されたか確認する | ブラウザ |

`git` のコマンドは、RStudio 下部の **Terminal** タブに打ち込みます
（**Console** タブではありません。Console は R のコードを書くところです）。

---

## 手順 1. テンプレートから自分のリポジトリを作る

1. このリポジトリのページ上部にある緑色の
   **Use this template → Create a new repository** を押す
2. **Repository name** に `<自分の GitHub ユーザー名>.github.io` と入力する
   - 例：ユーザー名が `s12345678` なら `s12345678.github.io`
   - **この名前でないと公開されません**
3. 公開範囲は **Public** を選ぶ
   - 無料アカウントでは、Private だと GitHub Pages を使えません
4. **Create repository** を押す

> テンプレートから作ったリポジトリは、元のリポジトリとは切り離された
> 独立したものになります（fork とは違い、履歴も引き継ぎません）。

## 手順 2. RStudio でプロジェクトとして開く

まず、GitHub の自分のリポジトリのページで緑色の **Code** ボタンを押し、
**SSH** タブに切り替えて、表示される URL をコピーします。

```
git@github.com:<ユーザー名>/<ユーザー名>.github.io.git
```

> **HTTPS** タブの URL（`https://github.com/...`）ではありません。
> SSH 鍵で接続するので、SSH タブのものを使います。

RStudio で次のように進みます。

1. **File → New Project...**
2. **Version Control** を選ぶ
3. **Git** を選ぶ
4. **Repository URL** にコピーした URL を貼り付ける
5. **Create Project** を押す

新しいウィンドウでプロジェクトが開きます。
以降の作業は、すべてこのプロジェクトの中で行います。

> プロジェクトとして開くと、作業ディレクトリが自動的にリポジトリの場所になります。
> `cd` で移動する必要はありません。

## 手順 3. Quarto が使えるか確認する

最近の RStudio には Quarto が同梱されているため、
**多くの場合インストールは不要**です。

**Terminal** タブで確認します。バージョン番号が出れば、そのまま使えます。

```sh
quarto --version
```

`command not found` と出た場合だけ、
<https://quarto.org/docs/get-started/> から入れてください。

## 手順 4. 内容を自分のものに書き換える

書き換える場所は次の3つだけです。

| ファイル | 書き換える箇所 |
|:--|:--|
| `index.qmd` | 氏名、所属、研究分野、学歴、職歴、業績、連絡先 |
| `_quarto.yml` | `title`、`site-url`、`repo-url`、`favicon` |
| `fig/` | 顔写真とファビコン画像 |

> **ファビコンは必ず差し替えてください。**
> `fig/tkd_crest_sakura.png` は作成者の家紋です。
> 自分の画像に差し替えるか、`_quarto.yml` の `favicon:` の行を削除します
> （ファビコンは無くても問題ありません）。

`index.qmd` と `_quarto.yml` には、設定の意味を説明するコメントが
書いてあります。まずそれを読んでから書き換えてください。

画像を差し替えるときは、**ファイル名を変えたら参照側も直すこと**です。
顔写真は `index.qmd` の `<img src="...">`、
ファビコンは `_quarto.yml` の `favicon:` が参照しています。
同じファイル名で上書きすれば、直す必要はありません。

## 手順 5. 手元で表示を確認する

1. `index.qmd` をエディタで開く
2. エディタ上部の **Render** ボタンの右にある
   **Render on Save** のチェックボックスを **オン** にする
3. `Ctrl-S`（Mac は `Cmd-S`）で保存する

保存するたびに自動で書き出され、結果が右側の **Viewer** ペインに表示されます。
以降は「書き換える → `Ctrl-S` → Viewer を見る」の繰り返しで進められます。

> **Render on Save** はファイルごとの設定です。
> 別の `.qmd` を開いたときは、そちらでも改めてチェックを入れてください。

## 手順 6. 公開する

**Terminal** タブで実行します。

```sh
make publish
```

これだけで、次の4つがまとめて実行されます。

```sh
git add -A                    # 変更をまとめる
git commit -m "Update"        # 記録する
git push                      # GitHub にソースを保存する
quarto publish gh-pages       # サイトを公開する
```

### 初回だけ聞かれること

最初の1回は、`gh-pages` ブランチを作ってよいか確認されます。
`Y` を入力して進めてください。

- `gh-pages` ブランチが自動で作られます
- GitHub Pages の公開設定も自動で行われます
- **Settings → Pages を手作業で設定する必要はありません**

> `Permission denied (publickey)` と出た場合は、SSH 鍵が使えていません。
> **Terminal** タブで接続を確かめてください。
>
> ```sh
> ssh -T git@github.com
> ```
>
> `Hi <ユーザー名>! You've successfully authenticated...` と返れば正常です。

## 手順 7. 公開されたか確認する

`https://<ユーザー名>.github.io/` をブラウザで開きます。

初回は反映まで数分かかることがあります。
表示が古いままのときは `Ctrl-Shift-R` で強制的に読み込み直してください。

以降は、手順 4 → 5 → 6 の繰り返しです。

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
├── makefile             make publish で公開する
└── website.Rproj        RStudio のプロジェクト設定
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
| ページが 404 になる | 反映に数分かかる。`Ctrl-Shift-R` で再読み込みして待つ |
| README がそのまま表示される | Settings → Pages の Branch が `gh-pages` `/ (root)` か確認 |
| リポジトリ名を間違えた | Settings → General → Repository name で変更できる |
| `Permission denied (publickey)` | SSH 鍵が使えていない（手順 6 の `ssh -T` で確認する） |
| ユーザー名とパスワードを聞かれる | HTTPS の URL で clone している。`git remote set-url origin git@github.com:<ユーザー名>/<ユーザー名>.github.io.git` で切り替える |
| `nothing to commit` | 変更がない。ファイルを保存したか確認する |
| `git` が使えない | Console タブに打っていないか確認する（Terminal タブで実行する） |
| Terminal タブが無い | **Tools → Terminal → New Terminal**（`Alt-Shift-M`）で開く |
| Render ボタンが無い | `index.qmd` を開いているか確認する |
| 画像が出ない | `fig/` のファイル名と `index.qmd` の `src=` が一致しているか確認 |
| タブに名前が二重に出る | `_quarto.yml` の `title` と `index.qmd` の `pagetitle` を同じ文字列にする |
