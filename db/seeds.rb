# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by!(email: 'admin@example.com') do |a|
    a.password = '123456'
end

users = [
  {email: 'user1@example.com', password: 'user1@example.com', name: 'コーヒー大好き', profile: "コーヒー大好きさん\n豆にはこだわりを。"},
  {email: 'user2@example.com', password: 'user2@example.com', name: 'ハンドドリップ', profile: "ハンドドリップ大好きさん\n最近ハマってるです。"},
]

users.each do |user|
  User.find_or_create_by(email: user[:email]) do |u|
    u.password = user[:password]
    u.name = user[:name]
    u.profile = user[:profile]
  end
end

recipes = [
  # 1つめ
  {
    user_id: User.find_by(email: 'user1@example.com').id,
    recipe: [
      image: 'clay-banks-_wkd7XBRfU4-unsplash.jpg',
      title: '世界一おいしいコーヒーの淹れ方',
      contents: <<"EOS",
バリスタが教える世界一おいしいハンドドリップのレシピです。
100gのお湯に対して6~8gのコーヒー豆を使用します。
薄めが好きな方はお湯100gに対しコーヒー豆6g、濃いめが好きな方はコーヒー豆8gで計算してください。
抽出は3投に分けて行います。蒸らし時間を多めに取るので抽出時間は3~4分が目安です。
1投目：20%(蒸らし)
2投目：20%
3投目：60%
EOS
      evaluation: 5,
      tags: "ペーパードリップ ホットコーヒー",
      recipe_processes: [
        {
          process: "①ドリッパーを温める",
          description: <<"EOS"
ドリッパーにペーパーフィルターをセットして、全体にお湯をかけて温めます。
EOS
        },
        {
          process: "②挽いたコーヒー豆を入れてならす",
          description: <<"EOS"
温まったドリッパーにコーヒー豆を入れて、表面をならします。
真っ直ぐ平坦なコーヒーベッドを作っておく。
ドリッパーの根本をを持って左右に数回振るとやりやすいです。
EOS
        },
        {
          process: "③1投目抽出(20%)",
          description: <<"EOS"
真ん中から円を描くように全体にお湯をかける。
必ず壁までかけてください。
蒸らしは粉全体を均等に濡らすことが目的なので、お湯を注いだらドリッパーを少し揺らします。
蒸らし時間は1分。
EOS
        },
        {
          process: "④2投目抽出(20%)",
          description: <<"EOS"
一投目と同じ方法で注ぎ、１分おいて下さい。
壁までお湯を注ぐことで壁に着いた微粉が流され、全ての粉がお湯に触れることで濃厚感のあるコーヒーが楽しめます。
EOS
        },
        {
          process: "⑤3投目抽出(60%)",
          description: <<"EOS"
同じ方法で、スピードは少し早めで注ぎましょう。
お湯を全て注いだらコーヒーが落ちきるまで待ちましょう。
お湯を注いだ後、ドリッパーを３回ほど揺らしてあげて下さい。
EOS
        },
      ]
    ]
  },

  # 2つめ
  {
    user_id: User.find_by(email: 'user2@example.com').id,
    recipe: [
      image: 'nathan-dumlao-nBJHO6wmRWw-unsplash.jpg',
      title: '失敗しないおうちコーヒーレシピ',
      contents: <<"EOS",
お店で提供しているレシピです。
使用している豆もお店で販売しているものを使用しています。
是非参考にしてください！
豆：20g
お湯：84℃
EOS
      evaluation: 5,
      tags: "ペーパードリップ ホットコーヒー",
      recipe_processes: [
        {
          process: "①ドリッパーにペーパーをセット",
          description: <<"EOS"
ペーパーは重なっている部分を左右どちらかに倒し、折り目をつけましょう。
しっかり押しつけて広げるイメージで。
EOS
        },
        {
          process: "②軽く叩いて粉を平らにならします",
          description: <<"EOS"
EOS
        },
        {
          process: "③30g注いで30秒蒸らします",
          description: <<"EOS"
一気に注がず豆の膨らみを見ながらゆっくり注湯する。
EOS
        },
        {
          process: "④少しずつ膨らみ(ドーム)を大きくしながら注湯を繰り返す",
          description: <<"EOS"
真ん中から500円玉大くらいで注湯する。
EOS
        },
        {
          process: "⑤規定量(300g)がきたら途中で外します(落とし切らない)",
          description: <<"EOS"
2~3分で抽出完了すればOK
EOS
        },
      ]
    ]
  }
]

recipes.each do |recipe|
  recipe[:recipe].each do |recipe_recipe|
    recipe_recipe_data = Recipe.find_or_initialize_by(title: recipe_recipe[:title]) do |r|
      r.user_id = recipe[:user_id]
      r.title = recipe_recipe[:title]
      r.contents = recipe_recipe[:contents]
      r.evaluation = recipe_recipe[:evaluation]
    end

    if recipe_recipe_data.save
      recipe_recipe_data.save_tags(recipe_recipe[:tags])
      recipe_recipe_data.recipe_image.attach(io: File.open(Rails.root.join("db/seeds/#{recipe_recipe[:image]}")),
                    filename: recipe_recipe[:image])
    end

    recipe_recipe[:recipe_processes].each do |recipe_recipe_recipe_process|
      recipe_process_data = recipe_recipe_data.recipe_processes.find_or_initialize_by(process: recipe_recipe_recipe_process[:process]) do |rp|
        rp.description = recipe_recipe_recipe_process[:description]
      end
      recipe_process_data.save
    end
  end
end

