# Kontribusi

- Diharapkan sebelum berkontribusi kalian harus sudah mengikuti [Kode Etik](CODE_OF_CONDUCT.md).
- Setiap kontributor harus memiliki konfigurasi git dengan akun Github yang valid.
  - Ref: [Why are my commits linked to the wrong user?](https://help.github.com/articles/why-are-my-commits-linked-to-the-wrong-user/)
- Pastikan pengaturan waktu / tanggal pada device kalian sudah sesuai dan benar.

## Panduan Git

##### Untuk mengambil beberapa branch di remote Github ke local kalian lakukan contoh dibawah:
``` bash
git branch --track origin/action-cable-overview # akan mendapatkan branch `action-cable-overview` dari remote origin
```

##### Untuk menggabungkan file yang baru saja di rubah ke branch lain:
``` bash
git checkout 5-2-stable # pindah dulu ke branch 5-2-stable
git checkout --patch action-cable-overview source/action_cable_overview.md # tambahkan file dari branch action-cable-overview ke branch 5-2-stable
```

Kalian nanti akan disajikan diff patch, kalau setuju tekan `y` dan [ENTER]
Nanti akan dapat perubahan, dan cek menggunakan:

``` bash
git status
```

##### Jika kalian ingin menambahkan beberapa file ke stabil versi:
``` bash
git checkout 5-2-stable
git checkout action-cable-overview -- file.md
```

##### Jika kalian ingin membatalkan perubahan di file tertentu:
``` bash
git checkout HEAD -- file.md
```

## Branchs
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
