# Pedoman

## Pedoman Penulisan
- Gunakan kosakata yang mudah dipahami.
- Gunakan kapital di awal kalimat atau paragraf dan setelah titik jika beberapa kalimat dalam 1 paragraf, kapital ini tidak berlaku untuk koma kecuali kata tersebut menunjukkan objek.
- Jika kalian menggunakan Google Translate, mohon untuk dikoreksi kembali dan di-improve kata dan kalimatnya supaya lebih baik.
- Direkomendasikan untuk improve kata atau kalimat. Contohnya:
	- Yang tadinya seperti ini:
	``` markdown
	File ini berisi versi Ruby secara default
	```

	- Bisa menjadi seperti ini:
	```
	File ini berisi versi Ruby yang digunakan secara default
	```

- Gunakan kata EYD yang sesuai. Contohnya:
	- Yang benar __Silakan__ bukan __Silahkan__
- Penggunaan [Preposisi](https://id.wikipedia.org/wiki/Preposisi) dengan benar.
- Gunakan __Kamu__, __Kalian__, __Teman-teman__ sebagai sapaan.
- Tidak diperbolehkan untuk me-rename file ataupun folder source.
- URL tidak diterjemahkan.
- Istilah dalam aplikasi Rails tidak perlu diterjemahkan. Contohnya:
	- __Active Record__ tidak perlu menjadi __Rekaman Aktif__
	- __Action View__ tidak perlu menjadi __Tampilan Aksi__ atau __Pemandangan Aksi__
- Berlaku juga untuk istilah dalam Ruby, tidak perlu diterjemahkan untuk contoh penamaan seperti: `Syntax`, `Class`, `Object`, `Variable`, `Constant`, `Operator`, `Method`, `Module` dan lain sebagainya.
- Contoh kode didalam block tidak perlu diterjemahkan, ini berhubungan dengan poin diatas, kecuali komentar. Contohnya:

	Contoh yang salah:
	``` ruby
	# biarkan Active Record mencari tahu nama kolom
	remove_foreign_key :rekenings, :cabangs
	```

	Contoh yang benar:
	``` ruby
	# biarkan Active Record mencari tahu nama kolom
	remove_foreign_key :accounts, :branches
	```

- Word Wrap tidak boleh memanjang lebih dari 125-130 karakter, kecuali mengandung karakter URL.

	Contoh yang salah:
	```
	Lorem ipsum dolor sit amet, consectetur adipisicing elit. Non molestiae doloribus aperiam a iure sequi earum inventore cum quis nulla dolorem odit velit consequatur ipsa reiciendis aspernatur perspiciatis, harum consequuntur!
	```

	Contoh yang benar:
	```
	Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
	tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
	quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
	consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
	cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
	proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
	```


## Pedoman Git

##### Untuk mengambil beberapa branch di remote Github ke local kalian lakukan contoh dibawah:
``` bash
git branch --track origin/action-cable-overview # akan mendapatkan branch `action-cable-overview` dari remote origin
```

##### Untuk menggabungkan file yang baru saja diubah ke branch lain:
``` bash
git checkout 5-2-stable # pindah dulu ke branch 5-2-stable
git checkout --patch action-cable-overview source/action_cable_overview.md # tambahkan file dari branch action-cable-overview ke branch 5-2-stable
```

Kalian nanti akan disajikan diff patch, kalau setuju tekan `y` dan `[ENTER]`
Nanti akan dapat perubahan, dan cek menggunakan:

``` bash
git status # melihat status perubahan
```

##### Jika kalian ingin menambahkan beberapa file ke stabil versi:
``` bash
git checkout 5-2-stable # pindah ke branch 5-2-stable
git checkout action-cable-overview -- contoh.md # menambahkan contoh.md dari branch action-cable-overview ke branch 5-2-stable
```

##### Jika kalian ingin membatalkan perubahan di file tertentu:
``` bash
git checkout HEAD -- contoh.md # akan me-reset file contoh.md
```


## Daftar Branch

Kalian bisa melihat daftar branch yang tersedia dengan perintah berikut:

``` bash
git branch -r
```

##### Daftar Master dan Stable
```
master
5-2-stable
```

##### Daftar branch dengan nama guide source
```
2-2-release-notes
2-3-release-notes
3-0-release-notes
3-1-release-notes
3-2-release-notes
4-0-release-notes
4-1-release-notes
4-2-release-notes
5-0-release-notes
5-1-release-notes
5-2-release-notes
6-0-release-notes
action-cable-overview
action-controller-overview
action-mailbox-basics
action-mailer-basics
action-text-overview
action-view-overview
active-job-basics
active-model-basics
active-record-basics
active-record-callbacks
active-record-migrations
active-record-postgresql
active-record-querying
active-record-validations
active-storage-overview
active-support-core-extensions
active-support-instrumentation
api-app
api-documentation-guidelines
asset-pipeline
association-basics
autoloading-and-reloading-constants
caching-with-rails
command-line
configuring
contributing-to-ruby-on-rails
debugging-rails-applications
development-dependencies-install
documents
engines
form-helpers
generators
getting-started
i18n
initialization
layouts-and-rendering
maintenance-policy
plugins
rails-application-templates
rails-on-rack
routing
ruby-on-rails-guides-guidelines
security
testing
threading-and-code-execution
upgrading-ruby-on-rails
working-with-javascript-in-rails
```
