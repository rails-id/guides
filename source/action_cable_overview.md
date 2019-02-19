**DO NOT READ THIS FILE ON GITHUB, GUIDES ARE PUBLISHED ON https://guides.rubyonrails.org.**

Ikhtisar Action Cable
=======================

Di dalam panduan ini, Kamu akan belajar bagaimana Action Cable bekerja dan bagaimana menggunakan
WebSockets untuk menggabungkan dalam waktu yang sebenarnya di dalam aplikasi Rails Kamu.

Setelah membaca panduan ini, Kamu akan mengetahui tentang:

* Apa itu Action Cable untuk mengintergrasikan dengan backend dan frontend
* Bagaimana pemasangan Action Cable
* Bagaimana pemasangan Channels
* Pemasangan dan menjalankan Action Cable pada Arsitektur dan Deploy

--------------------------------------------------------------------------------

Pengenalan
----------

Action cable terintegrasi dengan mulus pada [WebSockets](https://en.wikipedia.org/wiki/WebSocket)
di aplikasi Rails Kamu. Hal ini memungkinkan untuk membuat fitur dalam waktu yang sebenarnya dengan
gaya dan bentuk aplikasi Kamu, sementara performa dan skala tetap terjaga. Hal ini mencakup keseluruhan
untuk framework client-side JavaScript dan framework server-side Ruby. Kamu mendapatkan akses penuh untuk
menulis model domain dengan Active Record atau Kamu dapat memilih Object-Relational-Mapping (ORM)
pilihan Kamu.

Apa itu Pub/Sub
---------------

[Pub/Sub](https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern), atau disebut Publish-Subscribe,
mengacu pada antrian pesan yang memilik paradigma dimana pengirim informasi (publisher),  mengirim data kepada
kelas yang abstrak ke penerima (subscriber), tanpa menentukan spesifikasi individu penerima. Action Cable
menggunakan pendekatan ini untuk berkomunikasi antara server dan banyak client.

## Komponen Sisi Server

### Koneksi

*Koneksi* adalah fondasi dasar hubungan dengan client-server. Agar semua Websocket di terima oleh server, koneksi
di pakai pada objek. Objek menjadi induk bagi semua *subscribe channel* yang di buat di dalamnya. Koneksi sendiri
tidak berurusan dengan logika apapun di dalam spesifikasi aplikasi di luar otentikasi dan otorisasi. Client dari
koneksi WebSocket di sebut koneksi *consumer*. Pengguna secara individu membuat satu pasang consumer-connection per
tab browser, jendela, atau perangkat yang di pakai untuk membuka.

#### Mempersiapkan Koneksi

```ruby
# app/channels/application_cable/connection.rb

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
      def find_verified_user
        if verified_user = User.find_by(id: cookies.encrypted[:user_id])
          verified_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
```

Di sini `identified_by` adalah koneksi indentifikasi yang dapat di gunakan untuk spesifikasi koneksi nanti.
Perhatikan bahwa apa pun yang ditandai sebagai pengenal identifikasi secara otomatis dibuat delegasi dengan
nama yang sama di dalam semua channel seperti contoh koneksi di atas.

Contoh di atas tergantung user yang telah di autentikasi dari aplikasi Kamu, dan sukses autentikasi di setujui
oleh cookie user ID.

Cookie user ID secara otomatis mengirim ke koneksi saat koneksi baru di coba, dan penggunaan `current_user` untuk
mengidentifikasi koneksi dengan user yang sama, dan juga memastikan Kamu dapat menerima semua koneksi dari user
(dan berpontensi diskoneksi ke semuanya jika user telah di hapus atau tidak di autentikasi).

### Channel

Sebuah *channel* merangkum unit logik dari sebuah pekerjaan, mirip dengan apa yang di lakukan oleh controller pada
MVC(Model View Controller). Secara default, Rails membuat sebuah kelas induk `ApplicationCable::Channel` untuk
bersama merangkum logic antara channel Kamu.

#### Memasang Induk Channel

```ruby
# app/channels/application_cable/channel.rb
module ApplicationCable
  class Channel < ActionCable::Channel::Base
  end
end
```

Kemudian Kamu dapat membuat kelas channel Kamu sendiri. berikut contoh, yang dapat Kamu buat
```ChatChannel` dan `ApperanceChannel`:

```ruby
# app/channels/chat_channel.rb
class CharChannel < ApplicationCable::Channel
end

# app/channels/apperance_channel.rb
class ApperanceChannel < ApplicationCable::Channel
end
```

Consumer kemudian dapat subscribe salah satu atau kedua channel ini.

#### Subscribe

Consumer yang subscribe pada channel di sebut *subscriber*. Dan koneksinya di sebut *subscription*.
Pesan yang dihasilkan kemudian dialihkan ke subscribe channel
berdasarkan pengenal yang dikirim oleh consumer cable.

```ruby
# app/channels/chat_channel.rb
class ChatChannel < ApplicationCable::Channel
  # Di panggil ketika consumer sukses
  # menjadi subscriber pada channel ini
  def subscribed
  end
end
```

## Komponen Client-Side

### Koneksi

Consumer memerlukan contoh koneksi dari sisi consumer. Ini bisa dibuat menggunakan
JavaScript berikut, yang dibuat secara default oleh Rails:

#### Koneksi Consumer

```js
// app/assets/javascripts/cable.js
//= require action_cable
//= require_self
//= require_tree ./channels

(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();
}).call(this);
```

Contoh di atas menyiapkan consumer yang akan terhubung dengan `/cable` di server Kamu
secara default. Koneksi tidak akan terjalin sampai mendapat minimal satu subscribe
yang telah di tentukan.

#### Subscriber

Consumer menjadi subscriber dengan membuat langganan ke channel yang diberikan:

```coffeescript
# app/assets/javascripts/cable/subscriptions/chat.coffee
App.cable.subscriptions.create { channel: "ChatChannel", room: "Best Room" }

# app/assets/javascripts/cable/subscriptions/appearance.coffee
App.cable.subscriptions.create { channel: "AppearanceChannel" }
```

Meskipun langganan telah di buat, fungsionalitas yang diperlukan untuk menanggapi data yang diterima
akan dijabarkan lagi.

Consumer dapat bertindak sebagai subscriber kapan saja pada setiap channel yang di berikan. Sebagai contoh,
consumer dapat subscribe beberapa ruang obrolan secara bersamaan:

```coffeescript
App.cable.subscriptions.create { channel: "ChatChannel", room: "1st Room" }
App.cable.subscriptions.create { channel: "ChatChannel", room: "2nd Room" }
```

## Interaksi Client-Server

### Streaming

*streaming* menyediakan mekanisme channel yang di kirimkan sebagai publikasi konten (broadcast)
ke customer yang subscriber.

```ruby
# app/channels/chat_channel.rb
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:room]}"
  end
end
```

Jika Kamu memiliki streaming yang berhubungan dengan model, maka broadcasting dapat menggunakan model dan channel tersebut.
Berikut contoh broadcasting pada channel subscribe `comments:Z2lkOi8vVGVzdEFwcC9Qb3N0LzE`

```ruby
class CommentsChannel < ApplicationCable::Channel
  def subscribed
    post = Post.find(params[:id])
    stream_for post
  end
end
```

Kamu dapat melakukan broadcast pada channel di atas seperti ini:

```ruby
CommentsChannel.broadcast_to(@post, @comment)
```

### Broadcasting

*Broadcasting* adalah tautan pub/sub di mana segala sesuatu yang ditransmisikan oleh penerbit dan dikirim langsung
ke channel subscriber streaming yang bernama broadcasting. Setiap channel dapat melakukan streaming dari nol
hingga lebih banyak broadcasting.

Broadcasting adalah murni antrean online dan tergantung waktu. Jika consumer tidak streaming (subscribe channel
yang diberikan), mereka tidak akan mendapatkan broadcast jika mereka terhubung nanti.

Panggil broadcast di Aplikasi rails Kamu di mana saja:

```ruby
WebNotificationsChannel.broadcast_to(
  current_user,
  title: 'New things!',
  body: 'All the news fit to print'
)
```

Panggilan `webNotificationsChannel.broadcast_to` menempatkan pesan pada adaptor subscribe (secara default `redis`
untuk production dan `async` untuk environment development dan test) antrean pub/sub di pisahkan oleh nama channel
untuk masing-masing user. Untuk dengan ID 1, nama channel menjadi `web_notification:1`.

Channel telah diinstruksikan untuk streaming semua yang datang pada `web_notifications:1`. langsung ke client
dengan memohon `received` kembali.

### Subscribe

Ketika consumer subscribe di sebuah channel, consumer menjadi subscriber. Koneksi ini di sebut subscribe.
Pesan yang masuk kemudian dialihkan ke subscribe channel ini berdasarkan pengenal yang dikirim oleh consumer.

```coffeescript
# app/assets/javascripts/cable/subscriptions/chat.coffee
# Asumsi Kamu telah mengirim request pada notifikasi web
App.cable.subscriptions.create { channel: "ChatChannel", room: "Best Room" },
  received: (data) ->
    @appendLine(data)

  appendLine: (data) ->
    html = @createLine(data)
    $("[data-chat-room='Best Room']").append(html)

  createLine: (data) ->
    """
    <article class="chat-line">
      <span class="speaker">#{data["sent_by"]}</span>
      <span class="body">#{data["body"]}</span>
    </article>
    """
```

### Memberikan Parameter untuk Channel

Kamu dapat memberikan parameter dari client-side ke server-side dengan membuat langganan. Sebagai contoh:

```ruby
# app/channels/chat_channel.rb
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:room]}"
  end
end
```

Kemudian objek di teruskan ke`subscriptions.create`
dan menjadi parameter hash di dalam channel. Keyword `channel` di haruskan:

```coffeescript
# app/assets/javascripts/cable/subscriptions/chat.coffee
App.cable.subscriptions.create { channel: "ChatChannel", room: "Best Room" },
  received: (data) ->
    @appendLine(data)

  appendLine: (data) ->
    html = @createLine(data)
    $("[data-chat-room='Best Room']").append(html)

  createLine: (data) ->
    """
    <article class="chat-line">
      <span class="speaker">#{data["sent_by"]}</span>
      <span class="body">#{data["body"]}</span>
    </article>
    """
```

```ruby
# Misal di app Kamu seperti
# dari NewCommentJob
ActionCable.server.broadcast(
  "chat_#{room}",
  sent_by: 'Paul',
  body: 'This is a cool chat app.'
)
```

### Rebroadcasting Message

Kasus yang biasa terjadi adalah *rebroadcast* sebuah pesan oleh satu client ke client lain
yang sama-sama terkoneksi.

```ruby
# app/channels/chat_channel.rb
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:room]}"
  end

  def receive(data)
    ActionCable.server.broadcast("chat_#{params[:room]}", data)
  end
end
```

```coffeescript
# app/assets/javascripts/cable/subscriptions/chat.coffee
App.chatChannel = App.cable.subscriptions.create { channel: "ChatChannel", room: "Best Room" },
  received: (data) ->
    # data => { sent_by: "Paul", body: "This is a cool chat app." }

App.chatChannel.send({ sent_by: "Paul", body: "This is a cool chat app." })
```

Broadcast ulang akan di terima oleh semua yang terkoneksi bersama, _termasuk_ client yang mengirim pesan tersebut.
Perhatikan bahwa parameter sama seperti ketika
Kamu subscribe channel.

## Contoh Full-Stack

Langkah-langkah pengaturan umum pada kedua contoh:

  1. [Memasang koneksi](#memasang-koneksi).
  2. [Memasang induk channel](#memasang-induk-channel).
  3. [Hubungkan consumer](#hubungkan-consumer).

### Contoh 1: Menampilkan User

Berikut adalah contoh sederhana channel yang melacak apakah pengguna sedang online atau tidak dan di halaman
mana mereka berada. (Ini berguna untuk membuat fitur kehadiran seperti menunjukkan
titik hijau di sebelah nama pengguna jika sedang online)

Buat tampilan channel server-side:

```ruby
# app/channels/appearance_channel.rb
class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    current_user.appear
  end

  def unsubscribed
    current_user.disappear
  end

  def appear(data)
    current_user.appear(on: data['appearing_on'])
  end

  def away
    current_user.away
  end
end
```

Ketika pelangggan mulai `subscribe` panggilan ulang dibatalkan dan mendapatkan kesempatan untuk
"user saat ini telah di tampilkan". API yang muncul/hilang bisa didukung oleh Redis, sebuah database,
atau yang lainnya.

Membuat tampilan subscribe client-side pada channel:

```coffeescript
# app/assets/javascripts/cable/subscriptions/appearance.coffee
App.cable.subscriptions.create "AppearanceChannel",
  # Dipanggil saat langganan telah siap untuk di gunakan pada server.
  connected: ->
    @install()
    @appear()

  # Dipanggil saat WebSocket koneksi tertutup.
  disconnected: ->
    @uninstall()

  # Dipanggil ketika subscribe di tolak oleh server.
  rejected: ->
    @uninstall()

  appear: ->
    # Calls `AppearanceChannel#appear(data)` on the server.
    @perform("appear", appearing_on: $("main").data("appearing-on"))

  away: ->
    # Calls `AppearanceChannel#away` on the server.
    @perform("away")


  buttonSelector = "[data-behavior~=appear_away]"

  install: ->
    $(document).on "turbolinks:load.appearance", =>
      @appear()

    $(document).on "click.appearance", buttonSelector, =>
      @away()
      false

    $(buttonSelector).show()

  uninstall: ->
    $(document).off(".appearance")
    $(buttonSelector).hide()
```

##### Client-Server Interaksi

1. **Client** dihubungkan dengan **Server** via `App.cable =
ActionCable.createConsumer("ws://cable.example.com")`. (`cable.js`). dan
**Server** mengindentifikasi koneksi ini oleh `current_user`.

2. **Client** subscribe ke channel yang ditampilkan via
`App.cable.subscriptions.create(channel: "AppearanceChannel")`. (`appearance.coffee`)

3. **Server** menerima sebuah langganan baru telah terpasang untuk di tampilkan pada channel dan
menjalankan `subscribe` memanggil ulang, memanggil `appear`
metode pada`current_user`. (`appearance_channel.rb`)

4. **Client** mengakui bahwa sebuah langganan telah terpasang  dan dipanggil
`connected` (`appearance.coffee`) yang mendapat giliran `@install` dan `@appear`.
`@appear` dipanggil `AppearanceChannel#appear(data)` di dalam server, dan persediaan hash data pada
`{ appearing_on: $("main").data("appearing-on") }`. Hal ini dimungkinkan karena contoh channel server-side
secara otomatis memaparkan semua metode publik yang dideklarasikan di kelas (minus panggilan balik),
sehingga dapat tercapai dengan remote prosedur yang dipanggil lewat metode `perform` pada langganan.

5. **Server** menerima request untuk aksi`appear` pada tampilan channel agar koneksi diidentifikasi
oleh `current_user` (`appearance_channel.rb`). **Server** mengambil data pada `:appearing_on` key dari hash
data telah di tetapkan sebagai nilai pada `:on` key diteruskan ke`current_user.appear`.

### Example 2: Menerima Pemberitahuan Baru Web

Contoh tampilan adalah tentang mengekspose fungsionalitas server ada client-side melalu koneksi WebSocket.
Tapi yang menarik tentang WebSocket adalah memiliki dua arah jalan. Sekarang mari kita lihat sebuah contoh
di mana server meminta tindakan pada client.

Dibawah ini adalah channel web notifikasi yang mengizinkan Kamu untuk memicu client-side notifikasi web
ketika Kamu broadcast ke streaming yang tepat:

Membuat channel server-side web notifikasi:

```ruby
# app/channels/web_notifications_channel.rb
class WebNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end
end
```

Membuat channel subscribe client-side web notifikasi:

```coffeescript
# app/assets/javascripts/cable/subscriptions/web_notifications.coffee
# Asumsi client-side Kamu telah melakukan request
# dengan benar ke web notifikasi
App.cable.subscriptions.create "WebNotificationsChannel",
  received: (data) ->
    new Notification data["title"], body: data["body"]
```

Konten broadcast untuk channel web notifikasi misalnya dari aplikasi Kamu:

```ruby
# Misal di app Kamu dari NewCommentJob
WebNotificationsChannel.broadcast_to(
  current_user,
  title: 'New things!',
  body: 'All the news fit to print'
)
```

Panggilan `WebNotificationsChannel.broadcast_to` menempatkan pesan di antrian pub / sub adaptor subscribe
saat ini, di bawah nama broadcast yang terpisah untuk setiap pengguna. Untuk pengguna user ID 1,
nama broadcastnya adalah `web_notifications: 1`.

Channel telah diinstruksikan untuk melakukan streaming untuk semua yang di terima di `web_notifications: 1`
langsung ke client dengan memohon panggilan balik` received`. Data yang dikirimkan sebagai argumen adalah hash
yang dikirim sebagai parameter kedua ke panggilan broadcast server-side, JSON disandikan untuk melewati jalur
yang di lewati dan dibuka untuk argumen data yang tiba sebagai `received`.

### Contoh Yang Lebih Komplet

Lihat di [rails/actioncable-examples](https://github.com/rails/actioncable-examples)
repository yang lebih lengkap dengan contoh bagaiamana memasang Action Cable pada Rails aplikasi dan
menambahkan channel.

## Konfigurasi

Action Cable memiliki dua konfigurasi yang diperlukan: adapter subscribe dan mengizinkan permintaan yang masuk.

### Adaptor Berlangganan

Secara default, Action Cable mencari konfigurasi file di `config/cable.yml`.
File harus di tetapkan untuk setiap adaptor Rails environment. Lihat di [Dependensi](#dependensi) bagian
untuk menambahkan informasi didalam adaptor.

```yaml
development:
  adapter: async

test:
  adapter: async

production:
  adapter: redis
  url: redis://10.10.3.153:6381
  channel_prefix: appname_production
```

#### Adaptor Konfigurasi

Below is a list of the subscription adapters available for end users.

##### Async Adapter

Adaptor async dimaksudkan untuk development/testing dan tidak boleh digunakan dalam production.

##### Redis Adaptor

Adaptor Redis mengharuskan pengguna untuk menyediakan URL yang menunjuk ke server Redis.
Selain itu, `channel_prefix` dapat disediakan untuk menghindari tabrakan nama channel
saat menggunakan server Redis yang sama untuk beberapa aplikasi.
Lihat [Dokumentasi Redis PubSub](https://redis.io/topics/pubsub#database-amp-scoping) untuk detail lebih lanjut.

##### PostgreSQL Adaptor

Adaptor PostgreSQL menggunakan kumpulan koneksi Active Record's, dan konfigurasi database
`config / database.yml`aplikasi, untuk koneksinya. Ini mungkin berubah di masa depan.
[# 27214](https://github.com/rails/rails/issues/27214)

### Menerima Request Dari Sumber

Action Cable hanya akan menerima permintaan dari sumber yang ditentukan, yang diteruskan ke konfigurasi
server sebagai array. Sumber dapat berupa contoh string atau ekspresi reguler, yang dicek kecocokan dan
akan digunakan.

```ruby
config.action_cable.allowed_request_origins = ['http://rubyonrails.com', %r{http://ruby.*}]
```
Untuk dinonaktifkan dan diterima request dari sumber:

```ruby
config.action_cable.disable_request_forgery_protection = true
```
Secara default, Action Cable memungkinkan semua permintaan dari localhost: 3000 saat berjalan di
development environment.

### Consumer Konfigurasi

Untuk mengkonfigurasi URL, tambahkan panggilan ke `action_cable_meta_tag` di layout HTML HEAD.
Ini menggunakan URL atau jalur yang biasanya ditetapkan melalui `config.action_cable.url` di
file konfigurasi environment.

### Konfigurasi Lainnya

Opsi umum lainnya untuk mengonfigurasi adalah tag log yang diterapkan ke logger per-koneksi.
Berikut adalah contoh yang menggunakan id akun user jika tersedia, dan jika tidak
"tidak ada akun" saat memberi tag:

```ruby
config.action_cable.log_tags = [
  -> request { request.env['user_account_id'] || "no-account" },
  :action_cable,
  -> request { request.uuid }
]
```

Untuk daftar lengkap semua opsi konfigurasi, lihat
Class `ActionCable :: Server :: Configuration`.

Juga, perhatikan bahwa server Anda harus menyediakan setidaknya jumlah koneksi database yang
sama seperti di pakai. Ukuran yang dipakai secara default diatur ke 4 pool, jadi itu berarti
Anda harus membuat setidaknya tersedia. Anda dapat mengubahnya di `config / database.yml`
melalui atribut` pool`.

## Menjalankan Cable Server Mandiri

### Di Aplikasi

Action Cable dapat berjalan di samping aplikasi Rails Kamu. Misalnya, untuk mendapat permintaan
WebSocket di `/websocket`, tentukan path itu ke` config.action_cable.mount_path`:

```ruby
# config/application.rb
class Application < Rails::Application
  config.action_cable.mount_path = '/websocket'
end
```

Kamu dapat menggunakan `App.cable = ActionCable.createConsumer ()` untuk terhubung ke cable
server jika `action_cable_meta_tag` dipanggil dalam layout. Jalur khusus ditetapkan sebagai
argumen pertama untuk `createConsumer` (mis.` App.cable = ActionCable.createConsumer ("/ websocket") `).

Untuk setiap permintaan dari server yang Kamu buat dan untuk setiap pekerjaan yang dihasilkan oleh
server Kamu, Kamu juga akan memiliki permintaan baru dari Action Cable, tetapi penggunaan Redis
membuat pesan disinkronkan di seluruh koneksi.

### Mandiri

Cable server dapat dipisahkan dari server aplikasi normal Kamu. Dan
masih merupakan sebuah Rack aplikasi, tetapi itu aplikasi Rack-nya sendiri. Direkomendasikan
pengaturan dasar adalah sebagai berikut:

```ruby
# cable/config.ru
require_relative '../config/environment'
Rails.application.eager_load!

run ActionCable.server
```

Kemudian Kamu dapat menjalankan server menggunakan sebuah binstub `bin/cable` seperti ini:

```
#!/bin/bash
bundle exec puma -p 28080 cable/config.ru
```

The above will start a cable server on port 28080.

### Catatan

Server WebSocket tidak memiliki akses ke session, tetapi mendapat
akses ke cookies. Ini dapat digunakan saat Kamu perlu mengerjakan
otentikasi. Kamu dapat melihat salah satu cara melakukannya dengan Devise
dalam [artikel] ini (http://www.rubytutorial.io/actioncable-devise-authentication).

## Dependensi

Action Cable menyediakan antarmuka adaptor subscribe untuk memprosesnya
pubsub internal. Secara default, asinkron, inline, PostgreSQL, dan Redis
Adaptor juga termasuk. Adaptor default
dalam aplikasi Rails baru adalah adaptor asinkron (`async`).

Hal dari sisi Ruby yang dibangun di atas
[websocket-driver](https://github.com/faye/websocket-driver-ruby),
[nio4r](https://github.com/celluloid/nio4r), dan
[concurrent-ruby](https://github.com/ruby-concurrency/concurrent-ruby).

## Deployment

Action Cable ditenagai oleh kombinasi WebSockets dan threads. Keduanya
framework plumbing dan pekerjaan channel yang pengguna yang ditentukan ditangani secara
internal oleh memanfaatkan dukungan threads Ruby. Ini berarti Kamu dapat menggunakan semua
yang biasa Kamu lakukan di Model rails tanpa masalah, selama Kamu tidak melakukan kesalahan penulisan.

Server Action Cable mengimplementasikan API pembajakan soket Rack,
dengan demikian memungkinkan penggunaan pola multithreaded untuk mengelola koneksi
secara internal, terlepas dari apakah server aplikasi multi-threaded atau tidak.

Karenanya, Action Cable bekerja dengan server populer seperti Unicorn, Puma, dan
Passengger.
