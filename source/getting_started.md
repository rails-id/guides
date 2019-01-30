**DO NOT READ THIS FILE ON GITHUB, GUIDES ARE PUBLISHED ON http://guides.rubyonrails.org.**

Memulai untuk Menggunakan Rails
==========================

Panduan ini mencakup membuat dan menjalankan dengan Ruby on Rails.

Setelah membaca panduan ini, Kamu akan tahu:

* Cara menginstal Rails, membuat aplikasi baru di Rails, dan menghubungkan aplikasi Kamu ke database.
* Tata letak umum aplikasi Rails.
* Prinsip dasar MVC (Model, View, Controller) dan desain RESTful.
* Cara cepat mengenerate aplikasi Rails.

--------------------------------------------------------------------------------

Asumsi Panduan
-----------------

Panduan ini dirancang untuk pemula yang ingin memulai dengan aplikasi Rails dari awal.
Anggapan bahwa Kamu tidak memiliki pengalaman sebelumnya dengan Rails.

Rails adalah framework aplikasi web yang berjalan pada bahasa pemrograman Ruby.
Jika Kamu tidak memiliki pengalaman sebelumnya dengan Ruby,
Kamu akan banyak menemukan kesulitan dalam belajar Rails.
Ada beberapa daftar sumber online yang bisa dipelajari dari Ruby:

