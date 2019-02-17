# Patch

Ini adalah patch Panduan bahasa inggris yang akan mencocokan dari veri satu ke versi lainnya.

## Memulai
Fungsi ini akan mengambil beberapa sumber dari repository Rails.
Rubahlah `5-2-stable` dengan versi stable yang diinginkan.

##### Clone dan ambil beberapa sumber dari Rails
```bash
cd /path/repository/rails-id/guide # masuk ke dir repository guides
cd ..
git clone https://github.com/rails/rails.git
cd rails
git branch --track origin/5-2-stable
git checkout 5-2-stable
# INGAT: Saat menyalin, branch di guide dengan rails harus sama
cp guides/source/*.md ../guides/.patch/5-2-stable -R
```

##### Diff patch
```
diff -u 5-2-stable/getting_started.md 6-0-stable/getting_started.md > patch/5-2-stable@6-0-stable/getting_started.patch
```
