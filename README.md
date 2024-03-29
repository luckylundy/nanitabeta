# 概要

これは「何食べた？」という名前のアプリです。  
食事の写真を投稿し食事日記として使っていただくことを想定しています。 

特徴はユーザーが投稿者の写真に対し3回しかコメントできないようにすることです。  
既存のSNSと比べて交流に制限を加えることで「半クローズド」な環境を作り、  
デジタルコンテンツに苦手意識を持っている方にも使いやすいアプリにすることを心掛けました。
 
# 使用技術
 
windows10 home  
Ubuntu 20.04.1 on WSL2  
rails 6.0.3  
ruby 2.6.6  
MySQL 8.0.23  
 
# 機能一覧
 
ユーザー登録、ログイン機能(devise)  
ユーザー編集時画像確認機能(JavaScript)
画像投稿機能(carrierwave/mini_magick)  
いいね機能(Ajax)  
お気に入り機能(Ajax)  
コメント機能  
ページネーション機能(kaminari)  
タグ機能(acts-as-taggable-on)  
 
# 今後追加していく予定の機能
 
コメント回数を制限する機能  
  □ 投稿者は自分の投稿に対するコメントに無制限にコメントできる  
  □ ユーザーは投稿者の投稿に対し、3回までしかコメントできない  
タグ検索機能(ransuck)  
  □ ユーザーが見たい写真に絞って表示できるようにするため
レスポンシブ対応の画面表示  
  □ スマホユーザーにもストレスなく使用してもらうため
googleマップとの連動機能  
  □ 位置を明確化することで投稿者及びフォロワーが再度その場所へ行きやすくするため  
 
# 今後追加していく予定の機能(インフラ)
 
Docker  
➝アプリケーションの軽量・高速化
AWS  
➝デプロイ用
CircleCI  
➝テスト・デプロイの自動化
 

