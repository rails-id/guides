**DO NOT READ THIS FILE ON GITHUB, GUIDES ARE PUBLISHED ON https://guides.rubyonrails.org.**

Ikhtisar Action Cable
=======================

Di dalam panduan ini, kamu akan belajar bagaimana Action Cable bekerja dan bagaimana menggunakan
WebSockets untuk menggabungkan dalam waktu yang sebenarnya di dalam aplikasi Rails kamu.

Setelah membaca panduan ini, kamu akan mengetahui tentang:

* Apa itu Action Cable untuk mengintergrasikan dengan backend dan frontend
* Bagaimana pemasangan Action Cable
* Bagaimana pemasangan Channels
* Pemasangan dan menjalankan Action Cable pada Arsitektur dan Penyebaran

--------------------------------------------------------------------------------

Pengenalan
----------

Action cable terintegrasi dengan mulus pada [WebSockets](https://en.wikipedia.org/wiki/WebSocket)
di aplikasi Rails kamu. Hal ini memungkinkan untuk membuat fitur dalam waktu yang sebenarnya dengan
gaya dan bentuk aplikasi kamu, sementara performa dan skala tetap terjaga. Hal ini mencakup keseluruhan
bagi sisi klien kerangka JavaScript dan sisi server kerangka Ruby. Kamu mendapatkan akses penuh untuk
menulis model domain dengan Active Record atau kamu dapat memilih Object-Relational-Mapping (ORM)
pilihan kamu.

Apa itu Pub/Sub
---------------

[Pub/Sub](https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern), atau disebut Publik Berlangganan,
mengacu pada antrian pesan yang memilik paradigma dimana pengirim informasi (penerbit),  mengirim data kepada
kelas yang abstrak ke penerima (pelanggan), tanpa menentukan spesifikasi individu penerima. Action Cable
menggunakan pendekatan ini untuk berkomunikasi antara server dan banyak klien.

## Komponen Sisi Server

### Koneksi

*Koneksi* adalah fondasi dasar hubungan dengan Klien Server. Agar semua Websocket di terima oleh server, koneksi
di pakai pada objek. Objek menjadi induk bagi semua *saluran pelanggan* yang di buat di dalamnya. Koneksi sendiri
tidak berurusan dengan logika apapun di dalam spesifikasi aplikasi di luar otentikasi dan otorisasi. Klien dari
koneksi WebSocket di sebut koneksi *konsumen*. Pengguna secara individu membuat satu pasang konsumen-koneksi per
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

Contoh di atas tergantung user yang telah di autentikasi dari aplikasi kamu, dan sukses autentikasi di setujui
oleh cookie user ID.

Cookie user ID secara otomatis mengirim ke koneksi saat koneksi baru di coba, dan penggunaan `current_user` untuk
mengidentifikasi koneksi dengan user yang sama, dan juga memastikan kamu dapat menerima semua koneksi dari user
(dan berpontensi diskoneksi ke semuanya jika user telah di hapus atau tidak di autentikasi).

### Saluran

Sebuah *saluran* merangkum unit logik dari sebuah pekerjaan, mirip dengan apa yang di lakukan oleh controller pada
MVC(Model View Controller). Secara default, Rails membuat sebuah kelas induk `ApplicationCable::Channel` untuk
bersama merangkum logic antara saluran kamu.

#### Memasang Induk Saluran

```ruby
# app/channels/application_cable/channel.rb
module ApplicationCable
  class Channel < ActionCable::Channel::Base
  end
end
```

Kemudian kamu dapat membuat kelas saluran kamu sendiri. berikut contoh, yang dapat kamu buat
```ChatChannel` dan `ApperanceChannel`:

```ruby
# app/channels/chat_channel.rb
class CharChannel < ApplicationCable::Channel
end

# app/channels/apperance_channel.rb
class ApperanceChannel < ApplicationCable::Channel
end
```

Seorang konsumen kemudian dapat berlangganan salah satu atau kedua saluran ini.

#### Berlangganan

Konsumen yang berlangganan pada saluran di sebut *pelanggan*. Dan koneksinya di sebut *berlangganan*.
Pesan yang dihasilkan kemudian dialihkan ke saluran
langganan berdasarkan pengenal yang dikirim oleh konsumen kabel.

```ruby
# app/channels/chat_channel.rb
class ChatChannel < ApplicationCable::Channel
  # Di panggil ketika konsumen sukses
  # menjadi pelanggan pada saluran ini
  def subscribed
  end
end
```

## Komponen Sisi Klien

### Koneksi

Konsumen memerlukan contoh koneksi dari sisi konsumen. Ini bisa dibuat menggunakan
JavaScript berikut, yang dibuat secara default oleh Rails:

#### Koneksi Konsumen

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

Contoh di atas menyiapkan konsumen yang akan terhubung dengan `/ kabel` di server kamu
secara default. Koneksi tidak akan terjalin sampai mendapat minimal satu pelanggan
yang telah di tentukan untuk menjadi pelanggan.

#### Berlangganan

Konsumen menjadi pelanggan dengan membuat langganan ke saluran yang diberikan:

```coffeescript
# app/assets/javascripts/cable/subscriptions/chat.coffee
App.cable.subscriptions.create { channel: "ChatChannel", room: "Best Room" }

# app/assets/javascripts/cable/subscriptions/appearance.coffee
App.cable.subscriptions.create { channel: "AppearanceChannel" }
```
-
Meskipun langganan telah di buat, fungsionalitas yang diperlukan untuk menanggapi data yang diterima akan dijabarkan lagi.

Konsumen dapat bertindak sebagai pelanggan kapan saja pada setiap saluran yang di berikan. Sebagai contoh, konsumen dapat berlangganan beberapa ruang obrolan secara bersamaan:

```coffeescript
App.cable.subscriptions.create { channel: "ChatChannel", room: "1st Room" }
App.cable.subscriptions.create { channel: "ChatChannel", room: "2nd Room" }
```

## Interaksi Klien-Server

### Streaming

*streaming* menyediakan mekanisme saluran yang di kirimkan sebagai publikasi konten (siaran) ke pelanggan yang berlangganan.

```ruby
# app/channels/chat_channel.rb
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:room]}"
  end
end
```

Jika kamu memiliki streaming yang berhubungan dengan model, maka siaran dapat menggunakan model dan saluran tersebut. Berikut contoh siaran pada saluran berlangganan `comments:Z2lkOi8vVGVzdEFwcC9Qb3N0LzE`

```ruby
class CommentsChannel < ApplicationCable::Channel
  def subscribed
    post = Post.find(params[:id])
    stream_for post
  end
end
```

kamu dapat melakukan siaran pada saluran di atas seperti ini:

```ruby
CommentsChannel.broadcast_to(@post, @comment)
```
### Siaran

*Siaran* adalah tautan pub / sub di mana segala sesuatu yang ditransmisikan oleh penerbit dan dikirim langsung ke pelanggan saluran streaming yang bernama siaran. Setiap saluran dapat melakukan streaming siaran dari nol hingga lebih banyak siaran.

Siaran adalah murni antrean online dan tergantung waktu. Jika konsumen tidak streaming (berlangganan saluran yang diberikan), mereka tidak akan mendapatkan siaran jika mereka terhubung nanti.

Panggil Siaran di Aplikasi rails kamu di mana saja:

```ruby
WebNotificationsChannel.broadcast_to(
  current_user,
  title: 'New things!',
  body: 'All the news fit to print'
)
```
Panggilan `webNotificationsChannel.broadcast_to` menempatkan pesan pada adaptor berlangganan(secara default `redis` untuk produksi dan `async` untuk development dan test pengembangan) antrean pub/sub di pisahkan oleh nama saluran untuk masing - masing user. Untuk dengan ID 1, nama saluran menjadi `web_notification:1`.

Saluran telah diinstruksikan untuk streaming semua yang datang pada `web_notifications:1`. langsung ke klien dengan memohon `received` kembali.

### Berlangganan

Ketika konsumen berlangganan di sebuah channel, konsumen menjadi pelanggan. Koneksi ini di sebut berlangganan.
. Pesan yang masuk kemudian dialihkan ke
langganan saluran ini berdasarkan pengenal yang dikirim oleh konsumen.

```coffeescript
# app/assets/javascripts/cable/subscriptions/chat.coffee
# Asumsi kamu telah mengirim request pada notifikasi web
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

### Memberikan Parameter untuk Saluran

Kamu dapat memberikan parameter dari sisi klien ke sisi server dengan membuat langganan. Sebagai contoh:

```ruby
# app/channels/chat_channel.rb
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:room]}"
  end
