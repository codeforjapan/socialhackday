# HOW TO deploy

master ブランチを更新することで、自動的に AWS S3 にビルド済のHTMLファイルをアップロードします。
また、深夜1時に自動的にイベント及びプロジェクトを最新の情報に更新します。

## Diagram（参考）
![_SocialHackDay server architecture](https://i.gyazo.com/9663cfff9b21eddd17e6976ab8ffb0f7.png)

## Events 及び Projects 情報
イベントとプロジェクトの情報は、ビルド時に 以下の Google Spreadsheet から取得されます。

https://docs.google.com/spreadsheets/d/18H2q-3b6uxvAJENm2aQmVcSph7vFpOvB49lxZ4ns1ak/edit#gid=1503426383

上記 Spreadsheet の Events シートから、未来日の日付の情報を取得しイベント情報を、 Projects シートから、全てのプロジェクトの情報を取得しプロジェクト一覧を作成します。
Spreadsheet を更新しても、すぐにはサーバには反映されません。github の master ブランチを更新しない限り、深夜1時に自動的に更新されるのを待つ必要があります。

上記 Spreadsheet を更新できるのは、原則としてプロジェクトのチームリーダーになります。編集するためには、Social Hack Day に参加してシートの編集権限を貰う必要があります。
