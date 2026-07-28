# tkdhss111.github.io

竹田 恒 の個人ページ。<https://tkdhss111.github.io/>

[Quarto](https://quarto.org) で作成し、`main` への push を契機に
GitHub Actions がビルドして `gh-pages` ブランチへ公開する。

---

# 学生向け：このリポジトリを雛形にして自分のページを作る

このリポジトリを**手本**にして、自分の自己紹介ページを作り、
`https://<自分のユーザー名>.github.io/` で公開するまでの手順です。
中身は竹田の内容が入っているので、自分のものに書き換えて使ってください。

## 全体の流れ

| | やること | どこで |
|:--|:--|:--|
| 1 | テンプレートから自分のリポジトリを作る | GitHub |
| 2 | RStudio でプロジェクトとして開く | RStudio |
| 3 | `gh-pages` ブランチを作る（最初の一度だけ） | RStudio の Terminal |
| 4 | Pages の公開設定をする | GitHub |
| 5 | Quarto が使えるか確認する | RStudio の Terminal |
| 6 | 内容を自分のものに書き換える | RStudio のエディタ |
| 7 | 手元で表示を確認する | RStudio |
| 8 | push する | RStudio の Terminal |
| 9 | 公開されたか確認する | ブラウザ |

このテンプレートは **RStudio** で使うことを想定しています。
`git` のコマンドは、RStudio 下部の **Terminal** タブに打ち込みます
（**Console** タブではありません。Console は R のコードを書くところです）。

**3 と 4 を先に済ませておくこと。**
この2つを飛ばして 8 の push をすると、自動ビルドが失敗します。

> リポジトリを作った直後に **Actions** タブを見ると、
> 赤い × が付いた実行が残っていることがあります。
> 手順 3 をまだ済ませていないためで、気にしなくて構いません。
> 手順 3・4 を終えたあとの push で緑になれば問題ありません。

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

## 手順 3. `gh-pages` ブランチを作る（最初の一度だけ）

公開用のワークフローは、既にある `gh-pages` ブランチを**更新**することはできますが、
**新しく作ることはできません**。そのため、最初に一度だけ自分で用意します。

RStudio 下部の **Terminal** タブを開き、次を1行ずつ実行します。

```sh
git switch --orphan gh-pages
git commit --allow-empty -m "Initialise gh-pages branch"
git push origin gh-pages
git switch main
```

> `git switch --orphan` は作業ディレクトリを空にします。
> ファイルが消えたように見えますが、最後の `git switch main` で元に戻ります。

最後の `git switch main` を忘れないでください。
忘れたまま作業すると、`gh-pages` ブランチの上で編集してしまいます。

うまくいったか確認します。`main` と `gh-pages` の2つが出れば成功です。
`*` が `main` に付いていることも確かめてください。

```sh
git branch
```

## 手順 4. Pages の公開設定をする

1. 自分のリポジトリの **Settings** を開く
2. 左のメニューから **Pages** を選ぶ
3. **Source** を **Deploy from a branch** にする
4. **Branch** を **`gh-pages`**、フォルダを **`/ (root)`** にする
5. **Save** を押す

> **GitHub Actions** は選ばないでください。この公開方式と衝突します。

## 手順 5. Quarto が使えるか確認する

最近の RStudio には Quarto が同梱されているため、
**多くの場合インストールは不要**です。

**Terminal** タブで確認します。バージョン番号が出れば、そのまま使えます。

```sh
quarto --version
```

`command not found` と出た場合だけ、
<https://quarto.org/docs/get-started/> から入れてください。

## 手順 6. 内容を自分のものに書き換える

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

## 手順 7. 手元で表示を確認する

1. `index.qmd` をエディタで開く
2. エディタ上部の **Render** ボタンの右にある
   **Render on Save** のチェックボックスを **オン** にする
3. `Ctrl-S`（Mac は `Cmd-S`）で保存する

保存するたびに自動で書き出され、結果が右側の **Viewer** ペインに表示されます。
以降は「書き換える → `Ctrl-S` → Viewer を見る」の繰り返しで進められます。

> **Render on Save** はファイルごとの設定です。
> 別の `.qmd` を開いたときは、そちらでも改めてチェックを入れてください。

> Viewer ペインが狭くて見にくいときは、
> Viewer 左上のアイコンからブラウザで開けます。

## 手順 8. push する

**Terminal** タブで実行します。

```sh
git add .
git commit -m "自己紹介ページを書いた"
git push
```

SSH 鍵を設定してあれば、ユーザー名やパスワードは聞かれません。
`Permission denied (publickey)` と出た場合は、鍵が使える状態になっていません。
**Terminal** タブで接続を確かめてください。

```sh
ssh -T git@github.com
```

`Hi <ユーザー名>! You've successfully authenticated...` と返れば正常です。

## 手順 9. 公開されたか確認する

1. リポジトリの **Actions** タブを開く
2. 実行中の処理が緑色のチェックになるまで待つ（数分かかります）
3. `https://<ユーザー名>.github.io/` をブラウザで開く

表示が古いままのときは、ブラウザの再読み込み（`Ctrl-Shift-R`）を試してください。

以降は、手順 6 → 7 → 8 の繰り返しです。

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
├── website.Rproj        RStudio のプロジェクト設定
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
| Actions が失敗する | 手順 3 の `gh-pages` ブランチを作り忘れている |
| ページが 404 になる | 手順 4 の設定が `gh-pages` `/ (root)` になっているか確認 |
| README がそのまま表示される | 手順 4 の Source が `main` のままになっている |
| リポジトリ名を間違えた | Settings → General → Repository name で変更できる |
| ファイルが消えた | 手順 3 の途中で `git switch main` を忘れていないか確認 |
| `Permission denied (publickey)` | SSH 鍵が使えていない（手順 8 の `ssh -T` で確認する） |
| ユーザー名とパスワードを聞かれる | HTTPS の URL で clone している。`git remote set-url origin git@github.com:<ユーザー名>/<ユーザー名>.github.io.git` で切り替える |
| `git` が使えない | Console タブに打っていないか確認する（Terminal タブで実行する） |
| Terminal タブが無い | **Tools → Terminal → New Terminal**（`Alt-Shift-M`）で開く |
| Render ボタンが無い | `index.qmd` を開いているか確認する |
| 画像が出ない | `fig/` のファイル名と `index.qmd` の `src=` が一致しているか確認 |
| タブに名前が二重に出る | `_quarto.yml` の `title` と `index.qmd` の `pagetitle` を同じ文字列にする |