equipment = [
  {
    user_id: User.find_by(email: 'user1@example.com').id,
    image: "christina-rumpf-LMzwJDu6hTE-unsplash.jpg",
    name: "三洋産業 CAFEC トライタンフラワードリッパー",
    description: <<"EOS",
花びらの様な円すい形のドリッパー。
珈琲の層が深く、お湯を注ぐと円すいの頂点に
向かって流れる為、コーヒー豆本来の旨味を
しっかりと抽出することができます。軽くて
扱いやすく、割れづらいトライタン樹脂製です。
色展開が多いのもうれしい！

EastmanTritan™ コポリエステルは、卓越した強靭性、耐薬品性、耐熱性、
高透明性を備えた樹脂です。BPA(ビスフェノールA)を含有せず安全性も高いため、
乳児用品や医療製品にも使用されています。
EOS
    evaluation: 5
  },
  {
    user_id: User.find_by(email: 'user2@example.com').id,
    image: "nathan-dumlao-KixfBEdyp64-unsplash.jpg",
    name: "三洋産業 ドリップポット シルバー 750ml CAFEC 超細口ドリップポット",
    description: <<"EOS",
高品質のステンレス加工で有名な新潟県燕市で一つ一つ手作りされているドリップポットで、とてもお湯を注ぎやすいです！
「お湯をゆっくりと、細く、注ぐ」ハンドドリップをする上で重要なポイントの一つです。
多くの方が、自分はプロじゃないからハンドドリップは難しくてできない、と思っているのではないでしょうか。
だとしたら、誰にでも理想の注水ができるポットができればいいのでは！という目的で製作されたため、だれでも簡単にプロのようなドリップができるようになります。
品物はとてもいいのですが価格は高額なため評価は4.5にしましたが、是非使ってみて下さい！
EOS
    evaluation: 5
  },
]

equipment.each do |equipment|
  equipment_data = Equipment.find_or_initialize_by(name: equipment[:name]) do |e|
    e.user_id = equipment[:user_id]
    e.description = equipment[:description]
    e.evaluation = equipment[:evaluation]
  end

  equipment_data.equipment_image.attach(io: File.open(Rails.root.join("db/seeds/#{equipment[:image]}")),
                filename: equipment[:image]) if equipment_data.save
end

notes = [
  {
    user_id: User.find_by(email: 'user1@example.com').id,
    title: "コーヒーは豆の鮮度が命",
    contents: <<"EOS",
<div class="trix-content">
  <div>コーヒーおいしく味わうために<strong><em>一番大切</em></strong>なのは何かみなさんご存じですか？<br>コーヒーを淹れるとき、豆の種類や抽出に使うアイテムに気を配りドリップしますが<strong>実は、コーヒーの味にとって一番大切なのは豆の鮮度</strong>です！<br>豆がどんなに高価でも焙煎されてから<strong>時間が経っていると本来の味と全く異なるものに変化</strong>してしまいます！<br>逆に、それほど高いものでなくても<strong>鮮度に注意すればおいしく味わうことができる</strong>ということになります。<br><br>さらに、よくスーパーで売られているコーヒーなどは既に粉の状態にされているものが多いですが<br>コーヒー豆は挽いて粉の状態にすると空気と触れ合う面積が増えて、酸化が早くなってしまいます。<br><br>この「<strong>酸化</strong>」がコーヒーの味を変化させてしまう大きな要因です。<br><br>よりおいしい<strong>コーヒーを楽しむには、豆の状態で購入してドリップする直前にミルで豆を挽くことがオススメ</strong>です！<br>少し金額を出す必要はありますが、味が激変するので挑戦してみてください♪</div>
</div>
EOS
  },
  {
    user_id: User.find_by(email: 'user2@example.com').id,
    title: "最初に買いそろえるアイテムは？",
    contents: <<"EOS",
<div class="trix-content">
  <div>ハンドドリップを始めるときに揃えるべきグッズを紹介します！<br>結論から話すと、次の4つのアイテムがあればおうちコーヒーを楽しむことができます♪</div><ul>
<li>コーヒースケール</li>
<li>コーヒーサーバー</li>
<li>ドリッパー</li>
<li>ミル</li>
</ul><div>
<br>それぞれのアイテムについて紹介します！<br><br>
</div><h1>コーヒースケール</h1><div>コーヒースケールは簡単に言うと計りとタイマーが合体したようなものです。<br>普通のタイマーやスケールと違うのは抽出量と抽出時時間を同時に計ることができる点です。<br>コーヒーにとっては蒸らし時間だったり抽出量をきちんと計ることがことが非常に大切です。<br>コーヒースケールなしでもコーヒーを作ることはできますがこれがあると非常に便利ですので、使ってみてください！<br><br>
</div><h1>コーヒーサーバー</h1><div>形がフラスコみたいやつですね！<br>これは一人分で楽しむ場合は必要ないですが、たくさん抽出する場合はあると便利です。<br>経験談ですが、コーヒーサーバーはガラス製のものだと割れたりしてしまうので、プラスチック製のものがオススメです。<br><br>
</div><h1>ドリッパー</h1><div>これはペーパーに粉を置いてお湯を注ぐためのものです。<br>それぞれの形状で抽出の味わいが違うとも言われ、さらにプラスチック製のものや陶器製のもの様々な展開があり悩ましいですが、<br>見た目が好きなものや単純にコスパのいいものを用意してください！<br><br>
</div><h1>ミル</h1><div>ミルはコーヒー豆を粉にするための道具です。<br>ミルは他の３つより価格が高いので、後回しにしてもいいと思います！<br>さらに手動や電動のものがありますが、個人的にはTIMEMOREから販売されている手動ミルが価格に対して性能が高くオススメです！</div>
</div>
EOS
  },
]

notes.each do |note|
  Note.find_or_create_by(title: note[:title]) do |n|
    n.user_id = note[:user_id]
    n.contents = note[:contents]
  end
end