* [Situs Web Resmi Bahasa Pemrograman Ruby](https://www.ruby-lang.org/en/documentation/)
* [Daftar Buku Pemrograman (Gratis)](https://github.com/vhf/free-programming-books/blob/master/free-programming-books.md#ruby)

Ketahuilah bahwa beberapa sumber diatas, walaupun masih bagus,
mencakup versi Ruby terdahulu yaitu versi 1.6, umumnya Ruby versi 1.8,
dan disumber tersebut mungkin tidak akan menyertakan beberapa
syntax yang akan Kamu lihat dalam development di Rails.

Apa itu Rails?
--------------

Rails adalah framework untuk mengembangkan aplikasi web yang ditulis
dalam bahasa pemrograman Ruby. Rails dirancang untuk membuat program
aplikasi web lebih mudah, hal ini agar setiap developer bisa membuat aplikasi
apa yang mereka butuhkan. Rails memungkinkan Kamu untuk menulis kode lebih
sedikit sementara pencapaian Kamu lebih banyak dengan menulis kode untuk bahasa dan
framwork lainnya. Developer Rails yang berpengalaman juga telah melaporkan bahwa
membuat aplikasi web dengan Rails lebih menyenangkan.

Rails adalah perangkat lunak yang disarankan. Hal ini menunjukkan bahwa ada cara "terbaik"
untuk melakukan sesuatu, yang bisa dirancang dengan dorongan cara tersebut, dan dalam beberapa kasus
untuk mencegah alternatif. Jika Kamu mempelajari "The Rails Way" Kamu mungkin akan menemukan
peningkatan produktivitas yang luar biasa. Jika Kamu terus membawa kebiasaan lama
dari bahasa lain ke Rails development, dan mencoba menggunakan pola yang Kamu
pelajari di tempat lain, mungkin Kamu adalah salah satu orang yang memiliki pengalaman kurang menyenangkan.

Rails memiliki dua Filosofi prinsip utama:

* **Don't Repeat Yourself:** DRY adalah prinsip development perangkat lunak yang
  menyatakan bahwa "Setiap bagian pengetahuan harus memiliki perwakilan tunggal,
  tidak ambigu, otoritatif dalam suatu sistem." Dengan tidak menulis informasi
  yang sama berulang-ulang, kode lebih mudah di-maintainable, di-extensible,
  dan sedikit dari bug.
* **Convention Over Configuration:** Rails memiliki pendapat tentang cara terbaik
  untuk melakukan banyak hal dalam membangun aplikasi web, Rails telah menetapkan
  convention ini secara default, hal ini tidak mengharuskan Kamu untuk menentukan hal-hal
  kecil melalui konfigurasi file yang kurang berguna dan tidak ada habisnya.
  Masih bingung masalah _Convention Over Configuration_ ini?
  Baca selengkapnya [Memahami Convention Over Configuration dalam Pemrograman](https://medium.com/laravel-indonesia/memahami-convention-over-configuration-dalam-pemrograman-a61b55602c05)

Membuat Proyek Baru dengan Rails
----------------------------
Cara terbaik untuk mengikuti panduan ini adalah dengan cara mengikuti langkah demi langkah.
Semua langkah sangat penting untuk menjalankan contoh aplikasi ini dan tidak ada kode atau
langkah tambahan yang diperlukan.

Dengan mengikuti panduan ini bersama-sama, Kamu akan membuat proyek Rails yang disebut
`blog`, weblog (yang sangat) sederhana. Sebelum Kamu memulai membuat aplikasi,
Kamu perlu memastikan dulu bahwa Rails-mu sudah terinstal.

TIP: Contoh-contoh di bawah ini tanda `$` digunakan untuk mewakili terminal shell untuk OS UNIX-like,
walaupun mungkin tampil berbeda karena telah disesuaikan. Jika Kamu menggunakan Windows,
shell Kamu akan terlihat seperti `c:\source_code>`

### Menginstal Rails

Sebelum Kamu menginstal Rails, Kamu harus memeriksa untuk memastikan bahwa
sistem yang Kamu gunakan telah memenuhi prasyarat untuk diinstal. Termasuk Ruby dan SQLite3.

Buka shell command line. Untuk macOS, buka Terminal.app, untuk Windows pilih
"Run" dari Start menu dan ketik 'cmd.exe'. Perintah apa pun yang diawali dengan tanda
dolar `$` harus dijalankan di command line. Verifikasi bahwa Kamu memiliki
versi Ruby yang diinstal:

```bash
$ ruby -v
ruby 2.3.1p112
```

Rails membutuhkan Ruby versi 2.2.2 atau lebih baru.
Jika nomor versi yang dihasilkan kurang dari angka diatas,
Kamu harus menginstal Ruby yang baru.

TIP: Ada beberapa alat untuk membantu Kamu dengan cepat menginstal
Ruby dan Ruby on Rails di sistem Kamu. Untuk pengguna Windows bisa menggunakan [Rails Installer](http://railsinstaller.org),
sedangkan untuk pengguna macOS bisa menggunakan [Tokaido](https://github.com/tokaido/tokaidoapp).
Cara pemasangan lebih lanjut untuk sebagian besar Sistem Operasi, silakan lihat di
[ruby-lang.org](https://www.ruby-lang.org/en/documentation/installation/).

Jika Kamu menjalankan di Windows, Kamu juga harus menginstal
[Ruby Installer Development Kit](http://rubyinstaller.org/downloads/).

Kamu juga akan memerlukan instalasi database SQLite3.
Banyak OS turunan UNIX-like yang populer dapat menerima versi SQLite3.
Untuk Windows, jika Kamu menginstal Rails menggunakan Rails Installer, itu
sudah termasuk instalasi SQLite. Untuk yang lainnya bisa mencari petunjuk
instalasi di [Situs web SQLite3](https://www.sqlite.org).
Verifikasi bahwa installasi PATH sudah terpasang dengan benar:

```bash
$ sqlite3 --version
```

Program harus menghasilkan versi sesuai perintah diatas.

Untuk menginstal Rails, gunakan perintah `gem install` yang telah disediakan oleh RubyGems:

```bash
$ gem install rails
```

Untuk memverifikasi bahwa Kamu telah menginstal semuanya dengan benar, Kamu harus
bisa menjalankan perintah berikut:

```bash
$ rails --version
```

Jika menghasilkan sesuatu seperti "Rails 5.2.1", Kamu siap untuk melanjutkan ke langkah berikutnya.

### Membuat Aplikasi Blog

Rails hadir dengan sejumlah script yang disebut dengan generator yang dirancang untuk membuat
development lebih mudah dengan membuat segala sesuatu yang diperlukan untuk
menjalankan tugas-tugas tertentu. Salah satunya adalah generator membuat aplikasi baru di Rails,
yang akan memberikan Kamu dasar dari pembuatan aplikasi baru sehingga
Kamu tidak perlu menuliskannya lagi.

Untuk menggunakan generator ini, buka terminal, navigasikan ke direktori
tempat dimana Kamu memiliki hak akses untuk membuat file atau folder, dan ketik:

```bash
$ rails new blog
```

Ini akan membuat aplikasi Rails yang disebut Blog, didalam direktori `blog` dan
akan menginstal dependensi gem yang telah disebutkan dalam `Gemfile`
menggunakan perintah `bundle install`.

NOTE: Jika Kamu menggunakan Subsistem Windows untuk Linux maka ada beberapa
limitasi pemberitahuan pada file system yang berarti Kamu harus menonaktifkan gem `spring`
dan `listen` yang bisa Kamu lakukan dengan menjalankan perintah `rails new blog --skip-spring --skip-listen`.

TIP: Kamu bisa melihat semua opsi perintah yang disediakan dari aplikasi Rails builder
dengan menjalankan perintah `rails new -h`.

Setelah Kamu membuat aplikasi blog, navigasikan ke direktori blog:

```bash
$ cd blog
```

Di direktori `blog` memiliki file dan folder yang dihasilkan secara otomatis
sehingga membentuk struktur aplikasi Rails. Dalam tutorial ini sebagaian besar
folder yang banyak bekerja adalah folder `app`, dibawah ini adalah ikhtisar
dasar tentang masing-masing fungsi file dan folder yang dibuat oleh Rails secara default:

| File/Folder | Fungsi  |
| ----------- | ------- |
|app/|Berisi controllers, models, views, helpers, mailers, channels, jobs dan assets untuk aplikasi. Kamu akan fokus pada folder-folder ini selama mengikuti panduan ini.|
|bin/|Berisi script Rails yang dimana untuk menjalankan aplikasi dan bisa juga berisi script lain yang Kamu gunakan untuk menyiapkan, memperbarui, men-deploy atau menjalankan aplikasi.|
|config/|Berisi konfigurasi route, database aplikasi, dan lain-lain. Untuk panduan lebih lanjut tentang Konfigurasi, lihat di [Konfigurasi Aplikasi Rails](configuring.html).|
|config.ru|Konfigurasi untuk server berbasis Rack yang digunakan untuk memulai aplikasi. Untuk informasi lebih lanjut tentang Rack, lihat di [Situs web Rack](https://rack.github.io/).|
|db/|Berisi skema database saat ini, serta migrasi database.|
|Gemfile<br>Gemfile.lock|File ini memungkinkan Kamu untuk menentukan dependensi gem apa yang diperlukan. File ini dioperasikan oleh gem Bundler. Untuk informasi lebih lanjut tentang Bundler, lihat di [Situs web Bundler](https://bundler.io).|
|lib/|Modul yang di Extend untuk aplikasi Rails.|
|log/|File log aplikasi.|
|package.json|File ini memungkinkan Kamu untuk menentukan dependensi npm apa yang diperlukan untuk aplikasi Rails. File ini dioperasikan oleh Yarn. Untuk informasi lebih lanjut tentang Yarn, lihat di [Situs web Yarn](https://yarnpkg.com/lang/en/).|
|public/|Satu-satunya folder yang dilihat oleh pengguna publik. Berisi file statis dan asset yang dikompilasi.|
|Rakefile|File ini mencari dan memuat task yang dapat dijalankan dari command line. Task yang dimaksud adalah definisi untuk seluruh komponen yang ada di Rails. Untuk dapat menambahkan task di `Rakefile` cukup menambahkan script yang buat ke direktori `lib/tasks` aplikasi Rails Kamu.|
|README.md|Ini adalah instruksi manual singkat untuk aplikasi Rails Kamu. Kamu bisa mengedit file ini untuk memberi tahu orang lain apa yang harus dilakukan untuk aplikasi Kamu, cara pengaturannya, dan lain sebagainya.|
|test/|Tes unit, fixture, dan peralatan tes lainnya. Untuk panduan lebih lanjut tentang Testing, lihat di [Testing Aplikasi Rails](testing.html).|
|tmp/|File sementara (seperti cache dan file pid).|
|vendor/|Tempat untuk semua kode pihak ketiga (third-party). Tipikal ini untuk memasukkan vendor gem ke aplikasi Rails.|
|.gitignore|File ini memberi tahu git ke file (atau pattern) dimana yang harus diabaikan. Lihat di [GitHub - Mengabaikan file](https://help.github.com/articles/ignoring-files) untuk info lebih lanjut tentang mengabaikan file.
|.ruby-version|File ini berisi versi Ruby yang digunakan secara default dalam satu proyek Ruby.|

Halo, Rails!
-------------

Untuk memulainya. Untuk melakukan ini, Kamu perlu menjalankan server di aplikasi Rails Kamu.

### Memulai Menjalankan Web Server

Kamu sebenarnya sudah memiliki aplikasi Rails secara fungsional. Untuk melihatnya,
Kamu harus menjalankan web server di mesin development Kamu. Kamu dapat melakukan
ini dengan menjalankan perintah berikut ini di direktori `blog`:

```bash
$ bin/rails server
```

TIP: Jika Kamu menggunakan Windows, Kamu harus menjalnkan script di folder `bin`
melalui Ruby interpreter langsung, contohnya `ruby bin\rails server`.

TIP: Mengkompilasi CoffeeScript dan kompresi asset JavaScript Kamu harus
memiliki runtime JavaScript yang ada di sistem Kamu, jika tidak ada runtime
Kamu akan melihat error `execjs` selama kompilasi asset.
Biasanya macOS dan Windows dilengkapi dengan runtime JavaScript yang diinstal.
Rails menambahkan gem `mini_racer` di generate ke `Gemfile` dengan command line
saat membuat aplikasi baru di Rails dan Kamu dapat menghapus komentar jika Kamu membutuhkannya.
`therubyrhino` adalah runtime yang direkomendasikan untuk pengguna JRuby dan akan ditambahkan
secara default ke `Gemfile` dalam aplikasi yang dibuat dengan JRuby. Kamu bisa melihat
semua runtime yang didukung oleh [ExecJS](https://github.com/rails/execjs#readme).

Kali ini untuk menjalankan Puma, web server yang didistribusikan dengan Rails secara default.
Untuk melihat aplikasi Kamu, buka perambang (browser) dan arahkan ke
<http://localhost:3000>. Kamu akan melihat halaman default Rails:

![Welcome aboard screenshot](images/getting_started/rails_welcome.png)

TIP: Untuk menghentikan web server, tekan Ctrl+C di terminal dimana aplikasi dijalankan.
Untuk memverifikasi server telah berhenti Kamu harus melihat kursor shell command line Kamu lagi.
Untuk sebagian besar sistem UNIX-like termasuk macOS akan menjadi tanda dolar `$`.
Dalam mode development, Rails pada umumnya tidak mengharuskan Kamu untuk me-restart
server; apa yang Kamu buat atau rubah pada file di server akan secara otomatis berubah.

Halaman "Welcome aboard" adalah _smoke test_ untuk aplikasi baru di Rails:
halaman itu untuk menunjukkan bawah Kamu telah memiliki perangkat luna yang cukup
untuk mengkonfigurasi Rails.

### Katakan "Halo", Rails

Untuk menampilkan kata "Halo" di Rails, Kamu harus membuat setidaknya _controller_ dan
_view_.

Tujuan controller adalah untuk menerima request spesifik ke aplikasi.
_Routing_ untuk menentukan controller mana yang akan menerima request. Kebanyakan, ada lebih
dari satu route ke masing-masing controller, dan beberapa route juga bisa melayani berbeda-beda _action_.
Tujuan setiap action adalah untuk mengumpulkan informasi agar bisa dilihat.

Tujuan view adalah untuk menampilkan informasi dalam format yang dapat dibaca oleh pengunjung.
Untuk membedakannya dibuat dengan _Controller_, bukan view,
di mana informasi tersebut untuk dikumpulkan. View seharusnya hanya untuk menempilkan informasi.
Secara default, template view ditulis dalam bahasa yang disebut dengan eRuby
(Embedded Ruby) yang diproses oleh alur request di Rails sebelum
dikirim ke pengguna.

Untuk membuat controller baru, Kamu perlu menjalankan generator "controller" dan
controller tersebut bernama "Welcome" dengan action yang disebut "index",
seperti dibawah ini:

```bash
$ bin/rails generate controller Welcome index
```

Rails akan membuat beberapa file dan route untuk Kamu.

```bash
create  app/controllers/welcome_controller.rb
 route  get 'welcome/index'
invoke  erb
create    app/views/welcome
create    app/views/welcome/index.html.erb
invoke  test_unit
create    test/controllers/welcome_controller_test.rb
invoke  helper
create    app/helpers/welcome_helper.rb
invoke    test_unit
invoke  assets
invoke    coffee
create      app/assets/javascripts/welcome.coffee
invoke    scss
create      app/assets/stylesheets/welcome.scss
```

Yang terpenting disini adalah controller, berada di
`app/controllers/welcome_controller.rb` dan view, berada di
`app/views/welcome/index.html.erb`.

Buka file `app/views/welcome/index.html.erb` dengan text editor Kamu. Hapus semua
kode yang ada didalam file, dan diganti dengan satu baris kode dibawah ini:

```html
<h1>Halo, Rails!</h1>
```

### Setting the Application Home Page

Now that we have made the controller and view, we need to tell Rails when we
want "Hello, Rails!" to show up. In our case, we want it to show up when we
navigate to the root URL of our site, <http://localhost:3000>. At the moment,
"Welcome aboard" is occupying that spot.

Next, you have to tell Rails where your actual home page is located.

Open the file `config/routes.rb` in your editor.

```ruby
Rails.application.routes.draw do
  get 'welcome/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
```

This is your application's _routing file_ which holds entries in a special
[DSL (domain-specific language)](https://en.wikipedia.org/wiki/Domain-specific_language)
that tells Rails how to connect incoming requests to
controllers and actions.
Edit this file by adding the line of code `root 'welcome#index'`.
It should look something like the following:

```ruby
Rails.application.routes.draw do
  get 'welcome/index'

  root 'welcome#index'
end
```

`root 'welcome#index'` tells Rails to map requests to the root of the
application to the welcome controller's index action and `get 'welcome/index'`
tells Rails to map requests to <http://localhost:3000/welcome/index> to the
welcome controller's index action. This was created earlier when you ran the
controller generator (`bin/rails generate controller Welcome index`).

Launch the web server again if you stopped it to generate the controller (`bin/rails
server`) and navigate to <http://localhost:3000> in your browser. You'll see the
"Hello, Rails!" message you put into `app/views/welcome/index.html.erb`,
indicating that this new route is indeed going to `WelcomeController`'s `index`
action and is rendering the view correctly.

TIP: For more information about routing, refer to [Rails Routing from the Outside In](routing.html).

Getting Up and Running
----------------------

Now that you've seen how to create a controller, an action and a view, let's
create something with a bit more substance.

In the Blog application, you will now create a new _resource_. A resource is the
term used for a collection of similar objects, such as articles, people or
animals.
You can create, read, update and destroy items for a resource and these
operations are referred to as _CRUD_ operations.

Rails provides a `resources` method which can be used to declare a standard REST
resource. You need to add the _article resource_ to the
`config/routes.rb` so the file will look as follows:

```ruby
Rails.application.routes.draw do
  get 'welcome/index'

  resources :articles

  root 'welcome#index'
end
```

If you run `bin/rails routes`, you'll see that it has defined routes for all the
standard RESTful actions.  The meaning of the prefix column (and other columns)
will be seen later, but for now notice that Rails has inferred the
singular form `article` and makes meaningful use of the distinction.

```bash
$ bin/rails routes
       Prefix Verb   URI Pattern                  Controller#Action
welcome_index GET    /welcome/index(.:format)     welcome#index
     articles GET    /articles(.:format)          articles#index
              POST   /articles(.:format)          articles#create
  new_article GET    /articles/new(.:format)      articles#new
 edit_article GET    /articles/:id/edit(.:format) articles#edit
      article GET    /articles/:id(.:format)      articles#show
              PATCH  /articles/:id(.:format)      articles#update
              PUT    /articles/:id(.:format)      articles#update
              DELETE /articles/:id(.:format)      articles#destroy
         root GET    /                            welcome#index
```

In the next section, you will add the ability to create new articles in your
application and be able to view them. This is the "C" and the "R" from CRUD:
create and read. The form for doing this will look like this:

![The new article form](images/getting_started/new_article.png)

It will look a little basic for now, but that's ok. We'll look at improving the
styling for it afterwards.

### Laying down the groundwork

Firstly, you need a place within the application to create a new article. A
great place for that would be at `/articles/new`. With the route already
defined, requests can now be made to `/articles/new` in the application.
Navigate to <http://localhost:3000/articles/new> and you'll see a routing
error:

![Another routing error, uninitialized constant ArticlesController](images/getting_started/routing_error_no_controller.png)

This error occurs because the route needs to have a controller defined in order
to serve the request. The solution to this particular problem is simple: create
a controller called `ArticlesController`. You can do this by running this
command:

```bash
$ bin/rails generate controller Articles
```

If you open up the newly generated `app/controllers/articles_controller.rb`
you'll see a fairly empty controller:

```ruby
class ArticlesController < ApplicationController
end
```

A controller is simply a class that is defined to inherit from
`ApplicationController`.
It's inside this class that you'll define methods that will become the actions
for this controller. These actions will perform CRUD operations on the articles
within our system.

NOTE: There are `public`, `private` and `protected` methods in Ruby,
but only `public` methods can be actions for controllers.
For more details check out [Programming Ruby](http://www.ruby-doc.org/docs/ProgrammingRuby/).

If you refresh <http://localhost:3000/articles/new> now, you'll get a new error:

![Unknown action new for ArticlesController!](images/getting_started/unknown_action_new_for_articles.png)

This error indicates that Rails cannot find the `new` action inside the
`ArticlesController` that you just generated. This is because when controllers
are generated in Rails they are empty by default, unless you tell it
your desired actions during the generation process.

To manually define an action inside a controller, all you need to do is to
define a new method inside the controller. Open
`app/controllers/articles_controller.rb` and inside the `ArticlesController`
class, define the `new` method so that your controller now looks like this:

```ruby
class ArticlesController < ApplicationController
  def new
  end
end
```

With the `new` method defined in `ArticlesController`, if you refresh
<http://localhost:3000/articles/new> you'll see another error:

![Template is missing for articles/new]
(images/getting_started/template_is_missing_articles_new.png)

You're getting this error now because Rails expects plain actions like this one
to have views associated with them to display their information. With no view
available, Rails will raise an exception.

Let's look at the full error message again:

>ArticlesController#new is missing a template for this request format and variant. request.formats: ["text/html"] request.variant: [] NOTE! For XHR/Ajax or API requests, this action would normally respond with 204 No Content: an empty white screen. Since you're loading it in a web browser, we assume that you expected to actually render a template, not… nothing, so we're showing an error to be extra-clear. If you expect 204 No Content, carry on. That's what you'll get from an XHR or API request. Give it a shot.

That's quite a lot of text! Let's quickly go through and understand what each
part of it means.

The first part identifies which template is missing. In this case, it's the
`articles/new` template. Rails will first look for this template. If not found,
then it will attempt to load a template called `application/new`. It looks for
one here because the `ArticlesController` inherits from `ApplicationController`.

The next part of the message contains `request.formats` which specifies
the format of template to be served in response. It is set to `text/html` as we
requested this page via browser, so Rails is looking for an HTML template.
`request.variant` specifies what kind of physical devices would be served by
the response and helps Rails determine which template to use in the response.
It is empty because no information has been provided.

The simplest template that would work in this case would be one located at
`app/views/articles/new.html.erb`. The extension of this file name is important:
the first extension is the _format_ of the template, and the second extension
is the _handler_ that will be used to render the template. Rails is attempting
to find a template called `articles/new` within `app/views` for the
application. The format for this template can only be `html` and the default
handler for HTML is `erb`. Rails uses other handlers for other formats.
`builder` handler is used to build XML templates and `coffee` handler uses
CoffeeScript to build JavaScript templates. Since you want to create a new
HTML form, you will be using the `ERB` language which is designed to embed Ruby
in HTML.

Therefore the file should be called `articles/new.html.erb` and needs to be
located inside the `app/views` directory of the application.

Go ahead now and create a new file at `app/views/articles/new.html.erb` and
write this content in it:

```html
<h1>New Article</h1>
```

When you refresh <http://localhost:3000/articles/new> you'll now see that the
page has a title. The route, controller, action and view are now working
harmoniously! It's time to create the form for a new article.

### The first form

To create a form within this template, you will use a *form
builder*. The primary form builder for Rails is provided by a helper
method called `form_with`. To use this method, add this code into
`app/views/articles/new.html.erb`:

```html+erb
<%= form_with scope: :article, local: true do |form| %>
  <p>
    <%= form.label :title %><br>
    <%= form.text_field :title %>
  </p>

  <p>
    <%= form.label :text %><br>
    <%= form.text_area :text %>
  </p>

  <p>
    <%= form.submit %>
  </p>
<% end %>
```

If you refresh the page now, you'll see the exact same form from our example above.
Building forms in Rails is really just that easy!

When you call `form_with`, you pass it an identifying scope for this
form. In this case, it's the symbol `:article`. This tells the `form_with`
helper what this form is for. Inside the block for this method, the
`FormBuilder` object - represented by `form` - is used to build two labels and two
text fields, one each for the title and text of an article. Finally, a call to
`submit` on the `form` object will create a submit button for the form.

There's one problem with this form though. If you inspect the HTML that is
generated, by viewing the source of the page, you will see that the `action`
attribute for the form is pointing at `/articles/new`. This is a problem because
this route goes to the very page that you're on right at the moment, and that
route should only be used to display the form for a new article.

The form needs to use a different URL in order to go somewhere else.
This can be done quite simply with the `:url` option of `form_with`.
Typically in Rails, the action that is used for new form submissions
like this is called "create", and so the form should be pointed to that action.

Edit the `form_with` line inside `app/views/articles/new.html.erb` to look like
this:

```html+erb
<%= form_with scope: :article, url: articles_path, local: true do |form| %>
```

In this example, the `articles_path` helper is passed to the `:url` option.
To see what Rails will do with this, we look back at the output of
`bin/rails routes`:

```bash
$ bin/rails routes
      Prefix Verb   URI Pattern                  Controller#Action
welcome_index GET    /welcome/index(.:format)     welcome#index
     articles GET    /articles(.:format)          articles#index
              POST   /articles(.:format)          articles#create
  new_article GET    /articles/new(.:format)      articles#new
 edit_article GET    /articles/:id/edit(.:format) articles#edit
      article GET    /articles/:id(.:format)      articles#show
              PATCH  /articles/:id(.:format)      articles#update
              PUT    /articles/:id(.:format)      articles#update
              DELETE /articles/:id(.:format)      articles#destroy
         root GET    /                            welcome#index
```

The `articles_path` helper tells Rails to point the form to the URI Pattern
associated with the `articles` prefix; and the form will (by default) send a
`POST` request to that route. This is associated with the `create` action of
the current controller, the `ArticlesController`.

With the form and its associated route defined, you will be able to fill in the
form and then click the submit button to begin the process of creating a new
article, so go ahead and do that. When you submit the form, you should see a
familiar error:

![Unknown action create for ArticlesController]
(images/getting_started/unknown_action_create_for_articles.png)

You now need to create the `create` action within the `ArticlesController` for
this to work.

NOTE: By default `form_with` submits forms using Ajax thereby skipping full page
redirects. To make this guide easier to get into we've disabled that with
`local: true` for now.

### Creating articles

To make the "Unknown action" go away, you can define a `create` action within
the `ArticlesController` class in `app/controllers/articles_controller.rb`,
underneath the `new` action, as shown:

```ruby
class ArticlesController < ApplicationController
  def new
  end

  def create
  end
end
```

If you re-submit the form now, you may not see any change on the page. Don't worry!
This is because Rails by default returns `204 No Content` response for an action if
we don't specify what the response should be. We just added the `create` action
but didn't specify anything about how the response should be. In this case, the
`create` action should save our new article to the database.

When a form is submitted, the fields of the form are sent to Rails as
_parameters_. These parameters can then be referenced inside the controller
actions, typically to perform a particular task. To see what these parameters
look like, change the `create` action to this:

```ruby
def create
  render plain: params[:article].inspect
end
```

The `render` method here is taking a very simple hash with a key of `:plain` and
value of `params[:article].inspect`. The `params` method is the object which
represents the parameters (or fields) coming in from the form. The `params`
method returns an `ActionController::Parameters` object, which
allows you to access the keys of the hash using either strings or symbols. In
this situation, the only parameters that matter are the ones from the form.

TIP: Ensure you have a firm grasp of the `params` method, as you'll use it fairly regularly. Let's consider an example URL: **http://www.example.com/?username=dhh&email=dhh@email.com**. In this URL, `params[:username]` would equal "dhh" and `params[:email]` would equal "dhh@email.com".

If you re-submit the form one more time, you'll see something that looks like the following:

```ruby
<ActionController::Parameters {"title"=>"First Article!", "text"=>"This is my first article."} permitted: false>
```

This action is now displaying the parameters for the article that are coming in
from the form. However, this isn't really all that helpful. Yes, you can see the
parameters but nothing in particular is being done with them.

### Creating the Article model

Models in Rails use a singular name, and their corresponding database tables
use a plural name. Rails provides a generator for creating models, which most
Rails developers tend to use when creating new models. To create the new model,
run this command in your terminal:

```bash
$ bin/rails generate model Article title:string text:text
```

With that command we told Rails that we want an `Article` model, together
with a _title_ attribute of type string, and a _text_ attribute
of type text. Those attributes are automatically added to the `articles`
table in the database and mapped to the `Article` model.

Rails responded by creating a bunch of files. For now, we're only interested
in `app/models/article.rb` and `db/migrate/20140120191729_create_articles.rb`
(your name could be a bit different). The latter is responsible for creating
the database structure, which is what we'll look at next.

TIP: Active Record is smart enough to automatically map column names to model
attributes, which means you don't have to declare attributes inside Rails
models, as that will be done automatically by Active Record.

### Running a Migration

As we've just seen, `bin/rails generate model` created a _database migration_ file
inside the `db/migrate` directory. Migrations are Ruby classes that are
designed to make it simple to create and modify database tables. Rails uses
rake commands to run migrations, and it's possible to undo a migration after
it's been applied to your database. Migration filenames include a timestamp to
ensure that they're processed in the order that they were created.

If you look in the `db/migrate/YYYYMMDDHHMMSS_create_articles.rb` file
(remember, yours will have a slightly different name), here's what you'll find:

```ruby
class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
```

The above migration creates a method named `change` which will be called when
you run this migration. The action defined in this method is also reversible,
which means Rails knows how to reverse the change made by this migration,
in case you want to reverse it later. When you run this migration it will create
an `articles` table with one string column and a text column. It also creates
two timestamp fields to allow Rails to track article creation and update times.

TIP: For more information about migrations, refer to [Active Record Migrations]
(active_record_migrations.html).

At this point, you can use a bin/rails command to run the migration:

```bash
$ bin/rails db:migrate
```

Rails will execute this migration command and tell you it created the Articles
table.

```bash
==  CreateArticles: migrating ==================================================
-- create_table(:articles)
   -> 0.0019s
==  CreateArticles: migrated (0.0020s) =========================================
```

NOTE. Because you're working in the development environment by default, this
command will apply to the database defined in the `development` section of your
`config/database.yml` file. If you would like to execute migrations in another
environment, for instance in production, you must explicitly pass it when
invoking the command: `bin/rails db:migrate RAILS_ENV=production`.

### Saving data in the controller

Back in `ArticlesController`, we need to change the `create` action
to use the new `Article` model to save the data in the database.
Open `app/controllers/articles_controller.rb` and change the `create` action to
look like this:

```ruby
def create
  @article = Article.new(params[:article])

  @article.save
  redirect_to @article
end
```

Here's what's going on: every Rails model can be initialized with its
respective attributes, which are automatically mapped to the respective
database columns. In the first line we do just that (remember that
`params[:article]` contains the attributes we're interested in). Then,
`@article.save` is responsible for saving the model in the database. Finally,
we redirect the user to the `show` action, which we'll define later.

TIP: You might be wondering why the `A` in `Article.new` is capitalized above, whereas most other references to articles in this guide have used lowercase. In this context, we are referring to the class named `Article` that is defined in `app/models/article.rb`. Class names in Ruby must begin with a capital letter.

TIP: As we'll see later, `@article.save` returns a boolean indicating whether
the article was saved or not.

If you now go to <http://localhost:3000/articles/new> you'll *almost* be able
to create an article. Try it! You should get an error that looks like this:

![Forbidden attributes for new article]
(images/getting_started/forbidden_attributes_for_new_article.png)

Rails has several security features that help you write secure applications,
and you're running into one of them now. This one is called [strong parameters](action_controller_overview.html#strong-parameters),
which requires us to tell Rails exactly which parameters are allowed into our
controller actions.

Why do you have to bother? The ability to grab and automatically assign all
controller parameters to your model in one shot makes the programmer's job
easier, but this convenience also allows malicious use. What if a request to
the server was crafted to look like a new article form submit but also included
extra fields with values that violated your application's integrity? They would
be 'mass assigned' into your model and then into the database along with the
good stuff - potentially breaking your application or worse.

We have to whitelist our controller parameters to prevent wrongful mass
assignment. In this case, we want to both allow and require the `title` and
`text` parameters for valid use of `create`. The syntax for this introduces
`require` and `permit`. The change will involve one line in the `create` action:

```ruby
  @article = Article.new(params.require(:article).permit(:title, :text))
```

This is often factored out into its own method so it can be reused by multiple
actions in the same controller, for example `create` and `update`. Above and
beyond mass assignment issues, the method is often made `private` to make sure
it can't be called outside its intended context. Here is the result:

```ruby
def create
  @article = Article.new(article_params)

  @article.save
  redirect_to @article
end

private
  def article_params
    params.require(:article).permit(:title, :text)
  end
```

TIP: For more information, refer to the reference above and
[this blog article about Strong Parameters]
(http://weblog.rubyonrails.org/2012/3/21/strong-parameters/).

### Showing Articles

If you submit the form again now, Rails will complain about not finding the
`show` action. That's not very useful though, so let's add the `show` action
before proceeding.

As we have seen in the output of `bin/rails routes`, the route for `show` action is
as follows:

```
article GET    /articles/:id(.:format)      articles#show
```

The special syntax `:id` tells rails that this route expects an `:id`
parameter, which in our case will be the id of the article.

As we did before, we need to add the `show` action in
`app/controllers/articles_controller.rb` and its respective view.

NOTE: A frequent practice is to place the standard CRUD actions in each
controller in the following order: `index`, `show`, `new`, `edit`, `create`, `update`
and `destroy`. You may use any order you choose, but keep in mind that these
are public methods; as mentioned earlier in this guide, they must be placed
before declaring `private` visibility in the controller.

Given that, let's add the `show` action, as follows:

```ruby
class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end

  def new
  end

  # snippet for brevity
```

A couple of things to note. We use `Article.find` to find the article we're
interested in, passing in `params[:id]` to get the `:id` parameter from the
request. We also use an instance variable (prefixed with `@`) to hold a
reference to the article object. We do this because Rails will pass all instance
variables to the view.

Now, create a new file `app/views/articles/show.html.erb` with the following
content:

```html+erb
<p>
  <strong>Title:</strong>
  <%= @article.title %>
</p>

<p>
  <strong>Text:</strong>
  <%= @article.text %>
</p>
```

With this change, you should finally be able to create new articles.
Visit <http://localhost:3000/articles/new> and give it a try!

![Show action for articles](images/getting_started/show_action_for_articles.png)

### Listing all articles

We still need a way to list all our articles, so let's do that.
The route for this as per output of `bin/rails routes` is:

```
articles GET    /articles(.:format)          articles#index
```

Add the corresponding `index` action for that route inside the
`ArticlesController` in the `app/controllers/articles_controller.rb` file.
When we write an `index` action, the usual practice is to place it as the
first method in the controller. Let's do it:

```ruby
class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
  end

  # snippet for brevity
```

And then finally, add the view for this action, located at
`app/views/articles/index.html.erb`:

```html+erb
<h1>Listing articles</h1>

<table>
  <tr>
    <th>Title</th>
    <th>Text</th>
    <th></th>
  </tr>

  <% @articles.each do |article| %>
    <tr>
      <td><%= article.title %></td>
      <td><%= article.text %></td>
      <td><%= link_to 'Show', article_path(article) %></td>
    </tr>
  <% end %>
</table>
```

Now if you go to <http://localhost:3000/articles> you will see a list of all the
articles that you have created.

### Adding links

You can now create, show, and list articles. Now let's add some links to
navigate through pages.

Open `app/views/welcome/index.html.erb` and modify it as follows:

```html+erb
<h1>Hello, Rails!</h1>
<%= link_to 'My Blog', controller: 'articles' %>
```

The `link_to` method is one of Rails' built-in view helpers. It creates a
hyperlink based on text to display and where to go - in this case, to the path
for articles.

Let's add links to the other views as well, starting with adding this
"New Article" link to `app/views/articles/index.html.erb`, placing it above the
`<table>` tag:

```erb
<%= link_to 'New article', new_article_path %>
```

This link will allow you to bring up the form that lets you create a new article.

Now, add another link in `app/views/articles/new.html.erb`, underneath the
form, to go back to the `index` action:

```erb
<%= form_with scope: :article, url: articles_path, local: true do |form| %>
  ...
<% end %>

<%= link_to 'Back', articles_path %>
```

Finally, add a link to the `app/views/articles/show.html.erb` template to
go back to the `index` action as well, so that people who are viewing a single
article can go back and view the whole list again:

```html+erb
<p>
  <strong>Title:</strong>
  <%= @article.title %>
</p>

<p>
  <strong>Text:</strong>
  <%= @article.text %>
</p>

<%= link_to 'Back', articles_path %>
```

TIP: If you want to link to an action in the same controller, you don't need to
specify the `:controller` option, as Rails will use the current controller by
default.

TIP: In development mode (which is what you're working in by default), Rails
reloads your application with every browser request, so there's no need to stop
and restart the web server when a change is made.

### Adding Some Validation

The model file, `app/models/article.rb` is about as simple as it can get:

```ruby
class Article < ApplicationRecord
end
```

There isn't much to this file - but note that the `Article` class inherits from
`ApplicationRecord`. `ApplicationRecord` inherits from `ActiveRecord::Base`
which supplies a great deal of functionality to your Rails models for free,
including basic database CRUD (Create, Read, Update, Destroy) operations, data
validation, as well as sophisticated search support and the ability to relate
multiple models to one another.

Rails includes methods to help you validate the data that you send to models.
Open the `app/models/article.rb` file and edit it:

```ruby
class Article < ApplicationRecord
  validates :title, presence: true,
                    length: { minimum: 5 }
end
```

These changes will ensure that all articles have a title that is at least five
characters long. Rails can validate a variety of conditions in a model,
including the presence or uniqueness of columns, their format, and the
existence of associated objects. Validations are covered in detail in [Active
Record Validations](active_record_validations.html).

With the validation now in place, when you call `@article.save` on an invalid
article, it will return `false`. If you open
`app/controllers/articles_controller.rb` again, you'll notice that we don't
check the result of calling `@article.save` inside the `create` action.
If `@article.save` fails in this situation, we need to show the form back to the
user. To do this, change the `new` and `create` actions inside
`app/controllers/articles_controller.rb` to these:

```ruby
def new
  @article = Article.new
end

def create
  @article = Article.new(article_params)

  if @article.save
    redirect_to @article
  else
    render 'new'
  end
end

private
  def article_params
    params.require(:article).permit(:title, :text)
  end
```

The `new` action is now creating a new instance variable called `@article`, and
you'll see why that is in just a few moments.

Notice that inside the `create` action we use `render` instead of `redirect_to`
when `save` returns `false`. The `render` method is used so that the `@article`
object is passed back to the `new` template when it is rendered. This rendering
is done within the same request as the form submission, whereas the
`redirect_to` will tell the browser to issue another request.

If you reload
<http://localhost:3000/articles/new> and
try to save an article without a title, Rails will send you back to the
form, but that's not very useful. You need to tell the user that
something went wrong. To do that, you'll modify
`app/views/articles/new.html.erb` to check for error messages:

```html+erb
<%= form_with scope: :article, url: articles_path, local: true do |form| %>

  <% if @article.errors.any? %>
    <div id="error_explanation">
      <h2>
        <%= pluralize(@article.errors.count, "error") %> prohibited
        this article from being saved:
      </h2>
      <ul>
        <% @article.errors.full_messages.each do |msg| %>
          <li><%= msg %></li>
        <% end %>
      </ul>
    </div>
  <% end %>

  <p>
    <%= form.label :title %><br>
    <%= form.text_field :title %>
  </p>

  <p>
    <%= form.label :text %><br>
    <%= form.text_area :text %>
  </p>

  <p>
    <%= form.submit %>
  </p>

<% end %>

<%= link_to 'Back', articles_path %>
```

A few things are going on. We check if there are any errors with
`@article.errors.any?`, and in that case we show a list of all
errors with `@article.errors.full_messages`.

`pluralize` is a rails helper that takes a number and a string as its
arguments. If the number is greater than one, the string will be automatically
pluralized.

The reason why we added `@article = Article.new` in the `ArticlesController` is
that otherwise `@article` would be `nil` in our view, and calling
`@article.errors.any?` would throw an error.

TIP: Rails automatically wraps fields that contain an error with a div
with class `field_with_errors`. You can define a css rule to make them
standout.

Now you'll get a nice error message when saving an article without title when
you attempt to do just that on the new article form
<http://localhost:3000/articles/new>:

![Form With Errors](images/getting_started/form_with_errors.png)

### Updating Articles

We've covered the "CR" part of CRUD. Now let's focus on the "U" part, updating
articles.

The first step we'll take is adding an `edit` action to the `ArticlesController`,
generally between the `new` and `create` actions, as shown:

```ruby
def new
  @article = Article.new
end

def edit
  @article = Article.find(params[:id])
end

def create
  @article = Article.new(article_params)

  if @article.save
    redirect_to @article
  else
    render 'new'
  end
end
```

The view will contain a form similar to the one we used when creating
new articles. Create a file called `app/views/articles/edit.html.erb` and make
it look as follows:

```html+erb
<h1>Edit article</h1>

<%= form_with(model: @article, local: true) do |form| %>

  <% if @article.errors.any? %>
    <div id="error_explanation">
      <h2>
        <%= pluralize(@article.errors.count, "error") %> prohibited
        this article from being saved:
      </h2>
      <ul>
        <% @article.errors.full_messages.each do |msg| %>
          <li><%= msg %></li>
        <% end %>
      </ul>
    </div>
  <% end %>

  <p>
    <%= form.label :title %><br>
    <%= form.text_field :title %>
  </p>

  <p>
    <%= form.label :text %><br>
    <%= form.text_area :text %>
  </p>

  <p>
    <%= form.submit %>
  </p>

<% end %>

<%= link_to 'Back', articles_path %>
```

This time we point the form to the `update` action, which is not defined yet
but will be very soon.

Passing the article object to the method, will automagically create url for submitting the edited article form.
This option tells Rails that we want this form to be submitted
via the `PATCH` HTTP method which is the HTTP method you're expected to use to
**update** resources according to the REST protocol.

The arguments to `form_with` could be model objects, say, `model: @article` which would
cause the helper to fill in the form with the fields of the object. Passing in a
symbol scope (`scope: :article`) just creates the fields but without anything filled into them.
More details can be found in [form_with documentation]
(http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-form_with).

Next, we need to create the `update` action in
`app/controllers/articles_controller.rb`.
Add it between the `create` action and the `private` method:

```ruby
def create
  @article = Article.new(article_params)

  if @article.save
    redirect_to @article
  else
    render 'new'
  end
end

def update
  @article = Article.find(params[:id])

  if @article.update(article_params)
    redirect_to @article
  else
    render 'edit'
  end
end

private
  def article_params
    params.require(:article).permit(:title, :text)
  end
```

The new method, `update`, is used when you want to update a record
that already exists, and it accepts a hash containing the attributes
that you want to update. As before, if there was an error updating the
article we want to show the form back to the user.

We reuse the `article_params` method that we defined earlier for the create
action.

TIP: It is not necessary to pass all the attributes to `update`. For example,
if `@article.update(title: 'A new title')` was called, Rails would only update
the `title` attribute, leaving all other attributes untouched.

Finally, we want to show a link to the `edit` action in the list of all the
articles, so let's add that now to `app/views/articles/index.html.erb` to make
it appear next to the "Show" link:

```html+erb
<table>
  <tr>
    <th>Title</th>
    <th>Text</th>
    <th colspan="2"></th>
  </tr>

  <% @articles.each do |article| %>
    <tr>
      <td><%= article.title %></td>
      <td><%= article.text %></td>
      <td><%= link_to 'Show', article_path(article) %></td>
      <td><%= link_to 'Edit', edit_article_path(article) %></td>
    </tr>
  <% end %>
</table>
```

And we'll also add one to the `app/views/articles/show.html.erb` template as
well, so that there's also an "Edit" link on an article's page. Add this at the
bottom of the template:

```html+erb
...

<%= link_to 'Edit', edit_article_path(@article) %> |
<%= link_to 'Back', articles_path %>
```

And here's how our app looks so far:

![Index action with edit link](images/getting_started/index_action_with_edit_link.png)

### Using partials to clean up duplication in views

Our `edit` page looks very similar to the `new` page; in fact, they
both share the same code for displaying the form. Let's remove this
duplication by using a view partial. By convention, partial files are
prefixed with an underscore.

TIP: You can read more about partials in the
[Layouts and Rendering in Rails](layouts_and_rendering.html) guide.

Create a new file `app/views/articles/_form.html.erb` with the following
content:

```html+erb
<%= form_with model: @article, local: true do |form| %>

  <% if @article.errors.any? %>
    <div id="error_explanation">
      <h2>
        <%= pluralize(@article.errors.count, "error") %> prohibited
        this article from being saved:
      </h2>
      <ul>
        <% @article.errors.full_messages.each do |msg| %>
          <li><%= msg %></li>
        <% end %>
      </ul>
    </div>
  <% end %>

  <p>
    <%= form.label :title %><br>
    <%= form.text_field :title %>
  </p>

  <p>
    <%= form.label :text %><br>
    <%= form.text_area :text %>
  </p>

  <p>
    <%= form.submit %>
  </p>

<% end %>
```

Everything except for the `form_with` declaration remained the same.
The reason we can use this shorter, simpler `form_with` declaration
to stand in for either of the other forms is that `@article` is a *resource*
corresponding to a full set of RESTful routes, and Rails is able to infer
which URI and method to use.
For more information about this use of `form_with`, see [Resource-oriented style]
(http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-form_with-label-Resource-oriented+style).

Now, let's update the `app/views/articles/new.html.erb` view to use this new
partial, rewriting it completely:

```html+erb
<h1>New article</h1>

<%= render 'form' %>

<%= link_to 'Back', articles_path %>
```

Then do the same for the `app/views/articles/edit.html.erb` view:

```html+erb
<h1>Edit article</h1>

<%= render 'form' %>

<%= link_to 'Back', articles_path %>
```

### Deleting Articles

We're now ready to cover the "D" part of CRUD, deleting articles from the
database. Following the REST convention, the route for
deleting articles as per output of `bin/rails routes` is:

```ruby
DELETE /articles/:id(.:format)      articles#destroy
```

The `delete` routing method should be used for routes that destroy
resources. If this was left as a typical `get` route, it could be possible for
people to craft malicious URLs like this:

```html
<a href='http://example.com/articles/1/destroy'>look at this cat!</a>
```

We use the `delete` method for destroying resources, and this route is mapped
to the `destroy` action inside `app/controllers/articles_controller.rb`, which
doesn't exist yet. The `destroy` method is generally the last CRUD action in
the controller, and like the other public CRUD actions, it must be placed
before any `private` or `protected` methods. Let's add it:

```ruby
def destroy
  @article = Article.find(params[:id])
  @article.destroy

  redirect_to articles_path
end
```

The complete `ArticlesController` in the
`app/controllers/articles_controller.rb` file should now look like this:

```ruby
class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
```

You can call `destroy` on Active Record objects when you want to delete
them from the database. Note that we don't need to add a view for this
action since we're redirecting to the `index` action.

Finally, add a 'Destroy' link to your `index` action template
(`app/views/articles/index.html.erb`) to wrap everything together.

```html+erb
<h1>Listing Articles</h1>
<%= link_to 'New article', new_article_path %>
<table>
  <tr>
    <th>Title</th>
    <th>Text</th>
    <th colspan="3"></th>
  </tr>

  <% @articles.each do |article| %>
    <tr>
      <td><%= article.title %></td>
      <td><%= article.text %></td>
      <td><%= link_to 'Show', article_path(article) %></td>
      <td><%= link_to 'Edit', edit_article_path(article) %></td>
      <td><%= link_to 'Destroy', article_path(article),
              method: :delete,
              data: { confirm: 'Are you sure?' } %></td>
    </tr>
  <% end %>
</table>
```

Here we're using `link_to` in a different way. We pass the named route as the
second argument, and then the options as another argument. The `method: :delete`
and `data: { confirm: 'Are you sure?' }` options are used as HTML5 attributes so
that when the link is clicked, Rails will first show a confirm dialog to the
user, and then submit the link with method `delete`.  This is done via the
JavaScript file `rails-ujs` which is automatically included in your
application's layout (`app/views/layouts/application.html.erb`) when you
generated the application. Without this file, the confirmation dialog box won't
appear.

![Confirm Dialog](images/getting_started/confirm_dialog.png)

TIP: Learn more about Unobtrusive JavaScript on
[Working With JavaScript in Rails](working_with_javascript_in_rails.html) guide.

Congratulations, you can now create, show, list, update and destroy
articles.

TIP: In general, Rails encourages using resources objects instead of
declaring routes manually. For more information about routing, see
[Rails Routing from the Outside In](routing.html).

Adding a Second Model
---------------------

It's time to add a second model to the application. The second model will handle
comments on articles.

### Generating a Model

We're going to see the same generator that we used before when creating
the `Article` model. This time we'll create a `Comment` model to hold
reference to an article. Run this command in your terminal:

```bash
$ bin/rails generate model Comment commenter:string body:text article:references
```

This command will generate four files:

| File                                         | Purpose                                                                                                |
| -------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| db/migrate/20140120201010_create_comments.rb | Migration to create the comments table in your database (your name will include a different timestamp) |
| app/models/comment.rb                        | The Comment model                                                                                      |
| test/models/comment_test.rb                  | Testing harness for the comment model                                                                 |
| test/fixtures/comments.yml                   | Sample comments for use in testing                                                                     |

First, take a look at `app/models/comment.rb`:

```ruby
class Comment < ApplicationRecord
  belongs_to :article
end
```

This is very similar to the `Article` model that you saw earlier. The difference
is the line `belongs_to :article`, which sets up an Active Record _association_.
You'll learn a little about associations in the next section of this guide.

The (`:references`) keyword used in the bash command is a special data type for models.
It creates a new column on your database table with the provided model name appended with an `_id`
that can hold integer values. To get a better understanding, analyze the
`db/schema.rb` file after running the migration.

In addition to the model, Rails has also made a migration to create the
corresponding database table:

```ruby
class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
```

The `t.references` line creates an integer column called `article_id`, an index
for it, and a foreign key constraint that points to the `id` column of the `articles`
table. Go ahead and run the migration:

```bash
$ bin/rails db:migrate
```

Rails is smart enough to only execute the migrations that have not already been
run against the current database, so in this case you will just see:

```bash
==  CreateComments: migrating =================================================
-- create_table(:comments)
   -> 0.0115s
==  CreateComments: migrated (0.0119s) ========================================
```

### Associating Models

Active Record associations let you easily declare the relationship between two
models. In the case of comments and articles, you could write out the
relationships this way:

* Each comment belongs to one article.
* One article can have many comments.

In fact, this is very close to the syntax that Rails uses to declare this
association. You've already seen the line of code inside the `Comment` model
(app/models/comment.rb) that makes each comment belong to an Article:

```ruby
class Comment < ApplicationRecord
  belongs_to :article
end
```

You'll need to edit `app/models/article.rb` to add the other side of the
association:

```ruby
class Article < ApplicationRecord
  has_many :comments
  validates :title, presence: true,
                    length: { minimum: 5 }
end
```

These two declarations enable a good bit of automatic behavior. For example, if
you have an instance variable `@article` containing an article, you can retrieve
all the comments belonging to that article as an array using
`@article.comments`.

TIP: For more information on Active Record associations, see the [Active Record
Associations](association_basics.html) guide.

### Adding a Route for Comments

As with the `welcome` controller, we will need to add a route so that Rails
knows where we would like to navigate to see `comments`. Open up the
`config/routes.rb` file again, and edit it as follows:

```ruby
resources :articles do
  resources :comments
end
```

This creates `comments` as a _nested resource_ within `articles`. This is
another part of capturing the hierarchical relationship that exists between
articles and comments.

TIP: For more information on routing, see the [Rails Routing](routing.html)
guide.

### Generating a Controller

With the model in hand, you can turn your attention to creating a matching
controller. Again, we'll use the same generator we used before:

```bash
$ bin/rails generate controller Comments
```

This creates five files and one empty directory:

| File/Directory                               | Purpose                                  |
| -------------------------------------------- | ---------------------------------------- |
| app/controllers/comments_controller.rb       | The Comments controller                  |
| app/views/comments/                          | Views of the controller are stored here  |
| test/controllers/comments_controller_test.rb | The test for the controller              |
| app/helpers/comments_helper.rb               | A view helper file                       |
| app/assets/javascripts/comments.coffee       | CoffeeScript for the controller          |
| app/assets/stylesheets/comments.scss         | Cascading style sheet for the controller |

Like with any blog, our readers will create their comments directly after
reading the article, and once they have added their comment, will be sent back
to the article show page to see their comment now listed. Due to this, our
`CommentsController` is there to provide a method to create comments and delete
spam comments when they arrive.

So first, we'll wire up the Article show template
(`app/views/articles/show.html.erb`) to let us make a new comment:

```html+erb
<p>
  <strong>Title:</strong>
  <%= @article.title %>
</p>

<p>
  <strong>Text:</strong>
  <%= @article.text %>
</p>

<h2>Add a comment:</h2>
<%= form_with(model: [ @article, @article.comments.build ], local: true) do |form| %>
  <p>
    <%= form.label :commenter %><br>
    <%= form.text_field :commenter %>
  </p>
  <p>
    <%= form.label :body %><br>
    <%= form.text_area :body %>
  </p>
  <p>
    <%= form.submit %>
  </p>
<% end %>

<%= link_to 'Edit', edit_article_path(@article) %> |
<%= link_to 'Back', articles_path %>
```

This adds a form on the `Article` show page that creates a new comment by
calling the `CommentsController` `create` action. The `form_with` call here uses
an array, which will build a nested route, such as `/articles/1/comments`.

Let's wire up the `create` in `app/controllers/comments_controller.rb`:

```ruby
class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
```

You'll see a bit more complexity here than you did in the controller for
articles. That's a side-effect of the nesting that you've set up. Each request
for a comment has to keep track of the article to which the comment is attached,
thus the initial call to the `find` method of the `Article` model to get the
article in question.

In addition, the code takes advantage of some of the methods available for an
association. We use the `create` method on `@article.comments` to create and
save the comment. This will automatically link the comment so that it belongs to
that particular article.

Once we have made the new comment, we send the user back to the original article
using the `article_path(@article)` helper. As we have already seen, this calls
the `show` action of the `ArticlesController` which in turn renders the
`show.html.erb` template. This is where we want the comment to show, so let's
add that to the `app/views/articles/show.html.erb`.

```html+erb
<p>
  <strong>Title:</strong>
  <%= @article.title %>
</p>

<p>
  <strong>Text:</strong>
  <%= @article.text %>
</p>

<h2>Comments</h2>
<% @article.comments.each do |comment| %>
  <p>
    <strong>Commenter:</strong>
    <%= comment.commenter %>
  </p>

  <p>
    <strong>Comment:</strong>
    <%= comment.body %>
  </p>
<% end %>

<h2>Add a comment:</h2>
<%= form_with(model: [ @article, @article.comments.build ], local: true) do |form| %>
  <p>
    <%= form.label :commenter %><br>
    <%= form.text_field :commenter %>
  </p>
  <p>
    <%= form.label :body %><br>
    <%= form.text_area :body %>
  </p>
  <p>
    <%= form.submit %>
  </p>
<% end %>

<%= link_to 'Edit', edit_article_path(@article) %> |
<%= link_to 'Back', articles_path %>
```

Now you can add articles and comments to your blog and have them show up in the
right places.

![Article with Comments](images/getting_started/article_with_comments.png)

Refactoring
-----------

Now that we have articles and comments working, take a look at the
`app/views/articles/show.html.erb` template. It is getting long and awkward. We
can use partials to clean it up.

### Rendering Partial Collections

First, we will make a comment partial to extract showing all the comments for
the article. Create the file `app/views/comments/_comment.html.erb` and put the
following into it:

```html+erb
<p>
  <strong>Commenter:</strong>
  <%= comment.commenter %>
</p>

<p>
  <strong>Comment:</strong>
  <%= comment.body %>
</p>
```

Then you can change `app/views/articles/show.html.erb` to look like the
following:

```html+erb
<p>
  <strong>Title:</strong>
  <%= @article.title %>
</p>

<p>
  <strong>Text:</strong>
  <%= @article.text %>
</p>

<h2>Comments</h2>
<%= render @article.comments %>

<h2>Add a comment:</h2>
<%= form_with(model: [ @article, @article.comments.build ], local: true) do |form| %>
  <p>
    <%= form.label :commenter %><br>
    <%= form.text_field :commenter %>
  </p>
  <p>
    <%= form.label :body %><br>
    <%= form.text_area :body %>
  </p>
  <p>
    <%= form.submit %>
  </p>
<% end %>

<%= link_to 'Edit', edit_article_path(@article) %> |
<%= link_to 'Back', articles_path %>
```

This will now render the partial in `app/views/comments/_comment.html.erb` once
for each comment that is in the `@article.comments` collection. As the `render`
method iterates over the `@article.comments` collection, it assigns each
comment to a local variable named the same as the partial, in this case
`comment` which is then available in the partial for us to show.

### Rendering a Partial Form

Let us also move that new comment section out to its own partial. Again, you
create a file `app/views/comments/_form.html.erb` containing:

```html+erb
<%= form_with(model: [ @article, @article.comments.build ], local: true) do |form| %>
  <p>
    <%= form.label :commenter %><br>
    <%= form.text_field :commenter %>
  </p>
  <p>
    <%= form.label :body %><br>
    <%= form.text_area :body %>
  </p>
  <p>
    <%= form.submit %>
  </p>
<% end %>
```

Then you make the `app/views/articles/show.html.erb` look like the following:

```html+erb
<p>
  <strong>Title:</strong>
  <%= @article.title %>
</p>

<p>
  <strong>Text:</strong>
  <%= @article.text %>
</p>

<h2>Comments</h2>
<%= render @article.comments %>

<h2>Add a comment:</h2>
<%= render 'comments/form' %>

<%= link_to 'Edit', edit_article_path(@article) %> |
<%= link_to 'Back', articles_path %>
```

The second render just defines the partial template we want to render,
`comments/form`. Rails is smart enough to spot the forward slash in that
string and realize that you want to render the `_form.html.erb` file in
the `app/views/comments` directory.

The `@article` object is available to any partials rendered in the view because
we defined it as an instance variable.

Deleting Comments
-----------------

Another important feature of a blog is being able to delete spam comments. To do
this, we need to implement a link of some sort in the view and a `destroy`
action in the `CommentsController`.

So first, let's add the delete link in the
`app/views/comments/_comment.html.erb` partial:

```html+erb
<p>
  <strong>Commenter:</strong>
  <%= comment.commenter %>
</p>

<p>
  <strong>Comment:</strong>
  <%= comment.body %>
</p>

<p>
  <%= link_to 'Destroy Comment', [comment.article, comment],
               method: :delete,
               data: { confirm: 'Are you sure?' } %>
</p>
```

Clicking this new "Destroy Comment" link will fire off a `DELETE
/articles/:article_id/comments/:id` to our `CommentsController`, which can then
use this to find the comment we want to delete, so let's add a `destroy` action
to our controller (`app/controllers/comments_controller.rb`):

```ruby
class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
```

The `destroy` action will find the article we are looking at, locate the comment
within the `@article.comments` collection, and then remove it from the
database and send us back to the show action for the article.


### Deleting Associated Objects

If you delete an article, its associated comments will also need to be
deleted, otherwise they would simply occupy space in the database. Rails allows
you to use the `dependent` option of an association to achieve this. Modify the
Article model, `app/models/article.rb`, as follows:

```ruby
class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 5 }
end
```

Security
--------

### Basic Authentication

If you were to publish your blog online, anyone would be able to add, edit and
delete articles or delete comments.

Rails provides a very simple HTTP authentication system that will work nicely in
this situation.

In the `ArticlesController` we need to have a way to block access to the
various actions if the person is not authenticated. Here we can use the Rails
`http_basic_authenticate_with` method, which allows access to the requested
action if that method allows it.

To use the authentication system, we specify it at the top of our
`ArticlesController` in `app/controllers/articles_controller.rb`. In our case,
we want the user to be authenticated on every action except `index` and `show`,
so we write that:

```ruby
class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @articles = Article.all
  end

  # snippet for brevity
```

We also want to allow only authenticated users to delete comments, so in the
`CommentsController` (`app/controllers/comments_controller.rb`) we write:

```ruby
class CommentsController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

  def create
    @article = Article.find(params[:article_id])
    # ...
  end

  # snippet for brevity
```

Now if you try to create a new article, you will be greeted with a basic HTTP
Authentication challenge:

![Basic HTTP Authentication Challenge](images/getting_started/challenge.png)

Other authentication methods are available for Rails applications. Two popular
authentication add-ons for Rails are the
[Devise](https://github.com/plataformatec/devise) rails engine and
the [Authlogic](https://github.com/binarylogic/authlogic) gem,
along with a number of others.


### Other Security Considerations

Security, especially in web applications, is a broad and detailed area. Security
in your Rails application is covered in more depth in
the [Ruby on Rails Security Guide](security.html).


What's Next?
------------

Now that you've seen your first Rails application, you should feel free to
update it and experiment on your own.

Remember you don't have to do everything without help. As you need assistance
getting up and running with Rails, feel free to consult these support
resources:

* The [Ruby on Rails Guides](index.html)
* The [Ruby on Rails Tutorial](http://railstutorial.org/book)
* The [Ruby on Rails mailing list](http://groups.google.com/group/rubyonrails-talk)
* The [#rubyonrails](irc://irc.freenode.net/#rubyonrails) channel on irc.freenode.net


Configuration Gotchas
---------------------

The easiest way to work with Rails is to store all external data as UTF-8. If
you don't, Ruby libraries and Rails will often be able to convert your native
data into UTF-8, but this doesn't always work reliably, so you're better off
ensuring that all external data is UTF-8.

If you have made a mistake in this area, the most common symptom is a black
diamond with a question mark inside appearing in the browser. Another common
symptom is characters like "Ã¼" appearing instead of "ü". Rails takes a number
of internal steps to mitigate common causes of these problems that can be
automatically detected and corrected. However, if you have external data that is
not stored as UTF-8, it can occasionally result in these kinds of issues that
cannot be automatically detected by Rails and corrected.

Two very common sources of data that are not UTF-8:

* Your text editor: Most text editors (such as TextMate), default to saving
  files as UTF-8. If your text editor does not, this can result in special
  characters that you enter in your templates (such as é) to appear as a diamond
  with a question mark inside in the browser. This also applies to your i18n
  translation files. Most editors that do not already default to UTF-8 (such as
  some versions of Dreamweaver) offer a way to change the default to UTF-8. Do
  so.
* Your database: Rails defaults to converting data from your database into UTF-8
  at the boundary. However, if your database is not using UTF-8 internally, it
  may not be able to store all characters that your users enter. For instance,
  if your database is using Latin-1 internally, and your user enters a Russian,
  Hebrew, or Japanese character, the data will be lost forever once it enters
  the database. If possible, use UTF-8 as the internal storage of your database.
