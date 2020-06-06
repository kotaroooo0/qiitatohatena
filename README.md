# qiitatohatena

## 概要

Qiita からはてなブログへ記事を移行するための Docker イメージを作成するリポジトリ。
以下のコマンドでビルドすることができる。

```sh
# Build
$ docker build . -t qiitatohatena
```

実際にイメージを使う場合、自分でビルドしなくても DockerHub から `pull` すれば十分である。
以下のリポジトリで公開されている。
https://hub.docker.com/r/adachikun/qiitatohatena

また、`docker run` で対象のイメージが存在しない場合に自動的に DockerHub から pull されるため明示的に `pull` する必要はない。

以下のツールを利用しています。

- https://github.com/tenntenn/qiitaexporter
- https://github.com/x-motemen/blogsync

## 移行例

事前に行うこと

- 対象のはてなブログの記事入力モードを Markdown に変更
- Qiita の記事のタイトルが`[Docker]Qiitaからはてなブログへ記事を移行`のように`[]`から始まるものをだと yaml のパースの関係で上手くいかないので`【】`等に置換
- 環境変数が必要であるためカレントディレクトリに`.env`を作成

```sh
# .env
HATENA_BLOG_DOMAIN= # ex: kotaroooo0-dev.hatenablog.com
HATENA_USER_NAME= # ex: kotaroooo0
HATENA_API_KEY= # そのブログに投稿するための API キー。はてなユーザのパスワードではありません。ブログの詳細設定画面 の「APIキー」で確認できます。
QIITA_API_KEY= # https://qiita.com/settings/applications からトークン取得
```

```sh
$ docker run --env-file .env adachikun/qiitatohatena
```

## 注意

- `blogsync.template` で指定した`この記事は Qiita の記事をエクスポートしたものです。内容が古くなっている可能性があります。` が記事の最初に追加されます。変更したい場合は、`blogsync.template`を編集し、再ビルドしてください。

- Qiita の Markdown とはてなブログの Markdown で若干の差異があるのでレイアウトが崩れることがあります。

- 画像の URL は Qiita の`S3`のものを引き継いでいます。

- 記事の投稿日時を引き継いでいます。
