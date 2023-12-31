# FF14一緒にやりませんか？
## サービス概要
ファイナルファンタジーⅩⅣにおいてまだクリアしていないコンテンツをやりたい時に、パーティメンバーを募集するためのマッチングアプリです。

## ファイナルファンタジーⅩⅣとは
ファイナルファンタジーⅩⅣ(以下FF14)は、スクエア・エニックスが開発したファイナルファンタジーシリーズの14作目のタイトルであり、ファイナルファンタジーⅩⅠ以来2作目のMMORPGです。   
サービス開始から10年以上経った今でも、プレイヤー数が右肩上がりに増え続けている人気ゲームです。

## 想定されるユーザー層
FF14をプレイしていて、やりたいコンテンツがあるが、マッチング時間が長く諦めている人    
パーティー募集に入るのはちょっと気が引ける人

## このサービスを作ろうと思った理由   
サービス開始から10年間のアップデートで、メインクエスト以外にも様々なコンテンツが追加されています。    
しかし、昔のコンテンツは人が集まらなくなっているため、マッチングに時間がかかることがあります。    
また、ゲーム内にパーティー募集機能はありますが、募集内容が少なく、やりたいコンテンツが見つけにくいという問題があります。    
そこで、やりたいコンテンツや活動日時、メインジョブなどによって自動的にパーティメンバーを集めることができるマッチングアプリを作ろうと思いました。 

## そもそもFF14内のマッチング機能とはなんなのか
FF14内には、コンテンツに行くためのマッチング機能があります。    
これは、自分が行きたいコンテンツを選択し、申し込みをすることで、サーバーのマッチングシステムによって、そのコンテンツに対して申し込みをしている人の中から、既定の割合でロールを選択し、マッチングが行われるシステムです。    
しかしこのマッチング機能は、前述した通り昔のコンテンツでは人が集まらなくなっているため、マッチング時間が長くなっているのが現状です。

## 他のサービスとの差別化ポイント
FF14公式のパーティー募集ページや、ゲーム内の募集ページも存在するが、これらのサービスは過去のコンテンツの募集が少なく感じました。    
また、自分から参加するという形式であるため、参加しにくいと感じる人もいると思います。    
そこで、自分のやりたいコンテンツを登録するだけで、自動的にパーティーメンバーを集めることができるマッチングアプリなら、参加しやすいのではないかと考えました。

## ユーザーの獲得方法について
- ゲーム内で宣伝する
- FF14公式サイトのフォーラムにて、このサービスを紹介する
- Xにて、このサービスを紹介する

## 実装予定の機能
### MVP
- トップページ
- 会員登録・ログイン機能
- ユーザーのプロフィール編集機能
- マッチング機能
- マッチング内でのチャット機能(ActionCable) 
- ユーザーのブロック機能
- Admin側でのユーザー管理機能
- 運営への報告機能    
<マッチング機能の詳細>    
ユーザーは、やりたいコンテンツのページにて、使用するジョブ、データセンター、活動時間を選択し、マッチングを開始します。    
必要なジョブと活動時間が揃った時点で、マッチングが成立します。    
マッチングが成立すると、パーティー内チャットが開放され、パーティーメンバー同士でコンテンツの詳細や活動時間を話し合うことができます。    
### 本リリース時に実装予定の項目
- LINEとの連携機能→マッチングが成立した際にLINEで通知が届くようにする
- 外部サービスでのログイン機能→XやGoogleアカウントでログインできるようにする
- 利用規約
- プライバシーポリシー
- アプリ上での通知機能

## 使用予定の技術
### フロントエンド
- JavaScript:ES6
- React(予定)→現在学習中のため、一旦はRailsのみで実装する

### バックエンド
- Rails: 7.0系
- Ruby: 3.2.2
- データベース： PostgreSQL

### インフラ
- Heroku
- AWS S3

### その他使用予定の技術
- LINE通知: LINE Messaging API
- チャット機能: WebSocket(ActionCable)

## 画面遷移図
Figma:https://www.figma.com/file/O2lB9Yh4DhWjZJ2S4sDLdl/Untitled?type=design&node-id=0%3A1&mode=design&t=hxarVRb6Huq3g6LK-1

## ER図
[![Image from Gyazo](https://i.gyazo.com/0cfeebc56e7f73eb6d963a9556f4e06b.png)](https://gyazo.com/0cfeebc56e7f73eb6d963a9556f4e06b)