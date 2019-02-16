<h1 align="center">Panduan Ruby on Rails Indonesia</h1>

<p align="center">
  <a href="http://guides.rails.id">
    <img src="https://user-images.githubusercontent.com/3952281/52688710-1c66c400-2f8a-11e9-82a9-b5827bc9ccc9.png" alt="Rails Indonesia">
  </a>
</p>

<p align="center">
  Repositori ini adalah hasil dari apa yang ada di situs web:
  <br>
  <a href="http://guides.rails.id">
    <strong>Guides</strong>
  </a>
  •
  <a href="http://edgeguides.rails.id">
    <strong>Edge Guides</strong>
  </a>
</p>


## Status
[![Country](https://img.shields.io/badge/country-indonesia-blue.svg)](https://en.wikipedia.org/wiki/Indonesia)
[![Build Status](https://travis-ci.org/rails-id/guides.svg)](https://travis-ci.org/rails-id/guides)
[![Contributors](https://img.shields.io/github/contributors/rails-id/guides.svg)](https://github.com/rails-id/guides/graphs/contributors)
[![License](https://img.shields.io/github/license/rails-id/guides.svg)](LICENSE)
[![GitHub last commit](https://img.shields.io/github/last-commit/rails-id/guides.svg)](https://github.com/rails-id/guides/commits/master)
[![GitHub issues](https://img.shields.io/github/issues/rails-id/guides.svg)](https://github.com/rails-id/guides/issues)


## Petunjuk Umum
##### Tidak lupa untuk bundle sumber Gemfile:
```
$ bundle install
```

##### Mengenerate hasil sumber:
```
$ rake guides:generate:html
```

##### Jalankan output dengan web server:
```
$ ruby -run -e httpd output -p 4000
```

##### Selengkapnya kalian bisa melihat di rake:
```
$ rake
```

## Versi

##### File terjemah
- Semua file di direktori `source` yang berektensi Markdown (.md) dan file `documents.yaml`.
- Tapi jika kalian melihat sesuatu redaksional ada yang belum cocok dengan bahasa indonesia, silakan untuk diterjemahkan.

##### Branch
- **master**

	Jika kalian telah menerjemahkan dari branch master jangan sungkan untuk mention member Rails Indonesia, karena perubahan terjemahan akan di cocokan kembali dengan panduan dari [Rails](https://github.com/rails/rails/tree/master/guides) resmi sampai rilisnya Rails versi 6.

- **5-2-stable**

	Sedang di kerjakan untuk panduan Rails versi 5-2-stable ini.

## Transfer

##### master
- Repositori: [rails/rails](https://github.com/rails/rails/commits/master/guides) => [1c5e2f9](https://github.com/rails/rails/commit/1c5e2f9)
- SHA1: `1c5e2f9b98bc5b50ac990d6f1b0ae9df59580444`

##### 5-2-stable
- Repositori: [rails/rails](https://github.com/rails/rails/commits/5-2-stable/guides) => [bd24ef6](https://github.com/rails/rails/commit/bd24ef6)
- SHA1: `bd24ef67ff2cb2d378371db25bf65e6afe19cebb`

## Sumber Konten

Secara umum konten panduan Ruby on Rails berada di direktori [source](source), lakukan perubahan pada panduan konten tersebut untuk berkontrbusi.

## Kontribusi

Jika kalian melihat kesalahan pengejaan atau versi terbaru tidak sinkron, silakan untuk berkontribusi.

Bagi member organisasi Ruby on Rails Indonesia bisa kontribusi langsung di remote `git@github.com:rails-id/guides.git`

```
$ git clone -b $BRANCH git@github.com:rails-id/guides.git
```

Bagi non member organisasi Ruby on Rails Indonesia silakan untuk fork repositori ini, melakukan perubahan, dan melakukan pull request.

```
$ git clone -b $BRANCH git@github.com:$USERNAME/$NAME_OF_REPOSITORY.git
```

Selengkapnya bisa lihat di [Kontribusi](CONTRIBUTING.md) dan diharapkan untuk mengikuti [Kode Etik](CODE_OF_CONDUCT.md).

# Pedoman Panduan

Untuk dapat berkontribusi dengan baik diharapkan Kalian bisa membaca dan memahami [Pedoman Panduan](GUIDELINES.md), ini adalah standar supaya Panduan tetap terdokumentasi dengan baik, benar dan rapi.

## Referensi
- [github.com/rails/rails/tree/master/guides](https://github.com/rails/rails/tree/master/guides)

## Script Tambahan

Ini hanya informasi saja, kalain tidak perlu melakukan ini, karena ini telah ditambahkan di repositori ini.

Membuat file di `assets/stylesheets/utility.css`
``` css
.contribute-to-github {
  text-align: center;
  margin: 5rem auto;
}
.contribute-to-github a {
  font-size: 1.1rem;
  color: #fff !important;
  background-color: #cc0000;
  padding: 1.25rem 3rem;
  border-radius: 10px;
  text-decoration: none;
}
.contribute-to-github a:hover {
  opacity: 0.8;
  text-decoration: none;
}
```

Membuat file di `assets/javascripts/utility.js`

  Untuk Guide Rails versi 6 ke atas:
  ``` js
  document.addEventListener("turbolinks:load", function() {
    $('#feedback').prepend("<section class=\"contribute-to-github\">\n" +
      "  <a href=\"https://github.com/rails-id/guides\" target=\"_blank\">Kontribusi panduan ini di GitHub</a>\n" +
      "</section>");
  })
  ```

  Untuk Guide Rails versi 5:
  ``` js
  $('#feedback').prepend("<section class=\"contribute-to-github\">\n" +
    "  <a href=\"https://github.com/rails-id/guides\" target=\"_blank\">Kontribusi panduan ini di GitHub</a>\n" +
    "</section>");
  ```

Menambah kode file di `source/layout.html.erb` untuk stylesheet dan javascript
``` html
<link rel="stylesheet" href="stylesheets/utility.css">
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="javascripts/utility.js"></script>
```

Menambah `id` di `source/layout.html.erb` untuk bagian Feedback atau Masukan
``` html
<h3 id="feedback">Masukan</h3>
```

## Lisensi

Ruby on Rails Indonesia dirilis di bawah [Lisensi MIT](https://opensource.org/licenses/MIT).
