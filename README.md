# Panduan Ruby on Rails Indonesia

[![Country](https://img.shields.io/badge/country-indonesia-blue.svg)](https://en.wikipedia.org/wiki/Indonesia)
[![Build Status](https://travis-ci.org/rails-id/guides.svg)](https://travis-ci.org/rails-id/guides)

Repositori ini adalah hasil dari apa yang ada di situs web:
- [guides.rails.id](http://guides.rails.id) versi stabil.
- [edgeguides.rails.id](http://edgeguides.rails.id) versi edge di branch master.

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

	Sedang dikerjakan untuk panduan Rails versi 5-2-stable ini.

## Transfer

##### master
- Repositori: [rails/rails](https://github.com/rails/rails/commits/master/guides) => [1c5e2f9](https://github.com/rails/rails/commit/1c5e2f9)
- SHA1: `1c5e2f9b98bc5b50ac990d6f1b0ae9df59580444`

##### 5-2-stable
- Repositori: [rails/rails](https://github.com/rails/rails/commits/5-2-stable/guides) => [bd24ef6](https://github.com/rails/rails/commit/bd24ef6)
- SHA1: `bd24ef67ff2cb2d378371db25bf65e6afe19cebb`

## Sumber Konten

Secara umum konten panduan Ruby on Rails berada didirektori [source](source), lakukan perubahan pada panduan konten tersebut untuk berkontrbusi.

## Kontribusi

[![Contributors](https://img.shields.io/github/contributors/rails-id/guides.svg)](https://github.com/rails-id/guides/graphs/contributors)

Jika kalian melihat kesalahan pengejaan atau versi terbaru tidak sinkron, silakan untuk berkontribusi.

Bagi member organisasi Ruby on Rails Indonesia bisa kontribusi langsung di remote `git@github.com:rails-id/guides.git`

```
$ git clone -b $BRANCH git@github.com:rails-id/guides.git
```

Bagi non member Ruby on Rails Indonesia silakan untuk fork repositori ini, dan melakukan pull request.

```
$ git clone -b $BRANCH git@github.com:$USERNAME/$NAME_OF_REPOSITORY.git
```

Selengkapnya bisa lihat di [Kontribusi](CONTRIBUTING.md) dan diharapkan untuk mengikuti [Kode Etik](CODE_OF_CONDUCT.md).

## Referensi
- [github.com/rails/rails/tree/master/guides](https://github.com/rails/rails/tree/master/guides)

## Lisensi

[![License](https://img.shields.io/github/license/rails-id/guides.svg)](LICENSE)

Ruby on Rails Indonesia dirilis di bawah [Lisensi MIT](https://opensource.org/licenses/MIT).