end
```

Kemudian objek di teruskan ke`subscriptions.create` 
dan menjadi parameter hash di dalam saluran. Keyword `channel` di haruskan:

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
# Misal di app kamu seperti
# dari NewCommentJob
ActionCable.server.broadcast(
  "chat_#{room}",
  sent_by: 'Paul',
  body: 'This is a cool chat app.'
)
```

### Siaran ulang sebuah Pesan

Kasus yang biasa terjadi adalah *siaran ulang* sebuah pesan oleh satu klien ke klien lain yang sama - sama terkoneksi.

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

Siaran ulang akan di terima oleh semua yang terkoneksi bersama, _termasuk_ klien yang mengirim pesan tersebut. Perhatikan bahwa parameter sama seperti ketika
kamu berlangganan saluran.

## Contoh Full-Stack 

Langkah-langkah pengaturan umum pada kedua contoh:

  1. [Memasang koneksi](#connection-setup).
  2. [Memasang induk saluran](#parent-channel-setup).
  3. [Hubungkan konsumen](#connect-consumer).

### Contoh 1: Menampilkan User

Berikut adalah contoh sederhana saluran yang melacak apakah pengguna sedang online atau tidak dan di halaman mana mereka berada. (Ini berguna untuk membuat fitur kehadiran seperti menunjukkan
titik hijau di sebelah nama pengguna jika sedang online)

Buat tampilan saluran sisi server:

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

Ketika pelangggan mulai `berlangganan` panggilan ulang dibatalkan dan mendapatkan kesempatan untuk "user saat ini telah di tampilkan" . That
appear/disappear API dapat di dukung oleh redis, sebuah database, atau yang lainnya.

Membuat tampilan berlangganan sisi-klien pada saluran:

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

  # Dipanggil ketika berlangganan di tolak oleh server.
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

##### Klien-Server Interaksi

1. **Client** dihubungkan dengan **Server** via `App.cable =
ActionCable.createConsumer("ws://cable.example.com")`. (`cable.js`). dan
**Server** mengindentifikasi koneksi ini oleh `current_user`.

2. **Client** berlangganan ke saluran yang ditampilkan via
`App.cable.subscriptions.create(channel: "AppearanceChannel")`. (`appearance.coffee`)

3. **Server** menerima sebuah langganan baru telah terpasang untuk di tampilkan pada saluran dan menjalankan `berlangganan` memanggil ulang, memanggil `appear`
metode pada`current_user`. (`appearance_channel.rb`)

4. **Client** mengakui bahwa sebuah langganan telah terpasang  dan dipanggil
`connected` (`appearance.coffee`) yang mendapat giliran `@install` dan `@appear`.
`@appear` dipanggil `AppearanceChannel#appear(data)` di dalam server, dan persediaan hash data pada `{ appearing_on: $("main").data("appearing-on") }`. Hal ini dimungkinkan karena contoh saluran sisi server secara otomatis memaparkan semua metode publik yang dideklarasikan di kelas (minus panggilan balik), sehingga dapat tercapai dengan remote prosedur yang dipanggil lewat metode `perform` pada langganan.

5. **Server** menerima request untuk aksi`appear` pada tampilan saluran agar koneksi diidentifikasi oleh `current_user`
(`appearance_channel.rb`). **Server** mengambil data pada `:appearing_on` key dari hash data telah di tetapkan sebagai nilai pada `:on` key diteruskan ke`current_user.appear`.

### Example 2: Menerima Pemberitahuan Baru Web

Contoh tampilan adalah tentang mengekspose fungsionalitas server ada sisi klien melalu koneksi WebSocket. Tapi yang menarik tentang WebSocket adalah memiliki dua arah jalan. Sekarang mari kita lihat sebuah contoh di mana server meminta tindakan pada klien

Dibawah ini adalah saluran web notifikasi yang mengizinkan kamu untuk memicu sisi klien web notifikasi ketika kamu menyiarkan ke streaming yang tepat:

Membuat saluran sisi server web notifikasi:

```ruby
# app/channels/web_notifications_channel.rb
class WebNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end
end
```

Membuat saluran berlangganan sisi klien web notifikasi:

```coffeescript
# app/assets/javascripts/cable/subscriptions/web_notifications.coffee
# Asumsi sisi klien kamu telah melakukan request
# dengan benar ke web notifikasi
App.cable.subscriptions.create "WebNotificationsChannel",
  received: (data) ->
    new Notification data["title"], body: data["body"]
```

Konten siaran untuk saluran web notifikasi misalnya dari aplikasi kamu:

```ruby
# Misal di app kamu dari NewCommentJob
WebNotificationsChannel.broadcast_to(
  current_user,
  title: 'New things!',
  body: 'All the news fit to print'
)
```
Panggilan `WebNotificationsChannel.broadcast_to` menempatkan pesan di antrian pub / sub adaptor berlangganan saat ini, di bawah nama penyiaran yang terpisah untuk setiap pengguna. Untuk pengguna user ID 1, nama penyiarannya adalah `web_notifications: 1`.

Saluran telah diinstruksikan untuk melakukan streaming untuk semua yang di terima di `web_notifications: 1` langsung ke klien dengan memohon panggilan balik` received`. Data yang dikirimkan sebagai argumen adalah hash yang dikirim sebagai parameter kedua
ke panggilan siaran sisi-server, JSON disandikan untuk melewati jalur yang di lewati dan dibuka untuk argumen data yang tiba sebagai `received`.

### Contoh Yang Lebih Komplet

Lihat di [rails/actioncable-examples](https://github.com/rails/actioncable-examples) 
repository yang lebih lengkap dengan contoh bagaiamana memasang Action Cable pada Rails aplikasi dan menambahkan saluran.

## Konfigurasi

Action Cable memiliki dua konfigurasi yang diperlukan: adapter berlangganan dan mengizinkan permintaan yang masuk.

### Adaptor Berlangganan

Secara default, Action Cable mencari konfigurasi file di `config/cable.yml`.
File harus di tetapkan untuk setiap adaptor Rails environment. Lihat di [Dependencies](#dependencies) bagian untuk menambahkan informasi didalam adaptor.

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

Adaptor async dimaksudkan untuk development/testing dan tidak boleh digunakan dalam produksi.

##### Redis Adapter

The Redis adapter requires users to provide a URL pointing to the Redis server.
Additionally, a `channel_prefix` may be provided to avoid channel name collisions
when using the same Redis server for multiple applications. See the [Redis PubSub documentation](https://redis.io/topics/pubsub#database-amp-scoping) for more details.

##### PostgreSQL Adapter

The PostgreSQL adapter uses Active Record's connection pool, and thus the
application's `config/database.yml` database configuration, for its connection.
This may change in the future. [#27214](https://github.com/rails/rails/issues/27214)

### Allowed Request Origins

Action Cable will only accept requests from specified origins, which are
passed to the server config as an array. The origins can be instances of
strings or regular expressions, against which a check for the match will be performed.

```ruby
config.action_cable.allowed_request_origins = ['http://rubyonrails.com', %r{http://ruby.*}]
```

To disable and allow requests from any origin:

```ruby
config.action_cable.disable_request_forgery_protection = true
```

By default, Action Cable allows all requests from localhost:3000 when running
in the development environment.

### Consumer Configuration

To configure the URL, add a call to `action_cable_meta_tag` in your HTML layout
HEAD. This uses a URL or path typically set via `config.action_cable.url` in the
environment configuration files.

### Other Configurations

The other common option to configure is the log tags applied to the
per-connection logger. Here's an example that uses
the user account id if available, else "no-account" while tagging:

```ruby
config.action_cable.log_tags = [
  -> request { request.env['user_account_id'] || "no-account" },
  :action_cable,
  -> request { request.uuid }
]
```

For a full list of all configuration options, see the
`ActionCable::Server::Configuration` class.

Also, note that your server must provide at least the same number of database
connections as you have workers. The default worker pool size is set to 4, so
that means you have to make at least that available. You can change that in
`config/database.yml` through the `pool` attribute.

## Running Standalone Cable Servers

### In App

Action Cable can run alongside your Rails application. For example, to
listen for WebSocket requests on `/websocket`, specify that path to
`config.action_cable.mount_path`:

```ruby
# config/application.rb
class Application < Rails::Application
  config.action_cable.mount_path = '/websocket'
end
```

You can use `App.cable = ActionCable.createConsumer()` to connect to the cable
server if `action_cable_meta_tag` is invoked in the layout. A custom path is
specified as first argument to `createConsumer` (e.g. `App.cable =
ActionCable.createConsumer("/websocket")`).

For every instance of your server you create and for every worker your server
spawns, you will also have a new instance of Action Cable, but the use of Redis
keeps messages synced across connections.

### Standalone

The cable servers can be separated from your normal application server. It's
still a Rack application, but it is its own Rack application. The recommended
basic setup is as follows:

```ruby
# cable/config.ru
require_relative '../config/environment'
Rails.application.eager_load!

run ActionCable.server
```

Then you start the server using a binstub in `bin/cable` ala:

```
#!/bin/bash
bundle exec puma -p 28080 cable/config.ru
```

The above will start a cable server on port 28080.

### Notes

The WebSocket server doesn't have access to the session, but it has
access to the cookies. This can be used when you need to handle
authentication. You can see one way of doing that with Devise in this [article](http://www.rubytutorial.io/actioncable-devise-authentication).

## Dependencies

Action Cable provides a subscription adapter interface to process its
pubsub internals. By default, asynchronous, inline, PostgreSQL, and Redis
adapters are included. The default adapter
in new Rails applications is the asynchronous (`async`) adapter.

The Ruby side of things is built on top of [websocket-driver](https://github.com/faye/websocket-driver-ruby),
[nio4r](https://github.com/celluloid/nio4r), and [concurrent-ruby](https://github.com/ruby-concurrency/concurrent-ruby).

## Deployment

Action Cable is powered by a combination of WebSockets and threads. Both the
framework plumbing and user-specified channel work are handled internally by
utilizing Ruby's native thread support. This means you can use all your regular
Rails models with no problem, as long as you haven't committed any thread-safety sins.

The Action Cable server implements the Rack socket hijacking API,
thereby allowing the use of a multithreaded pattern for managing connections
internally, irrespective of whether the application server is multi-threaded or not.

Accordingly, Action Cable works with popular servers like Unicorn, Puma, and
Passenger.
